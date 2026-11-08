# Isolated VirtualBox Host-Only Lab Setup

This guide creates a small lab so Task 1 scans only a VM that you own and control.

## 1. Create a Host-Only network
1. Open Oracle VirtualBox.
2. Open Tools > Network (or File > Tools > Network, depending on your version).
3. Create a Host-Only network. Keep its IPv4 network private (for example, 192.168.56.0/24); use the actual values VirtualBox assigns.
4. Do not bridge this adapter to a public or campus network.
5. In the VM settings, open Network > Adapter 2, enable it and attach it to the Host-Only network you just created.
6. Keep Adapter 1 as NAT only if the VM needs internet access for updates. The scan script targets only the Host-Only address.

## 2. Configure the Linux VM
1. Boot Kali Linux or Ubuntu.
2. Identify the Host-Only interface using: ip -br address
3. If it has no address, use the distribution's network settings or DHCP client for that Host-Only interface.
4. Record the VM's private IPv4 address, not the NAT address.
5. Confirm the VM is running and that the Host-Only interface is up.

## 3. Confirm from Windows
1. Open PowerShell and run: Get-NetIPConfiguration
2. Locate the active adapter whose description includes VirtualBox Host-Only.
3. Note its IPv4 address and prefix length.
4. The VM address must be in this same subnet and must be different from the Windows host's Host-Only address.

## 4. Scan
Run the parent folder's run_nmap_scan.ps1 from an elevated PowerShell window. Enter only the VM Host-Only IP. Review the safety summary before typing Y.

## 5. Troubleshooting
- No Host-Only adapter: create/enable one in VirtualBox Network Manager.
- VM has no Host-Only IPv4: check Adapter 2 is enabled and attached to the correct Host-Only network.
- Host unreachable: check the VM interface state and Host-Only network configuration.
- OS detection inconclusive: retain the output; OS fingerprinting is not guaranteed.
- Nmap not found: reinstall from the official Nmap download page and reopen PowerShell.

## Safety
Do not scan NAT gateway addresses, public targets, other devices on shared networks, or network ranges. This project intentionally accepts one VM address only.
