echo "> Validating required env variables for '${PROVIDER}' provider ..."

declare -A required_envs=(
  [DDNS_TOKEN]='duckdns'
  [DDNS_DOMAINS]='duckdns'
  [DDNS_USER]='dynu ydns'
  [DDNS_PASS]='dynu ydns'
  [DDNS_HOSTS]='ydns'
)

missing_envs=()
for k in "${!required_envs[@]}"; do
  provs="${required_envs[${k}]}"

  ! grep -Fq " ${PROVIDER} " <<< " ${provs} " && continue

  [[ -z "${!k}" ]] && missing_envs+=("${k}")
done

if [[ ${#missing_envs[@]} -gt 0 ]]; then
  echo "Missing required env variables for '${PROVIDER}' provider:"
  for e in "${missing_envs[@]}"; do
    echo "* ${e}"
  done
  exit 1
fi
