. "${THE_DIR}/core/func.sh"

while :; do
  [[ -z "${1+x}" ]] && break
  opt="${1}"
  shift
  if \
    grep -Pxq -- '-h|-\?|--help' <<< "${opt}" \
    && [[ "$(type -t print_help)" == 'function' ]] \
  ; then
    print_help
    exit
  fi
done
