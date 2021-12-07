echo '> Setting provider ...'

sed -i 's/{{\s*provider\s*}}/'${PROVIDER}'/g' "${JOB_FILE}"
