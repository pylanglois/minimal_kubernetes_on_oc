#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

docker build -t ${OPENSHIFT_REGISTRY}/${OPENSHIFT_NAMESPACE}/${APPLICATION_NAME}-http:latest \
             -f ${SCRIPT_DIR}/../dockerfiles/http_dockerfile --no-cache .

docker build -t ${OPENSHIFT_REGISTRY}/${OPENSHIFT_NAMESPACE}/${APPLICATION_NAME}-redis:latest \
             -f ${SCRIPT_DIR}/../dockerfiles/redis_dockerfile --no-cache .
