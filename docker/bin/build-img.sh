#!/usr/bin/env bash

THE_SCRIPT="$(basename "${BASH_SOURCE[0]}")"
THE_DIR="$(realpath "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../..")"

print_help() {
  echo "Usage:"
  echo "  ${THE_SCRIPT} <tag>"
}

if grep -Pxq -- '-h|-\?|--help' <<< "${1}"; then
  print_help
  exit
fi

THE_TAG="${1}"

if [[ -z "${THE_TAG}" ]]; then
  echo "Tag is required!"
  print_help
  exit 1
fi

cd "${THE_DIR}"
docker image build -t varlogerr/ddns-updater:${THE_TAG} .
