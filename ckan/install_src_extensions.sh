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
# Hand off to the normal startup script
exec /srv/app/start_ckan_development.sh
