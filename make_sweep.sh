#!/bin/bash

# Ensure a file path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <file_path>"
    exit 1
fi

# Load environment variables
source ~/.secrets/env.sh

# Run the curl command with the provided file path
curl -X POST -F "file=@$1" $SWEEP_SERVER:$SWEEP_PORT/upload_config
