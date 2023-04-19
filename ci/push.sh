#!/usr/bin/env bash

oc login ${OPENSHIFT_CLUSTER_URL} -u ${OPENSHIFT_USERNAME} -p ${OPENSHIFT_PASSWORD} --insecure-skip-tls-verify
oc project ${OPENSHIFT_NAMESPACE} 
docker login -p $(oc whoami -t ) -u unused ${OPENSHIFT_REGISTRY}

docker push ${OPENSHIFT_REGISTRY}/${OPENSHIFT_NAMESPACE}/${APPLICATION_NAME}-redis:latest
docker push ${OPENSHIFT_REGISTRY}/${OPENSHIFT_NAMESPACE}/${APPLICATION_NAME}-http:latest

docker logout ${OPENSHIFT_REGISTRY}
oc logout 
