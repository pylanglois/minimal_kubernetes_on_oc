#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

oc login ${OPENSHIFT_CLUSTER_URL} -u ${OPENSHIFT_USERNAME} -p ${OPENSHIFT_PASSWORD} --insecure-skip-tls-verify
oc project ${OPENSHIFT_NAMESPACE}

# Deploy configuration
envsubst < ${SCRIPT_DIR}/../kubernetes/deployment-redis.yaml | kubectl apply -f -
envsubst < ${SCRIPT_DIR}/../kubernetes/service-redis.yaml | kubectl apply -f -

envsubst < ${SCRIPT_DIR}/../kubernetes/deployment-http.yaml | kubectl apply -f -
envsubst < ${SCRIPT_DIR}/../kubernetes/service-http.yaml | kubectl apply -f -

envsubst < ${SCRIPT_DIR}/../kubernetes/route-http.yaml | kubectl apply -f -

# Restart all deployment
kubectl wait --for=condition=available --timeout=10s deployment/${APPLICATION_NAME}-deployment-redis
kubectl rollout restart deployment/${APPLICATION_NAME}-deployment-redis

kubectl wait --for=condition=available --timeout=60s deployment/${APPLICATION_NAME}-deployment-http
kubectl rollout restart deployment/${APPLICATION_NAME}-deployment-http

oc logout