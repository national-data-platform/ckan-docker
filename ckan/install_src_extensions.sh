#!/bin/bash
# Install mounted custom extensions (the 2.10.11 dev image no longer does this)
for d in /srv/app/src_extensions/*; do
  if [ -f "$d/setup.py" ] || [ -f "$d/pyproject.toml" ]; then
    echo "Installing $(basename "$d")"
    [ -f "$d/requirements.txt" ] && pip3 install -r "$d/requirements.txt"
    [ -f "$d/pip-requirements.txt" ] && pip3 install -r "$d/pip-requirements.txt"
    pip3 install -e "$d"
  fi
done

# Harvest workers (replaces supervisord, which the 2.11 image doesn't include)
if [ "${CKAN_HARVEST_WORKERS:-false}" = "true" ]; then
  mkdir -p /srv/app/logs
  ( sleep 60; while true; do ckan -c "$CKAN_INI" harvester gather-consumer >> /srv/app/logs/gather_consumer.log 2>&1; sleep 10; done ) &
  ( sleep 60; while true; do ckan -c "$CKAN_INI" harvester fetch-consumer  >> /srv/app/logs/fetch_consumer.log  2>&1; sleep 10; done ) &
  ( while true; do sleep 900; ckan -c "$CKAN_INI" harvester run >> /srv/app/logs/harvester_run.log 2>&1; done ) &
fi

# Hand off to the normal startup script
exec /srv/app/start_ckan_development.sh
