# Linux Security Audits Using Lynis

## Author: Harleen Kaur
Tests Included

1. CUST-1010 — HTTPS/TLS Certificate Audit

Filename: https_tls_audit.sh

Uses OpenSSL to connect to an HTTPS server and retrieve its TLS certificate information.

Retrieves the certificate subject and issuer.

Displays certificate validity dates.

Checks whether the certificate has expired.

Displays warnings if certificate retrieval fails or the certificate has expired.

2. CUST-1020 — Linux Password Policy Audit

Filename: password_policy_audit.sh

Inspects selected password policy settings and configuration files on a Linux system.

Checks PASS_MAX_DAYS in /etc/login.defs.

Checks PASS_MIN_DAYS in /etc/login.defs.

Checks PASS_WARN_AGE in /etc/login.defs.

Verifies whether /etc/security/pwquality.conf exists.

Displays warnings when selected settings or the configuration file are missing.

Environment

Ubuntu Linux

Lynis

Shell scripting

OpenSSL

Requirements

A Linux system, such as Ubuntu.

Lynis installed.

OpenSSL installed for the HTTPS/TLS audit.

Network connectivity to the target HTTPS server.

How to Run

The scripts are intended to be integrated into Lynis as custom security tests. Run a system audit using:

sudo lynis audit system --quick

Review the audit output to check whether the custom tests execute and report their findings.

To check the shell syntax of the scripts, run:

bash -n https_tls_audit.sh
bash -n password_policy_audit.sh

Note: These scripts focus on selected security configuration checks. The HTTPS/TLS audit does not perform a complete TLS security assessment, and the password policy audit does not evaluate numerical settings against a defined security baseline. Actual findings depend on system configuration, network connectivity, and successful integration with Lynis.

## Repository Structure
da1-lynis-custom-audits/
1. README.md
2. https_tls_audit.sh
3. password_policy_audit.sh

## Conclusion

This project demonstrates the design of two custom Linux security checks intended for use with Lynis. It provides a starting point for inspecting password policy configuration and HTTPS/TLS certificate validity, while highlighting areas for further security testing and improvement.
