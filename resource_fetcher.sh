#!/bin/bash
# Script: Universal Network Resource Fetcher
# Deskripsi: Mengambil sumber daya jaringan, mencatat aktivitas, dan memantau jaringan di WSL Kali Linux
# Tanggal: 2025-06-04

# Fungsi untuk menampilkan menu TUI
show_menu() {
    echo "=== Universal Network Resource Fetcher ==="
    echo "1. Unduh File dari URL"
    echo "2. Cek IP Publik"
    echo "3. Pantau Status Antarmuka Jaringan"
    echo "4. Cek Latensi Jaringan ke Beberapa Host"
    echo "5. Scan Port pada Host"
    echo "6. Generate Direct Link Google Drive"
    echo "7. Traceroute ke Host"
    echo "8. Unduh Video YouTube"
    echo "9. Tampilkan File yang Diunduh"
    echo "10. Cek Sertifikat SSL"
    echo "11. Keluar"
    read -p "Pilih opsi (1-11): " choice
}

# Fungsi untuk mencatat hasil ke log
log_result() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] $message" >> resource_fetcher.log
}

# Fungsi untuk cek konektivitas
check_connectivity() {
    local target="$1"
    echo "Mengecek konektivitas ke $target..."
    if ping -c 2 "$target" > /dev/null 2>&1; then
        echo "Koneksi ke $target BERHASIL!"
        log_result "Koneksi ke $target: BERHASIL"
        return 0
    else
        echo "Koneksi ke $target GAGAL!"
        log_result "Koneksi ke $target: GAGAL"
        return 1
    fi
}

# Fungsi untuk unduh file (diperbarui untuk Google Drive)
download_file() {
    read -p "Masukkan URL file (contoh: http://example.com/file.txt): " url
    local host=$(echo "$url" | sed 's|http[s]*://\([^/]*\).*|\1|')

    if check_connectivity "$host"; then
        echo "Mengunduh file dari $url..."

        if [[ "$url" == *"drive.google.com"* ]]; then
            file_id=$(echo "$url" | grep -oE 'id=[^&]+' | cut -d'=' -f2)
            echo "Mendeteksi file dari Google Drive dengan ID: $file_id"
            
            # Tahap 1: ambil token konfirmasi
            confirm_code=$(curl -sc /tmp/gcookie "https://drive.google.com/uc?export=download&id=$file_id" | \
                grep -o 'confirm=[^&]*' | cut -d= -f2)

            # Tahap 2: unduh file menggunakan token konfirmasi
            curl -Lb /tmp/gcookie "https://drive.google.com/uc?export=download&confirm=${confirm_code}&id=${file_id}" -O -J

            # Cek apakah file berhasil diunduh
            if [ $? -eq 0 ]; then
                echo "File berhasil diunduh dari Google Drive!"
                log_result "Unduh file GDrive ID $file_id: BERHASIL"
            else
                echo "Gagal mengunduh file dari Google Drive!"
                log_result "Unduh file GDrive ID $file_id: GAGAL"
            fi
        else
            filename=$(basename "$url")
            curl -LO "$url"
            if [ -f "$filename" ]; then
                echo "File $filename berhasil diunduh!"
                log_result "Unduh file $filename dari $url: BERHASIL"
            else
                echo "Gagal mengunduh file!"
                log_result "Unduh file dari $url: GAGAL"
            fi
        fi
    fi
}

