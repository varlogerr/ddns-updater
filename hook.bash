export DDNS_UPDATE_BINDIR="${DDNS_UPDATE_BINDIR:-$(dirname "$(realpath "${BASH_SOURCE[0]}")")/bin}"
export DDNS_UPDATE_PREPEND_PATH="${DDNS_UPDATE_PREPEND_PATH:-0}"

if \
  !  tr ':' '\n' <<< "${PATH}" | sort | uniq \
  | grep -Fxq "${DDNS_UPDATE_BINDIR}" \
; then
  # ${DDNS_UPDATE_BINDIR} is not in the ${PATH}

  if [[ ${DDNS_UPDATE_PREPEND_PATH} == 1 ]]; then
    # prepend $PATH with ddns-update bin path
    export PATH="${DDNS_UPDATE_BINDIR}${PATH:+:${PATH}}"
  else
    # append ddns-update bin path to $PATH
    export PATH="${PATH:+${PATH}:}${DDNS_UPDATE_BINDIR}"
  fi
fi
