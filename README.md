# Linux Security Audits Using Lynis

## Project Overview
This project focuses on developing custom security checks for Linux systems using Lynis. It includes two shell scripts designed to inspect selected password policy settings and HTTPS/TLS certificate validity.
The objective is to explore how custom tests can extend a Linux security audit and help identify potential security configuration issues.

## Project Objectives
- Understand the functionality of Lynis and its custom test framework.
- Audit selected Linux password policy settings.
- Retrieve HTTPS/TLS certificate information using OpenSSL.
- Display security-related findings and warnings.
- Document the implementation and execution process.

## Custom Security Scripts

### 1. HTTPS/TLS Security Audit
**Filename:** `https_tls_audit.sh`  
**Test ID:** `CUST-1010`

This script uses OpenSSL to connect to `example.com` on port `443` and retrieve its TLS certificate details.

**Key functions:**
- Retrieves certificate subject, issuer and validity dates.
- Checks whether the certificate has expired.
- Displays a warning if certificate retrieval fails or the certificate has expired.
- Provides a suggestion to investigate connection or certificate retrieval issues.

### 2. Linux Password Policy Audit

**Filename:** `password_policy_audit.sh`  
**Test ID:** `CUST-1020`
This script checks selected password policy settings on a Linux system.

**Key functions:**
- Inspects `PASS_MAX_DAYS` in `/etc/login.defs`.
- Inspects `PASS_MIN_DAYS` in `/etc/login.defs`.
- Inspects `PASS_WARN_AGE` in `/etc/login.defs`.
- Checks whether `/etc/security/pwquality.conf` exists.
- Displays warnings when selected settings or the configuration file are missing.

## Technologies Used

- **Operating System:** Ubuntu Linux
- **Security Auditing Tool:** Lynis
- **Scripting Language:** Shell scripting
- **Certificate Inspection:** OpenSSL

## Requirements

- A Linux system, such as Ubuntu
- Lynis installed
- OpenSSL installed for the HTTPS/TLS audit
- Network connectivity to the target HTTPS server

## Execution

The scripts are designed to be integrated into Lynis as custom tests.
Run a Lynis system audit with:
bash
sudo lynis audit system --quick
Review the terminal output to verify whether the custom tests execute and display their findings.

## Expected Findings

The HTTPS/TLS audit is intended to display certificate details and indicate whether the certificate has expired or could not be retrieved.
The password policy audit is intended to report the selected password-aging settings and whether the password-quality configuration file exists.

**Note:** These are intended behaviours. Actual results depend on the system configuration, network access and successful integration of the custom tests into Lynis.

## Limitations

- The HTTPS/TLS script checks certificate retrieval and expiry. It does not perform a complete TLS security assessment, including cipher-suite analysis or comprehensive certificate-chain validation.
- The password policy script checks whether selected settings exist. It does not currently evaluate whether their numerical values meet a defined security baseline.
- The checks cover selected configuration areas and do not replace a comprehensive security audit.

## Repository Structure
da1-lynis-custom-audits/
1. README.md
2. https_tls_audit.sh
3. password_policy_audit.sh

## Conclusion

This project demonstrates the design of two custom Linux security checks intended for use with Lynis. It provides a starting point for inspecting password policy configuration and HTTPS/TLS certificate validity, while highlighting areas for further security testing and improvement.
