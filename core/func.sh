get_current_ip() {
  curl -ks https://ifconfig.me
}

get_date() {
  date +"%y-%m-%d %H:%M:%S"
}
