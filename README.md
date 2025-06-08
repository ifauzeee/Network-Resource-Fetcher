Universal Network Resource Fetcher
A powerful Bash script for network resource fetching, monitoring, and logging, optimized for WSL Kali Linux.
🌟 Features

File Download: Fetch files from URLs, including Google Drive links.
Public IP Check: Retrieve your public IP address.
Network Monitoring: Monitor network interface status and IP assignments.
Latency Testing: Measure latency to multiple hosts.
Port Scanning: Scan ports on a specified host using nmap.
Google Drive Links: Generate direct download links for Google Drive files.
Traceroute: Perform traceroute to analyze network paths.
YouTube Video Download: Download YouTube videos with selectable formats using yt-dlp.
File Listing: Display downloaded files in the output directory.
SSL Certificate Check: Verify SSL certificate details for a domain.
Logging: Log all activities with timestamps in resource_fetcher.log.

📋 Requirements

WSL Kali Linux environment
Installed tools: curl, nmap, yt-dlp, openssl, traceroute
Active internet connection

🚀 Installation

Clone the repository:git clone https://github.com/ifauzeee/Network-Resource-Fetcher.git


Navigate to the project directory:cd Network-Resource-Fetcher


Make the script executable:chmod +x resource_fetcher.sh


Install dependencies:sudo apt update
sudo apt install curl nmap yt-dlp traceroute openssl



🛠️ Usage

Run the script:./resource_fetcher.sh


Choose an option (1-11) from the interactive Text User Interface (TUI).
Follow the prompts to execute the desired function.
Check the output directory for downloaded files and resource_fetcher.log for logs.

Example: Downloading a File

Select option 1 from the menu.
Enter a URL (e.g., http://example.com/file.txt or a Google Drive link).
The file will be saved in the output directory, and the activity logged.

📝 Notes

Ensure network connectivity for functions like downloads and latency checks.
For YouTube downloads, run yt-dlp -F <URL> to list available formats if errors occur.
Google Drive downloads require a valid file ID or shareable link.
Logs are appended to resource_fetcher.log for tracking and debugging.

📄 License
This project is licensed under the MIT License. See LICENSE for details.
🤝 Contributing

Fork the repository.
Create a feature branch:git checkout -b feature/your-feature


Commit your changes:git commit -m "Add your feature"


Push to the branch:git push origin feature/your-feature


Open a pull request.

👤 Author
IfauzeeeCreated: June 4, 2025  

⭐ Star this repository if you find it useful!📧 For issues or suggestions, open an issue on GitHub.
