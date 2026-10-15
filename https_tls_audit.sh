#!/bin/sh
# Enhancement 1: HTTPS/TLS Security Audit
# Lynis custom test ID: CUST-1010
Register --test-no CUST-1010 --weight L --network YES --category security --description "HTTPS TLS certificate retrieval"
if [ "${SKIPTEST}" -eq 0 ]; then
    HOST="example.com"
    PORT="443"
    if command -v openssl >/dev/null 2>&1; then
        CERT=$(timeout 15 openssl s_client \
            -connect "$HOST:$PORT" \
            -servername "$HOST" </dev/null 2>/dev/null |
            openssl x509 -noout -subject -issuer -dates 2>/dev/null)
        if [ -z "$CERT" ]; then
            Display --indent 2 --text "Could not retrieve TLS certificate from $HOST" --result "${STATUS_WARNING}" --color RED
            ReportSuggestion CUST-1010 "Check network access and TLS certificate retrieval"
        else
            printf '%s\n' "$CERT"
            EXPIRY=$(printf '%s\n' "$CERT" | sed -n 's/^notAfter=//p')
            if [ -n "$EXPIRY" ] && date -d "$EXPIRY" >/dev/null 2>&1; then
                if [ "$(date -d "$EXPIRY" +%s)" -gt "$(date +%s)" ]; then
                    Display --indent 2 --text "TLS certificate has not expired" --result "${STATUS_OK}" --color GREEN
                else
                    Display --indent 2 --text "TLS certificate has expired" --result "${STATUS_WARNING}" --color RED
                    ReportWarning CUST-1010 "TLS certificate has expired"
                fi
            fi
        fi
    else
        Display --indent 2 --text "OpenSSL is not installed" --result "${STATUS_WARNING}" --color RED
    fi
fi
