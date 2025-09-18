#!/bin/bash
output=$(bash script.sh)
if [ "$output" == "Hello DevOps" ]; then
    echo "Test OK"
    exit 0
else
    echo "Test FAILED"
    exit 1
fi
