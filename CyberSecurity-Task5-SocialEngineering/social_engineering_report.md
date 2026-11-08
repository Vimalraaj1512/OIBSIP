# Social Engineering Attacks: Phishing, Pretexting and Baiting

**Prepared by:** Vimalraaj R  
**Track:** Oasis Infobyte — Security Analyst  
**Task:** Beginner Task 5  
**Date:** November 2026

## 1. Introduction

Social engineering uses deception and psychological manipulation to make a person disclose information, grant access or perform an unsafe action. It targets trust, urgency, helpfulness, authority and routine work practices rather than relying only on a software vulnerability. Attackers may combine email, phone calls, messaging and in-person approaches. NIST describes social engineering as an attempt to trick someone into revealing information that can be used to attack systems or networks. [NIST CSRC Glossary](https://csrc.nist.gov/glossary/term/social_engineering).

## 2. Phishing

### Definition and operation
Phishing impersonates a trusted organisation or person through email, text, voice calls or malicious websites. The objective may be to steal credentials, collect financial information, obtain an MFA approval or make a user open a harmful attachment.
- **Spear phishing:** a targeted message tailored to a particular person.
- **Whaling:** phishing aimed at a senior or high-value individual.
- **Vishing:** phishing through voice calls.
- **Smishing:** phishing through SMS or similar text messages.

### Real-world case study — RSA SecurID (2011)
RSA's 2011 incident began with spear-phishing emails sent to a small number of employees. The messages used the subject "2011 Recruitment Plan" and included a spreadsheet attachment. An employee opened the attachment, allowing the attackers to gain an initial foothold and progress toward sensitive SecurID-related information. The incident demonstrates that one carefully crafted message can create a significant organisational risk. [Microsoft Security Chronicles — RSA breach analysis](https://download.microsoft.com/download/E/5/8/E582E744-3347-40F3-B6FE-E863A5E9292E/Microsoft_Security_Chronicles_April14_2011.pdf).

### Impact
Phishing can lead to account takeover, business email compromise, fraudulent payments, malware infection, data theft and unauthorised internal access.

### Four prevention recommendations
1. Verify unexpected requests using a separate trusted channel; do not use contact details inside a suspicious message.
2. Prefer phishing-resistant MFA such as passkeys or FIDO2 security keys; never share one-time codes or approve unexpected prompts.
3. Deploy email and web filtering, attachment/link analysis, endpoint protection and SPF, DKIM and DMARC for organisational domains.
4. Train employees to inspect sender domains, URLs, attachments, urgency and payment changes; provide an easy reporting process.

CISA's [Phishing General Security Postcard](https://www.cisa.gov/sites/default/files/publications/Phishing%20General%20Security%20Postcard_6.24.2021_508c.pdf) gives warning signs and protective measures.

## 3. Pretexting

### Definition and operation
Pretexting is the use of an invented but plausible story or role to make a request seem legitimate. An attacker may impersonate a help-desk worker, supplier, bank representative or manager. The pretext may be delivered by phone, email, messaging or in person.

### Real-world case study — Twitter incident (July 2020)
The New York State Department of Financial Services report describes attackers calling Twitter employees while claiming to be from the IT help desk. They used a story about VPN problems to persuade employees to disclose credentials. The attackers then accessed internal systems and support tools and took over high-profile accounts. Twitter described the incident as a phone spear-phishing attack. [NYDFS Twitter Investigation Report](https://www.dfs.ny.gov/reports-and-publications/other-reports/Twitter_Report) and [Twitter incident update](https://blog.x.com/en/company/an-update-on-our-security-incident).

### Impact
Pretexting can persuade a legitimate employee to reveal credentials, reset an account, disclose internal procedures or approve an access request. The result may be unauthorised access, data exposure or fraud.

### Three prevention measures
1. Independently verify the requester using an approved directory, call-back number or ticketing system; do not rely on caller ID.
2. Require documented identity checks and approval for password resets, MFA resets, privilege changes and recovery-detail changes.
3. Use phishing-resistant MFA, just-in-time privileged access and monitoring for unusual account-reset activity.

## 4. Baiting

### Definition and operation
Baiting tempts a person with something desirable or curiosity-provoking. Physical baiting may involve a USB drive left in a public place. Digital baiting may use fake software installers, cracked applications, game cheats or attractive downloads that contain malware or lead to credential theft.

### Documented study — USB flash-drive experiment (2016)
Researchers from the University of Illinois, University of Michigan and Google studied 297 USB flash drives placed around a university campus. Their paper reported that people frequently connected found drives; a university research summary reported that about 48% were inserted and files opened. Researchers used benign files. This was a controlled behavioural study, not a real malware infection. [Google Research — Users Really Do Plug in USB Drives They Find](https://research.google/pubs/users-really-do-plug-in-usb-drives-they-find/) and [IEEE publication](https://ieeexplore.ieee.org/abstract/document/7546509).

### Impact
An untrusted device or download may install malware, steal information or create a foothold. Even without malware execution, a fake download page may steal credentials or cause unsafe software installation.

### Three prevention measures
1. Never connect found or untrusted removable media; hand it to the security or facilities team.
2. Use removable-media controls, disable autorun, restrict local administrator rights and apply application allowlisting where feasible.
3. Download software only from official vendor sites or managed stores; verify digital signatures or hashes where provided and reject cracked installers.

## 5. Quid Pro Quo (Bonus)

Quid pro quo means "something for something." An attacker offers a benefit or service in exchange for information or an action. A fake support worker may claim to fix an account if the user discloses a password. Prevention includes official support channels, independent identity verification and a strict rule never to share passwords or MFA codes.

## 6. Comparison Table

| Attack type | Primary target | Psychological lever | Best countermeasure |
|---|---|---|---|
| Phishing | Email, messaging and account users | Urgency, fear, curiosity, authority or reward | Independent verification, phishing-resistant MFA, filtering and reporting |
| Pretexting | Employees, help desks and people with access | Trust, authority and believable scenario | Independent identity checks and controlled reset workflows |
| Baiting | People with computer/removable-media access | Curiosity, helpfulness, free offers | Removable-media controls and trusted software sources |
| Quid pro quo | Users seeking support or a service | Reciprocity and promised assistance | Official support channels and no-password-sharing policy |

## 7. Five-Point Employee Awareness Checklist

1. Pause before acting on unexpected urgency, payment changes, password requests or attachments.
2. Verify identity through the company directory or official support portal.
3. Never share passwords, one-time passcodes, recovery codes or approve an unrequested MFA prompt.
4. Do not connect found USB devices or install software from unofficial sources.
5. Report suspicious messages, calls and devices through the approved security channel; preserve details and do not investigate independently.

## 8. References

1. NIST CSRC, [Social Engineering Glossary](https://csrc.nist.gov/glossary/term/social_engineering).
2. CISA, [Phishing General Security Postcard](https://www.cisa.gov/sites/default/files/publications/Phishing%20General%20Security%20Postcard_6.24.2021_508c.pdf), 2021.
3. Microsoft, [Microsoft Security Chronicles — RSA SecurID incident analysis](https://download.microsoft.com/download/E/5/8/E582E744-3347-40F3-B6FE-E863A5E9292E/Microsoft_Security_Chronicles_April14_2011.pdf), 2011.
4. New York State Department of Financial Services, [Twitter Investigation Report](https://www.dfs.ny.gov/reports-and-publications/other-reports/Twitter_Report), 14 October 2020.
5. Twitter, [An update on our security incident](https://blog.x.com/en/company/an-update-on-our-security-incident), July 2020.
6. U.S. Army Cyber Command, [Cybersecurity Fact Sheet: Baiting](https://www.arcyber.army.mil/Resources/Fact-Sheets/Article/1440670/cybersecurity-fact-sheet-baiting/), 2018.
7. Tischer et al., [Users Really Do Plug in USB Drives They Find](https://research.google/pubs/users-really-do-plug-in-usb-drives-they-find/), IEEE Symposium on Security and Privacy, 2016.
