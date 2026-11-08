# Common Network Security Threats

**Prepared by:** Vimalraaj R  
**Track:** Oasis Infobyte — Security Analyst  
**Task:** Beginner Task 4  
**Date:** November 2026

## 1. Introduction

Network security protects the confidentiality, integrity and availability of information moving between devices, applications and services. Attacks may interrupt services, expose information, redirect users or undermine trust. Organisations need layered controls: secure configurations, identity protection, monitoring, timely updates, resilient infrastructure and tested incident response. This report examines four threats requested by the task guide.

## 2. Denial-of-Service and Distributed Denial-of-Service (DoS/DDoS)

### How it works
A denial-of-service attack tries to make a system unavailable by exhausting bandwidth, connection capacity, CPU, memory or an application resource. A distributed denial-of-service attack uses many devices or reflectors. Reflection attacks abuse exposed UDP services: requests are sent with a forged victim source address, causing responses to be directed at the victim.

### Real-world example
On 28 February 2018, GitHub experienced a memcached amplification DDoS attack peaking at 1.35 Tbps and 126.9 million packets per second. GitHub described rerouting traffic through its mitigation partner and using filtering and upstream capacity to restore service. The event illustrates how misconfigured third-party services can be abused as reflectors. [GitHub Engineering incident report](https://github.blog/news-insights/company-news/ddos-incident-report/).

### Impact
DDoS may cause slow services or outages, missed transactions, lost revenue, support costs and reduced customer confidence. Availability failures can also disrupt healthcare, public infrastructure and payment services.

### Three mitigations
1. **Upstream protection:** contract with an ISP, CDN or DDoS mitigation provider that can absorb and scrub high-volume traffic.
2. **Reduce amplification:** disable unnecessary UDP services, prevent open recursive DNS resolvers, restrict memcached and similar services to trusted interfaces, and apply rate limits.
3. **Prepare response:** use edge ACLs, WAF/rate limiting and redundant capacity; monitor baselines and maintain an escalation runbook with providers.

## 3. Man-in-the-Middle (MITM) Attacks

### How it works
An attacker positions themselves between two communicating parties and intercepts, relays or modifies traffic. Possible enablers include untrusted Wi-Fi, a compromised router, forged certificates, DNS manipulation or weak encryption. Correctly validated TLS substantially reduces reading or modification of protected web traffic.

### Real-world example
The 2011 DigiNotar certificate-authority compromise involved fraudulent certificates, including a false Google certificate, that could enable website impersonation and man-in-the-middle attacks. Microsoft issued Security Advisory 2607712 describing the fraudulent certificates and required trust-store action. [Microsoft Security Advisory 2607712](https://learn.microsoft.com/en-us/security-updates/securityadvisories/2011/2607712).

### Impact
MITM may expose credentials, cookies and private communications, alter payment details or inject content. Consequences include account takeover, fraud, data loss and regulatory exposure.

### Three mitigations
1. **Authenticated encryption:** use current TLS, valid certificates and HSTS; never bypass certificate warnings or downgrade to plaintext HTTP.
2. **Secure the network path:** use WPA2-AES/WPA3, update routers, change default administrator credentials and use a trusted VPN on untrusted networks.
3. **Protect sessions and identities:** use phishing-resistant MFA, secure cookie attributes and monitoring for unexpected certificate or DNS changes.

## 4. IP Spoofing

### How it works
IP spoofing places a forged source address in an IP packet. Since the source field is not cryptographic identity proof, spoofing can obscure origin, defeat poorly designed source-address trust rules or enable reflection/amplification attacks.

### Real-world example
During the 2013 Spamhaus DDoS incident, attackers sent DNS requests to open resolvers while spoofing the victim-side source address. Cloudflare reported more than 30,000 unique resolvers and about 75 Gbps of reflected traffic in the portion it observed. [Cloudflare incident analysis](https://blog.cloudflare.com/the-ddos-that-knocked-spamhaus-offline-and-ho/).

### Impact
Spoofing supports volumetric DDoS, complicates attribution and may bypass controls that trust a source IP without authenticating the user or system.

### Three mitigations
1. **Source validation:** network providers should implement ingress filtering in line with IETF BCP 38 / RFC 2827; organisations should apply appropriate egress filtering.
2. **Do not rely on IP as identity:** require cryptographic authentication and application-level authorisation for sensitive operations.
3. **Harden network services:** restrict recursive DNS and other UDP services, remove unnecessary reflectors, apply rate limits and monitor traffic anomalies.

## 5. DNS Poisoning and DNS Hijacking

### How it works
DNS translates domain names into IP addresses. Cache poisoning inserts false data into a resolver cache; DNS hijacking changes authoritative records or registrar/DNS account settings. Both can redirect users, disrupt email or enable credential theft and follow-on MITM activity.

### Real-world example
CISA's January 2019 alert described a global DNS infrastructure hijacking campaign in which attackers used compromised credentials to alter A, MX or NS records and redirect web and email traffic to attacker-controlled infrastructure. [CISA Alert AA19-024A](https://www.cisa.gov/news-events/alerts/2019/01/24/dns-infrastructure-hijacking-campaign).

### Impact
Users may reach fraudulent sites, disclose credentials or send email to the wrong destination. Organisations can lose control of online services and domain identity.

### Three mitigations
1. **Protect DNS accounts:** require MFA, unique credentials, least privilege, registrar locks and approval for sensitive DNS changes.
2. **Protect DNS integrity:** deploy DNSSEC appropriately and validate DNSSEC responses. NIST SP 800-81 Rev. 3 gives current deployment guidance for DNS roles and DNSSEC. [NIST SP 800-81 Rev. 3](https://csrc.nist.gov/pubs/sp/800/81/r3/final).
3. **Monitor changes:** alert on unexpected A, MX, NS and DS changes, retain audit logs and independently verify critical records.

## 6. Comparison Table

| Threat | Attack vector | Who is at risk? | Difficulty (general) | Mitigation ease (general) |
|---|---|---|---|---|
| DoS/DDoS | Flooding, botnets, reflection/amplification | Public services, DNS, enterprises and critical services | Medium–high | Medium; provider capacity and filtering required |
| MITM | Rogue Wi-Fi, compromised routers, forged certificates | Users and organisations using untrusted paths | Medium | Medium–high when TLS and identity controls are consistent |
| IP spoofing | Forged source address, often with UDP reflection | Network operators, DDoS victims, IP-trusting systems | Low–medium for packet forgery | Medium; filtering and authentication reduce risk |
| DNS poisoning/hijacking | False cache data or unauthorised DNS changes | Domain owners, visitors, email users | Medium–high | Medium; account security, DNSSEC and monitoring are layered controls |

Difficulty and mitigation ease are qualitative and depend on environment and controls.

## 7. Conclusion — Three Administrator Takeaways

1. Plan for availability with upstream DDoS protection, monitoring and a tested escalation process.
2. Authenticate identities and communication; encrypt traffic and do not trust IP addresses alone.
3. Treat DNS and network configuration as critical assets; restrict services, protect registrar accounts and monitor changes.

## 8. References

1. GitHub Engineering, [February 28th DDoS Incident Report](https://github.blog/news-insights/company-news/ddos-incident-report/), 1 March 2018.
2. Microsoft, [Security Advisory 2607712](https://learn.microsoft.com/en-us/security-updates/securityadvisories/2011/2607712), 2011.
3. Cloudflare, [The DDoS That Knocked Spamhaus Offline](https://blog.cloudflare.com/the-ddos-that-knocked-spamhaus-offline-and-ho/), 2013.
4. IETF, [RFC 2827 — Network Ingress Filtering / BCP 38](https://datatracker.ietf.org/doc/rfc2827/), 2000.
5. CISA, [AA19-024A — DNS Infrastructure Hijacking Campaign](https://www.cisa.gov/news-events/alerts/2019/01/24/dns-infrastructure-hijacking-campaign), 2019.
6. NIST, [SP 800-81 Rev. 3 — Secure Domain Name System Deployment Guide](https://csrc.nist.gov/pubs/sp/800/81/r3/final), March 2026.
