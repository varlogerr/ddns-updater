__tmp_add_path() {
  export DDNS_UPDATE_PREPEND_PATH="${DDNS_UPDATE_PREPEND_PATH:-0}"
  export DDNS_UPDATE_BINDIR="${DDNS_UPDATE_BINDIR:-$(
    script_path="$(realpath "${1}")"
    script_dir="$(dirname "${script_path}")"
    echo "${script_dir}/bin"
  )}"

  local bindir="${DDNS_UPDATE_BINDIR}"
  local prepend="${DDNS_UPDATE_PREPEND_PATH}"

  if \
    !  tr ':' '\n' <<< "${PATH}" | sort | uniq \
    | grep -Fxq "${bindir}" \
  ; then
    # $bindir is not in the $PATH
    if [[ ${prepend} == 1 ]]; then
      # prepend $PATH with $bindir
      export PATH="${bindir}${PATH:+:${PATH}}"
    else
      # append ddns-update bin path to $PATH
      export PATH="${PATH:+${PATH}:}${bindir}"
    fi
  fi
}
__tmp_add_path "${1:-${BASH_SOURCE[0]}}"
