# Universal Network Resource Fetcher

![Shell Script](https://img.shields.io/badge/language-Shell-blue)

## Description
**Universal Network Resource Fetcher** is an interactive text-based user interface (TUI) shell script that provides various network utilities in a single tool. Designed for WSL or Kali Linux, it supports file downloads, public IP checks, network interface monitoring, latency measurement, port scanning, traceroute, Google Drive direct link generation, and YouTube video downloads with quality selection.

## Objectives
- Create an automated, interactive tool for basic and intermediate network administration tasks.
- Integrate common network commands into a single interactive menu.
- Provide activity logging for auditing and debugging.

## Features
| No | Function                    | Description                                                                 |
|----|-----------------------------|-----------------------------------------------------------------------------|
| 1  | show_menu                   | Displays an interactive text-based menu.                                    |
| 2  | log_result                  | Logs activities to `resource_fetcher.log`.                                  |
| 3  | check_connectivity          | Checks host connectivity using `ping`.                                      |
| 4  | download_file               | Downloads files from URLs, including Google Drive support.                  |
| 5  | check_public_ip             | Retrieves public IP using ipify.org API.                                    |
| 6  | monitor_interface           | Displays status and IP of network interfaces using `ip`.                    |
| 7  | check_latency               | Measures latency to hosts using `ping`.                                     |
| 8  | scan_ports                  | Scans open ports on a host using `nmap`.                                    |
| 9  | generate_gdrive_direct_link | Generates direct download links from Google Drive file IDs.                 |
| 10 | traceroute_to_host          | Performs traceroute to a specified host using `traceroute`.                 |
| 11 | download_youtube_video      | Downloads YouTube videos with quality selection using `yt-dlp`.             |
| 12 | list_downloaded_files       | Lists downloaded files in the `output` directory.                           |
| 13 | check_ssl_certificate       | Checks SSL certificate details for a domain using `openssl`.                |

## Prerequisites
- WSL or Kali Linux
- Dependencies:
  - `curl`
  - `nmap`
  - `traceroute`
  - `yt-dlp`
  - `openssl`

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/username/network-resource-fetcher.git


Navigate to the project directory:cd network-resource-fetcher


Make the script executable:chmod +x resource_fetcher.sh


Install dependencies:sudo apt update
sudo apt install curl nmap traceroute yt-dlp openssl


Run the script:./resource_fetcher.sh



Usage

Run the script and select an option (1-11) from the interactive menu.
Example usage:=== Universal Network Resource Fetcher ===
1. Download File from URL
2. Check Public IP
...
8. Download YouTube Video
...
Pilih opsi (1-11): 8
Enter YouTube video URL: https://www.youtube.com/watch?v=R3GfuzLMPkA
Fetching available video formats...
Select video quality:
1. 160 - 256x144 - https - |
2. 133 - 426x240 - https - |
3. 134 - 640x360 - h
4. 135 - 854x480 - https - |
5. 136 - 1280x720 - https - |
6. 137 - 1920x1080 - https - |
Enter format number (1, 2, 3, etc.): 5
Downloading video from https://www.youtube.com/watch?v=R3GfuzLMPkA with format 136...
Video downloaded successfully!



Logging

All activities are logged to resource_fetcher.log in the output directory.
Example log entry:[2025-06-08 16:21:00] YouTube Download: https://www.youtube.com/watch?v=R3GfuzLMPkA with format 136 - SUCCESS



Notes

Ensure a stable internet connection for functions like file downloads, public IP checks, and YouTube video downloads.
Some YouTube video formats may be unavailable due to DRM protection. Try lower resolutions (e.g., 720p or 1080p) if download fails.
To view available video formats, run:yt-dlp -F <YouTube_URL>



Contributing

Fork the repository.
Create a new branch: git checkout -b feature/new-feature.
Commit changes: git commit -m "Add new feature".
Push to the branch: git push origin feature/new-feature.
Create a Pull Request on GitHub.

License
MIT License



### Instructions to Use README
1. **Save README**:
   - Copy the content above into a file named `README.md` in your project directory (`~/network_project`).
   - Example:
     ```bash
     nano README.md
     ```
     Paste the content, save (`Ctrl+O`, `Enter`, `Ctrl+X`).

2. **Push to GitHub**:
   - Add and commit the file:
     ```bash
     git add README.md
     git commit -m "Add README for Universal Network Resource Fetcher"
     git push origin main
     ```
   - Replace `username` in the repository URL (`https://github.com/username/network-resource-fetcher`) with your GitHub username.

3. **Customize**:
   - Replace `[Your Name]` and `https://github.com/username` in the **Developer** section with your details.
   - Add additional badges (e.g., build status) using [shields.io](https://shields.io/) if desired.

### Notes
- The README is tailored to your project, incorporating details from your report and script, including the feature table and example output.
- It includes clear installation and usage instructions, making it accessible for users.
- If you want to automate README generation using a tool like `readme-ai`, install it with `pip install readmeai` and run:
  ```bash
  readmeai --repository https://github.com/username/network-resource-fetcher --output README.md


For cron scheduling (noted as missing in your report), consider adding a function or GitHub Actions workflow as mentioned in previous responses.

Let me know if you need further tweaks to the README or help with additional features!
