echo '> Validating provider ...'

found_scripts="$(
  find /opt/varlog/ddns-updater/bin \
    -type f -mindepth 1 -maxdepth 1 \
  | while read -r f; do basename "${f}"; done \
  | grep -Fxc "ddns-update-${PROVIDER}.sh"
)"

if [[ "${found_scripts}" -ne 1 ]]; then
  echo "Invalid provider '${PROVIDER}'!"
  exit 1
fi
