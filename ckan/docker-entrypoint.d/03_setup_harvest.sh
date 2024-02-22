#!/bin/bash

echo "Cloning dataloader repo and install requirements"
git clone https://github.com/national-data-platform/ckan-data-loader -b feature-copy-harvested-org-logos;
cd ckan-data-loader;
pip install -r requirements.txt
echo "Run harvest setup in the background"
source ./setup_harvester.sh &


