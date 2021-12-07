#!/usr/bin/env bash

THE_SCRIPT="$(basename "${BASH_SOURCE[0]}")"
THE_DIR="$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../..")"
THE_DOCKERFILE="${THE_DIR}/Dockerfile"

found_lines="$(
  grep -Fxn '### exposed vars' "${THE_DOCKERFILE}" \
  | cut -d: -f1
)"

if [[ "$(wc -l <<< "${found_lines}")" -ne 2 ]]; then
  exit 1
fi

start_line="$(head -n 1 <<< "${found_lines}")"
end_line="$(tail -n 1 <<< "${found_lines}")"
offset=$(( end_line - ${start_line} ))

echo '##########'
while read -r l; do
  [[ -n "${l}" ]] && echo "${l}"
done <<< "
  # duckdns.org references:
  # * https://duckdns.org/install.jsp
  # * https://duckdns.org/spec.jsp
  #
  # dynu.com references:
  # * https://dynu.com/DynamicDNS/IP-Update-Protocol
  #
  # ydns.io references:
  # * https://github.com/ydns/bash-updater
"
echo '##########'
echo

prev_is_var=0
tail -n +$(( start_line + 1 )) "${THE_DOCKERFILE}" \
| head -n $(( offset - 1 )) \
| while read -r l; do
  [[ "${l:0:1}" == '#' ]] && echo "${l}" && continue

  # trim next line delimiters
  sed 's/\s*\\\s*$//' <<< "${l}"
done | while read -r l; do
  [[ "${l:0:1}" == '#' ]] && echo "${l}" && continue

  key="$(cut -d= -f1 <<< "${l}")"
  val="$(cut -d= -f2- <<< "${l}")"

  # prepare string for env file
  if [[ "${val:0:1}" == "'" ]]; then
    val="$(sed -E "s/^'(.*)'$/\1/g" <<< "${val}")"
  elif [[ "${val:0:1}" == '"' ]]; then
    val="$(sed -E 's/^"(.*)"$/\1/g' <<< "${val}")"
  fi

  echo "${key}=${val}"
done | while read -r l; do
  if [[ "${l:0:1}" == '#' ]]; then
    [[ ${prev_is_var} -eq 1 ]] && echo

    echo "${l}"
    prev_is_var=0
    continue
  fi

  echo "${l}"
  prev_is_var=1
done
