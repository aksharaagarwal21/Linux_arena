#!/usr/bin/env bash

set -u

printf 'Linux system summary\n'
printf '%s\n' '-------------------'
printf 'Hostname: %s\n' "$(hostname)"
printf 'Kernel:   %s\n' "$(uname -sr)"
printf 'Uptime:   %s\n' "$(uptime -p 2>/dev/null || uptime)"

if [[ -r /etc/os-release ]]; then
    . /etc/os-release
    printf 'OS:       %s\n' "${PRETTY_NAME:-Unknown Linux distribution}"
fi

if command -v df >/dev/null 2>&1; then
    printf '\nRoot filesystem:\n'
    df -h / | awk 'NR == 1 || NR == 2'
fi

if command -v free >/dev/null 2>&1; then
    printf '\nMemory:\n'
    free -h | awk 'NR == 1 || NR == 2'
fi
