# Task 1 — Basic Network Scanning with Nmap

**Intern:** Vimalraaj R  
**Track:** Security Analyst  
**Environment:** Windows 11 PowerShell scanning one Kali/Ubuntu VM on a VirtualBox Host-Only network.

## Objective
Identify open ports and services on a local VM, perform service-version and OS detection, and explain the security implications of the services actually observed.

## What is Nmap?
Nmap (Network Mapper) is an open-source network discovery and security-auditing tool. It can identify reachable hosts, open ports, service details and likely operating-system fingerprints when the responses permit. Scanning helps administrators find services that should be reviewed, restricted or disabled.

## Ethical scope
This project is deliberately restricted to **one private IPv4 address belonging to your own Kali/Ubuntu VM on a VirtualBox Host-Only network**. Do not scan public IPs, university networks, company systems, shared Wi-Fi or third-party devices. The supplied PowerShell runner checks that the address belongs to the same Host-Only subnet, rejects the Windows Host-Only adapter address, and requires confirmation before scanning. Never change the script to scan a third-party target.

## Install Nmap on Windows 11
1. Create a Kali or Ubuntu virtual machine in VirtualBox and configure a Host-Only adapter as described in docs/VM_LAB_SETUP.md.
2. Download Nmap only from https://nmap.org/download.html.
3. Run the official installer. Keep the Npcap option enabled.
4. Open PowerShell as Administrator and run: nmap --version.
5. Boot the VM and confirm that its Host-Only network interface has a private IPv4 address.

## Run the three required scans
From an Administrator PowerShell window, change directory to this task folder and run:

    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
    .\run_nmap_scan.ps1

Enter the VM's Host-Only IPv4 address only. Confirm that the displayed IP belongs to the VM you created. The script runs:
- Basic scan: nmap [target IP]
- Service-version scan: nmap -sV [target IP]
- OS detection: nmap -O [target IP]

Only a single VM address is scanned; the script does not scan a subnet or all ports.

## Output files
The script writes actual output under results/:
- 01_basic_scan.txt
- 02_service_version_scan.txt
- 03_os_detection_scan.txt
- service_scan.xml
- open_ports.csv
- nmap_scan_results.txt

No sample ports, invented scan output or fabricated screenshots are included. If a scan is inconclusive or errors, preserve the exact output and explain the limitation rather than guessing.

## Analyse the results
Use open_ports.csv and the raw Nmap output. For each observed open port, describe the protocol, service/product/version if detected, the purpose of the service, whether it is required, the security exposure and a practical recommendation. A port number alone does not prove a vulnerability. Use docs/PORT_SECURITY_REFERENCE.md only as a guide; it is not evidence that a port is open.

## Screenshots
Capture genuine terminal output with Win + Shift + S or Snipping Tool and save:
- screenshots/01_basic_scan.png
- screenshots/02_service_version_scan.png
- screenshots/03_os_detection_scan.png

Do not submit tutorial screenshots or another person's scan as evidence.

## Limitations
An open port means a service responded to the scan; it does not automatically mean the service is vulnerable. Filtered ports may be hidden by firewalls. Version detection is best-effort, and OS detection may return several possible matches or no confident result. Retain inconclusive output as part of the evidence.

## References
- Nmap Reference Guide: https://nmap.org/book/man.html
- Nmap download: https://nmap.org/download.html
- Npcap: https://npcap.com/
- Nmap OS detection: https://nmap.org/book/man-os-detection.html

## Submission checklist
- [ ] Nmap installation steps and version recorded
- [ ] Basic, service-version and OS-detection outputs saved
- [ ] Every observed open port and service explained
- [ ] Three genuine terminal screenshots added
- [ ] Demo video recorded with a 2-second title card showing Vimalraaj R, Security Analyst and Basic Network Scanning with Nmap
- [ ] Files committed to the public OIBSIP repository
