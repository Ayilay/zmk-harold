#!/bin/bash

usage() {
    echo "Usage: $0 <version>"
}

if [ $# -ne 1 ]; then 
    usage;
    exit 1
fi

suff=$1


node ~/github/ergogen/src/cli.js harold_${suff}.yaml -o outputs_${suff} --debug
