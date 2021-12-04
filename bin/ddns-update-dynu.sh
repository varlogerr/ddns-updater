#!/usr/bin/env bash

THE_SCRIPT="$(basename "${BASH_SOURCE[0]}")"
THE_DIR="$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/..")"

print_help() {
  echo "Usage:"
  while read -r l; do
    [[ -n "${l}" ]] && echo "  ${l}"
  done <<< "
    # update all hosts
    DDNS_USER='<user>' DDNS_pass='<pass>' ${THE_SCRIPT}
    # update space separated hosts
    DDNS_HOSTS='<space-separated-hosts>' \\
    DDNS_USER='<user>' DDNS_pass='<pass>' ${THE_SCRIPT}
    # update to specific IP
    DDNS_IP='<some-ip>' DDNS_USER='<user>' \\
    DDNS_pass='<pass>' ${THE_SCRIPT}
  "
}

. "${THE_DIR}/core/bootstrap.sh"

API_URL="https://api.dynu.com/nic/update?"

if [[ -n "${DDNS_IP}" ]]; then
  API_URL+="&myip=${DDNS_IP}"
else
  DDNS_IP="$(get_current_ip)"
  if [[ -z "${DDNS_IP}" ]]; then
    DDNS_IP="NOT DETECTED"
  fi
fi

printf -- '[%s] IP: %s\n' \
  "$(get_date)" "${DDNS_IP}"

if [[ -z "${DDNS_HOSTS}" ]]; then
  printf -- '(%s) ' "all"
  curl -ks -u "${DDNS_USER}:${DDNS_PASS}" \
    -K - <<< "url=${API_URL}"
  echo
  exit
fi

for h in ${DDNS_HOSTS}; do
  printf -- '(%s) ' "${h}"
  curl -ks -u "${DDNS_USER}:${DDNS_PASS}" \
    -K - <<< "url=${API_URL}&hostname=${h}"
  echo
done
