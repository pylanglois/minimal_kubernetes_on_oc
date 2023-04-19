#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

oc login ${OPENSHIFT_CLUSTER_URL} -u ${OPENSHIFT_USERNAME} -p ${OPENSHIFT_PASSWORD} --insecure-skip-tls-verify
oc project ${OPENSHIFT_NAMESPACE} 

envsubst < ${SCRIPT_DIR}/../kubernetes/deployment-redis.yaml | kubectl delete -f -
envsubst < ${SCRIPT_DIR}/../kubernetes/service-redis.yaml | kubectl delete -f -

envsubst < ${SCRIPT_DIR}/../kubernetes/deployment-http.yaml | kubectl delete -f -
envsubst < ${SCRIPT_DIR}/../kubernetes/service-http.yaml | kubectl delete -f -

envsubst < ${SCRIPT_DIR}/../kubernetes/route-http.yaml | kubectl delete -f -

oc logout
