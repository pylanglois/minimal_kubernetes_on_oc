#!/bin/bash

if [ ! -f ./.env ]
then
    echo "ERROR!"
    echo "You need to create the file .env with proper value. see .env-example for reference"
    exit 1
fi

source .env

# Read Password
echo -n Openshift password for the user ${OPENSHIFT_USERNAME}:
read -s OPENSHIFT_PASSWORD
export OPENSHIFT_PASSWORD
