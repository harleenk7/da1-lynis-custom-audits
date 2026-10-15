#!/bin/sh
# Enhancement 2: Linux Password Policy Audit
# Lynis custom test ID: CUST-1020
Register --test-no CUST-1020 --weight L --network NO --category security --description "Linux password policy audit"
if [ "${SKIPTEST}" -eq 0 ]; then
    Display --indent 2 --text "Starting Linux Password Policy Audit" --result "${STATUS_OK}"
    for KEY in PASS_MAX_DAYS PASS_MIN_DAYS PASS_WARN_AGE; do
        VALUE=$(awk -v key="$KEY" '$1 == key {print $2; exit}' /etc/login.defs)
        if [ -z "$VALUE" ]; then
            Display --indent 2 --text "$KEY is missing from /etc/login.defs" --result "${STATUS_WARNING}" --color RED
        else
            Display --indent 2 --text "$KEY = $VALUE" --result "${STATUS_OK}" --color GREEN
        fi
    done
    if [ -f /etc/security/pwquality.conf ]; then
        Display --indent 2 --text "Password quality configuration file exists" --result "${STATUS_OK}" --color GREEN
    else
        Display --indent 2 --text "Password quality configuration file not found" --result "${STATUS_WARNING}" --color RED
        ReportSuggestion CUST-1020 "Review password quality configuration"
    fi
fi
