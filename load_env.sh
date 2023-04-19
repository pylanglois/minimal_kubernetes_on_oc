#!/bin/bash

source .env

# Read Password
echo -n Openshift password for the user ${OPENSHIFT_USERNAME}:
read -s OPENSHIFT_PASSWORD
export OPENSHIFT_PASSWORD
