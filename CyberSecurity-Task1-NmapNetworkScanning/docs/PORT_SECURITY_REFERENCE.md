# Common Port Reference for Analysis

This is a vocabulary aid, **not scan evidence**. Discuss only ports present in your actual results.

| Port | Common service | Purpose | Security considerations |
|---:|---|---|---|
| 20/21 TCP | FTP | File transfer | Traditional FTP does not encrypt credentials or content; prefer SFTP/FTPS or disable if unneeded. |
| 22 TCP | SSH | Secure remote administration | Restrict access, update software, disable unused accounts and prefer key-based authentication. |
| 23 TCP | Telnet | Legacy remote terminal | Clear-text protocol; disable and use SSH instead. |
| 25 TCP | SMTP | Mail transfer | Restrict relay, require appropriate authentication and keep mail software patched. |
| 53 TCP/UDP | DNS | Name resolution | Restrict recursion to intended clients, patch software and consider DNSSEC. |
| 80 TCP | HTTP | Web traffic | Unencrypted; protect sessions with HTTPS and assess whether HTTP is needed. |
| 110 TCP | POP3 | Mail retrieval | Prefer encrypted POP3S or other secure mail access. |
| 135 TCP | MS RPC | Windows RPC mapping | Restrict exposure to trusted networks and apply host firewall rules. |
| 139 TCP | NetBIOS | Legacy file/printer sharing | Disable if unnecessary and limit to trusted local networks. |
| 443 TCP | HTTPS | Encrypted web traffic | Keep TLS and server software current; HTTPS does not fix vulnerable applications. |
| 445 TCP | SMB | Windows file sharing | Restrict access, disable SMBv1, patch and avoid Internet exposure. |
| 3306 TCP | MySQL | Database service | Restrict to application/administrator hosts; use strong authentication and encryption. |
| 3389 TCP | RDP | Remote desktop | Avoid direct Internet exposure; use MFA, VPN/gateway and source restrictions. |
| 5432 TCP | PostgreSQL | Database service | Restrict access, require strong authentication/TLS and patch supported versions. |
| 5900 TCP | VNC | Remote desktop | Require secure access controls and restrict to management networks. |
| 8080 TCP | Alternate HTTP | Web application/proxy | Identify exact product and version; inspect authentication and patch status. |

## Risk-rating guide
- **Informational:** A service is present; no weakness has been demonstrated.
- **Low:** Unneeded service or minor weakness with limited exposure.
- **Medium:** Reachable service has weak configuration or is available to untrusted local users.
- **High:** Unsupported software, exposed administrative service, clear-text credentials or a confirmed exploitable vulnerability.

Do not assign severity from the port number alone. State the evidence for each rating and recommend disabling unnecessary services, patching, stronger authentication or firewall restrictions as appropriate.
