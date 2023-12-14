#!/bin/bash

echo "Cloning dataloader repo and install requirements"
git clone https://github.com/national-data-platform/ckan-data-loader;
cd ckan-data-loader;
#git checkout pgml_data_script;
pip install -r requirements.txt
echo "Run data population script in the background"
source ./prepopulate_data_script.sh &


