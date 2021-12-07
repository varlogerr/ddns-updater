ARG JOBBER_TAG=20211208-1


FROM varlogerr/jobber:${JOBBER_TAG}

COPY bin /opt/varlog/ddns-updater/bin
COPY core /opt/varlog/ddns-updater/core
COPY docker/rootfs/ /

ENV \
  # private vars
  PATH="${PATH}:/opt/varlog/ddns-updater/bin" \
  CMD='ddns-update-{{ provider }}.sh > /dev/pts/0 2>&1' \
  THE_UID=1313 \
  THE_GID=1313 \
### exposed vars
  # DDNS provider. Available values:
  # * duckdns
  # * dynu
  # * ydns
  PROVIDER=duckdns \
  # Updates schedule (cron format)
  SCHEDULE="*/15 * * * *" \
  # Available for:
  # * duckdns (required)
  DDNS_TOKEN='' \
  # Only domain subnames, i.e.
  # `foobar` for `foobar.duckdns.org`
  # Available for:
  # * duckdns (required)
  DDNS_DOMAINS='' \
  # Available for:
  # * dynu (required)
  # * ydns (required)
  DDNS_USER='' \
  # Available for:
  # * dynu (required)
  # * ydns (required)
  DDNS_PASS='' \
  # Available for:
  # * dynu (optional)
  # * ydns (required)
  DDNS_HOSTS='' \
  # Available for:
  # optional for all
  DDNS_IP=''
### exposed vars

RUN : \
  && apk add --update --no-cache \
    curl grep \
  # ensure scripts are executable
  && chmod +x /opt/varlog/ddns-updater/bin/*
