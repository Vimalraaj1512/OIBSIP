# The Importance of Patch Management

**Prepared by:** Vimalraaj R  
**Track:** Oasis Infobyte — Security Analyst  
**Task:** Beginner Task 6  
**Date:** November 2026

## 1. Introduction

Patch management is the controlled process of identifying, assessing, testing, deploying and verifying updates for operating systems, applications, firmware and other software. Patches may correct security vulnerabilities, fix defects or improve reliability. An unpatched system remains exposed after a vendor has made a fix available, especially when the vulnerable service is reachable from an untrusted network. NIST describes enterprise patch management as preventive maintenance for technology and a key part of organisational risk management. [NIST SP 800-40 Rev. 4](https://csrc.nist.gov/pubs/sp/800/40/r4/final).

## 2. Why Patches Matter

Vulnerabilities may be discovered by researchers, vendors or attackers. They can be assigned a Common Vulnerabilities and Exposures (CVE) identifier so that defenders can discuss and track a specific weakness. CVSS provides a standard way to describe technical severity, while CISA's Known Exploited Vulnerabilities (KEV) Catalog identifies vulnerabilities known to be exploited in the wild. Organisations should consider severity, actual exploitation, exposure, asset importance and available mitigations when setting patch priorities.

### Case study 1 — WannaCry and Windows SMB (May 2017)
Microsoft released security update MS17-010 on 14 March 2017 to address critical Windows SMB Server vulnerabilities, including CVE-2017-0144. The WannaCry ransomware campaign began on 12 May 2017 and exploited the SMB weakness. The NHS and other organisations were disrupted because vulnerable systems remained unpatched or were running unsupported software. The UK National Audit Office estimated more than 19,000 NHS appointments were cancelled; the UK Parliament reported more than 200,000 computers in at least 100 countries were affected. [Microsoft MS17-010](https://learn.microsoft.com/en-us/security-updates/SecurityBulletins/2017/ms17-010), [UK National Audit Office](https://www.nao.org.uk/reports/investigation-wannacry-cyber-attack-and-the-nhs/) and [UK Parliament report](https://publications.parliament.uk/pa/cm201719/cmselect/cmpubacc/787/78704.htm).

**Lesson:** critical patches for exposed services must be prioritised. Unsupported systems need a mitigation or replacement plan.

### Case study 2 — Equifax and Apache Struts CVE-2017-5638 (2017)
Apache announced a fix for CVE-2017-5638 on 7 March 2017. Equifax later confirmed that its 2017 breach involved this Apache Struts vulnerability in its online dispute portal. The U.S. House Oversight Committee reported that approximately 148 million individuals were affected and identified failures in patching, asset inventory and monitoring. [Apache Software Foundation response](https://news.apache.org/foundation/entry/responses-to-questions-from-us), [Equifax incident announcement](https://investor.equifax.com/news-events/press-releases/detail/237/equifax-releases-details-on-cybersecurity-incident) and [U.S. House report](https://oversight.house.gov/wp-content/uploads/2018/12/Equifax-Report.pdf).

**Lesson:** a patch policy is ineffective if an organisation cannot identify every system running the affected component, assign an owner and verify the change.

## 3. Consequences of Not Patching

- **Data breaches:** attackers may exploit known weaknesses to access personal information, business records or credentials.
- **Ransomware and service disruption:** WannaCry used a Windows SMB weakness for which Microsoft had already released an update.
- **Operational and financial loss:** recovery can require incident response, forensic investigation, system rebuilds, external support and customer notification.
- **Regulatory and contractual exposure:** organisations may fail applicable privacy, security or contractual duties. Exact obligations depend on jurisdiction and sector.
- **Reputational damage:** customers and partners may lose confidence after preventable breaches.

## 4. Patch Management Lifecycle

The required lifecycle is **Discovery → Assessment → Testing → Deployment → Verification**.

1. **Discovery:** maintain an inventory of endpoints, servers, network devices, cloud workloads, applications, firmware and third-party components. Record versions and owners.
2. **Assessment:** map advisories and CVEs to the inventory. Consider CVSS, CISA KEV status, Internet exposure, exploitability, asset criticality and business impact.
3. **Testing:** validate updates in representative systems. Check application compatibility, integrations, performance, backups and rollback steps.
4. **Deployment:** use controlled change processes, staged rollout rings and maintenance windows. Record exceptions and assign accountable owners.
5. **Verification:** confirm the expected patch level is installed, rescan where appropriate, review failed deployments and update the asset inventory.

## 5. Prioritised Seven-Step Patch Management Checklist

1. **Maintain an authoritative asset inventory.** Include operating systems, applications, cloud workloads, network devices and firmware; assign an owner to each asset.
2. **Monitor trusted security advisories.** Review vendor bulletins, NIST NVD/CVE records and CISA KEV updates.
3. **Prioritise by risk and exposure.** Address known exploited vulnerabilities on Internet-facing or critical assets first, then other critical/high-risk issues.
4. **Set risk-based service-level targets.** Define shorter deadlines for actively exploited and critical vulnerabilities; require approval and expiry dates for exceptions.
5. **Test and plan rollback.** Use representative test systems, backups, application-owner sign-off and documented rollback/mitigation procedures.
6. **Automate controlled deployment.** Use endpoint/configuration management, staged rollout rings and compliance dashboards; include remote devices and cloud workloads.
7. **Verify, document and improve.** Confirm installed versions, rescan where appropriate, track failures and report overdue critical vulnerabilities.

## 6. Challenges and Ways to Overcome Them

| Challenge | Why it occurs | Practical response |
|---|---|---|
| Incomplete asset inventory | Devices and software are managed by different teams; shadow IT and forgotten systems remain | Use discovery tools and procurement/cloud records; reconcile regularly |
| Legacy or unsupported systems | Replacement can be expensive or applications depend on old components | Create a replacement plan; isolate and restrict access while applying supported mitigations |
| Downtime concerns | Patches may require reboots or change application behaviour | Use maintenance windows, staged rollouts and high-availability design |
| Compatibility risk | Updates may conflict with applications or integrations | Test representative systems, keep backups and prepare rollback |
| Remote devices miss updates | Laptops and branch devices may be offline during patch windows | Use managed endpoint tools and alerts for devices that stop reporting |
| Unclear ownership | Teams assume another group is responsible | Assign named owners and escalation paths to assets and vulnerabilities |
| Alert overload | Advisories outnumber available patching capacity | Prioritise KEV-listed and exposed vulnerabilities and automate asset matching |

## 7. Conclusion

Patch management is a continuous risk-reduction process, not a one-time update activity. WannaCry and Equifax show that publishing a fix does not protect an organisation until affected assets are identified, updated and verified. A disciplined lifecycle, accurate inventory, risk-based prioritisation, controlled deployment and management accountability reduce the time attackers have to exploit known weaknesses. The goal is to prove that critical exposure has been removed or explicitly mitigated.

## 8. References

1. NIST, [SP 800-40 Rev. 4 — Guide to Enterprise Patch Management Planning](https://csrc.nist.gov/pubs/sp/800/40/r4/final), 2022.
2. Microsoft, [Security Bulletin MS17-010 — Windows SMB Server](https://learn.microsoft.com/en-us/security-updates/SecurityBulletins/2017/ms17-010), 14 March 2017.
3. UK National Audit Office, [Investigation: WannaCry cyber attack and the NHS](https://www.nao.org.uk/reports/investigation-wannacry-cyber-attack-and-the-nhs/), 2017.
4. UK Parliament, [Cyber-attack on the NHS — Committee of Public Accounts](https://publications.parliament.uk/pa/cm201719/cmselect/cmpubacc/787/78704.htm), 2018.
5. Apache Software Foundation, [Response to questions regarding Equifax](https://news.apache.org/foundation/entry/responses-to-questions-from-us), 2017.
6. U.S. House Committee on Oversight and Government Reform, [The Equifax Data Breach](https://oversight.house.gov/wp-content/uploads/2018/12/Equifax-Report.pdf), 2018.
7. CISA, [Known Exploited Vulnerabilities Catalog](https://www.cisa.gov/known-exploited-vulnerabilities-catalog), accessed November 2026.
8. NIST CSRC, [Common Vulnerabilities and Exposures — Glossary](https://csrc.nist.gov/glossary/term/common_vulnerabilities_and_exposures).
