Universal Network Resource Fetcher
A Bash script for network resource fetching, monitoring, and logging, designed for WSL Kali Linux.
Features

Download files from URLs (including Google Drive)
Check public IP address
Monitor network interfaces
Measure latency to multiple hosts
Scan ports on a host
Generate Google Drive direct download links
Perform traceroute to a host
Download YouTube videos with selectable formats
List downloaded files
Check SSL certificates
Log all activities with timestamps

Requirements

WSL Kali Linux environment
Installed tools: curl, nmap, yt-dlp, openssl, traceroute
Internet connection

Installation

Clone the repository:git clone hgit clone https://github.com/username/network-resource-fetcher.git


Navigate to the project directory:cd universal-network-resource-fetcher


Make the script executable:chmod +x resource_fetcher.sh


Install dependencies (if not already installed):sudo apt update
sudo apt install curl nmap yt-dlp traceroute openssl



Usage

Run the script:./resource_fetcher.sh


Select an option from the TUI menu (1-11).
Follow the prompts to execute the desired function.
Logs are saved in resource_fetcher.log in the output directory.
Downloaded files are stored in the output directory.

Example
To download a file:

Select option 1 from the menu.
Enter the URL (e.g., http://example.com/file.txt or a Google Drive link).
The file will be downloaded to the output directory, and the activity will be logged.

Notes

Ensure network connectivity before running network-dependent functions.
For YouTube downloads, use yt-dlp -F <URL> to check available formats if issues arise.
Google Drive downloads require a valid file ID or shareable link.
Logs are appended to resource_fetcher.log for auditing.

License
MIT License. See LICENSE for details.
Contributing

Fork the repository.
Create a feature branch (git checkout -b feature-branch).
Commit changes (git commit -m 'Add feature').
Push to the branch (git push origin feature-branch).
Open a pull request.

Author
Muhammad Ibnu Fauzi
Created: June 4, 2025