# Fungsi lainnya
check_public_ip() {
    echo "Mengambil IP publik..."
    ip=$(curl -s http://api.ipify.org)
    if [ -n "$ip" ]; then
        echo "IP Publik: $ip"
        log_result "IP Publik: $ip"
    else
        echo "Gagal mengambil IP publik!"
        log_result "IP Publik: GAGAL"
    fi
}

monitor_interface() {
    echo "Memantau status antarmuka jaringan..."
    interfaces=$(ip link show | awk '/^[0-9]+:/ {print $2}' | sed 's/://')
    if [ -n "$interfaces" ]; then
        echo "Antarmuka jaringan ditemukan:"
        for iface in $interfaces; do
            status=$(ip link show "$iface" | grep -o 'state [A-Z]\+' | awk '{print $2}')
            ip_addr=$(ip addr show "$iface" | grep 'inet ' | awk '{print $2}' | sed 's/\/.*//')
            if [ -n "$ip_addr" ]; then
                echo "Antarmuka: $iface, Status: $status, IP: $ip_addr"
                log_result "Antarmuka: $iface, Status: $status, IP: $ip_addr"
            else
                echo "Antarmuka: $iface, Status: $status, IP: Tidak ditemukan"
                log_result "Antarmuka: $iface, Status: $status, IP: Tidak ditemukan"
            fi
        done
    else
        echo "Tidak ada antarmuka jaringan ditemukan!"
        log_result "Antarmuka jaringan: Tidak ditemukan"
    fi
}

check_latency() {
    echo "Mengecek latensi jaringan ke beberapa host..."
    read -p "Masukkan host (pisahkan dengan spasi): " hosts
    for host in $hosts; do
        if check_connectivity "$host"; then
            latency=$(ping -c 4 "$host" | awk '/rtt/ {print $4}' | cut -d '/' -f 2)
            echo "Latensi rata-rata ke $host: $latency ms"
            log_result "Latensi ke $host: $latency ms"
        fi
    done
}

scan_ports() {
    read -p "Masukkan host: " host
    read -p "Masukkan rentang port (contoh 1-100): " port_range
    if check_connectivity "$host"; then
        echo "Memindai port $port_range pada $host..."
        output=$(nmap -p "$port_range" "$host")
        echo "$output"
        log_result "Hasil scan port $host: $port_range"
    fi
}

generate_gdrive_direct_link() {
    read -p "Masukkan Google Drive file ID: " file_id
    echo "https://drive.google.com/uc?export=download&id=$file_id"
    log_result "Generate link GDrive untuk ID $file_id"
}

traceroute_to_host() {
    read -p "Masukkan host: " host
    output=$(traceroute "$host")
    echo "$output"
    log_result "Traceroute ke $host: $output"
}

download_youtube_video() {
    read -p "Masukkan URL video YouTube: " url
    echo "Mengambil daftar format video yang tersedia..."

    # Ambil daftar format menggunakan yt-dlp, filter hanya format mp4 yang tidak dilindungi DRM
    formats=$(yt-dlp -F "$url" | grep -E 'video.*mp4' | grep -v 'DRM' | awk '{print NR ". " $1 " - " $3 " - " $8 " - " $9}' | grep -v 'm3u8')

    if [ -z "$formats" ]; then
        echo "Gagal mengambil daftar format atau tidak ada format mp4 yang tersedia!"
        log_result "Unduh YouTube: Gagal mengambil format untuk $url"
        return
    fi

    echo "Pilih kualitas video:"
    echo "$formats"
    read -p "Masukkan nomor format (1, 2, 3, dst.): " format_choice

    # Ambil format ID berdasarkan pilihan pengguna
    selected_format=$(echo "$formats" | grep "^$format_choice\." | awk '{print $2}')

    if [ -z "$selected_format" ]; then
        echo "Pilihan format tidak valid!"
        log_result "Unduh YouTube: Pilihan format tidak valid untuk $url"
        return
    fi

    echo "Mengunduh video dari $url dengan format $selected_format..."
    yt-dlp -f "$selected_format" "$url" --no-warnings

    if [ $? -eq 0 ]; then
        echo "Video berhasil diunduh!"
        log_result "Unduh YouTube: $url dengan format $selected_format - BERHASIL"
    else
        echo "Gagal mengunduh video! Coba format lain atau periksa URL."
        log_result "Unduh YouTube: $url dengan format $selected_format - GAGAL"
        echo "Gunakan perintah 'yt-dlp -F $url' untuk melihat daftar format yang tersedia."
    fi
}

list_downloaded_files() {
    echo "Daftar file di direktori:"
    ls -lh
    log_result "List file unduhan ditampilkan"
}

check_ssl_certificate() {
    read -p "Masukkan domain: " domain
    echo | openssl s_client -servername "$domain" -connect "$domain:443" 2>/dev/null | openssl x509 -noout -dates
    log_result "Cek sertifikat SSL untuk $domain"
}

# Siapkan direktori output
mkdir -p output
cd output

# Loop utama
while true; do
    show_menu
    case "$choice" in
        1) download_file;;
        2) check_public_ip;;
        3) monitor_interface;;
        4) check_latency;;
        5) scan_ports;;
        6) generate_gdrive_direct_link;;
        7) traceroute_to_host;;
        8) download_youtube_video;;
        9) list_downloaded_files;;
        10) check_ssl_certificate;;
        11)
            echo "Keluar dari program."
            log_result "Program ditutup"
            exit 0
            ;;
        *) 
            echo "Pilihan tidak valid!"
            log_result "Pilihan tidak valid: $choice"
            ;;
    esac
    echo ""
done