#!/bin/bash
# Harvest workers (CKAN 2.11 images ship without supervisord).
# Enabled only where CKAN_HARVEST_WORKERS=true (main catalog).
if [ "${CKAN_HARVEST_WORKERS:-false}" = "true" ]; then
  mkdir -p /srv/app/logs
  ( sleep 60; while true; do ckan -c "$CKAN_INI" harvester gather-consumer >> /srv/app/logs/gather_consumer.log 2>&1; sleep 10; done ) &
  ( sleep 60; while true; do ckan -c "$CKAN_INI" harvester fetch-consumer  >> /srv/app/logs/fetch_consumer.log  2>&1; sleep 10; done ) &
  ( while true; do sleep 900; ckan -c "$CKAN_INI" harvester run >> /srv/app/logs/harvester_run.log 2>&1; done ) &
  echo "Harvest workers started"
fi
