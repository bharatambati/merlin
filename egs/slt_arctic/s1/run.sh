#!/bin/bash

if test "$#" -ne 0; then
    echo "Usage: ./run.sh"
    exit 1
fi

### Step 1: setup directories and the training data files ###
echo "Step 1: setting up experiments directory and the training data files..."
global_config_file=conf/global_settings.cfg
./scripts/setup.sh slt_arctic_dnn_world
./scripts/prepare_config_files.sh $global_config_file

if [ ! -f  $global_config_file ]; then
    echo "Global config file doesn't exist"
    exit 1
else
    source $global_config_file
fi

### Step 2: train duration model ###
echo "Step 2: training duration model..."
./scripts/submit.sh ${MerlinDir}/src/run_merlin.py conf/duration_configfile.conf

### Step 3: train acoustic model and synthesize speech ###
echo "Step 3: training acoustic model and synthesizing speech..."
./scripts/submit.sh ${MerlinDir}/src/run_merlin.py conf/acoustic_configfile.conf
