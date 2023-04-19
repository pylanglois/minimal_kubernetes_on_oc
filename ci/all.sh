#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# build docker image
echo "## BUILDING IMAGE ##"
source ${SCRIPT_DIR}/build.sh

# push to oc registry
echo "## PUSHING IMAGE TO OPENSHIFT ##"
source ${SCRIPT_DIR}/push.sh

# deploy and rollout to oc
echo "## DEPLOY AND ROLLOUT TO OPENSHIFT ##"
source ${SCRIPT_DIR}/deploy.sh