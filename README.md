# Minimal kubernetes deployment on Openshift 4  
Trying to document an almost pure kubernetes deployment without openshift flavor, except Route.  

## Prerequisites  
- kubectl: https://kubernetes.io/docs/tasks/tools/  
- oc: https://mirror.openshift.com/pub/openshift-v4/clients/oc/latest/  
- envsubst: from gettext. for windows see: https://superuser.com/a/1193133  

## Deploy the demo  

1. copy the file .env-example to .env  
1. edit .env with the proper values for your context  
1. from a bash terminal at project root (in the same folder as the file named load_env.sh) run:
```shell  
source load_env.sh   
ci/all.sh  
```  

## Explanation  

Things to know:  
 - Kubernetes is stateless. You should not run a database in a pod because data will be lost each time the pod restarts.  
 - Openshift runs container without root privileges. You will need to tweak your docker image accordingly. see chmod.    
 - Deployment defines how to run a container (name, image, environments, ...).  
 - Service allows 2 sets of containers to communicate and is scoped by the namespace.  
 - Route is an Openshift plugins that allows to access a Service from the outside with an URL using an internal DNS feature.  
 - You need to tag your image with the name of the Openshift registry. The full name is expected in the Deployment.  

The command `source ./load_env.sh` creates environment variables that allow to fill the blank in the files from the folder `dockerfiles/`, `kubernetes/` and `ci/`. This command will ask for your openshift password because we don't want to keep this password in a file.  
Linux shell scripts can substitute environment variable automatically. `kubectl` don't. For this reason, we use `envsubst` that allows to replace the variables in kubernetes files with the actual values. This allows to use git to keep the configuration without the sensitive data. The file `.env` contains the sensitive data and is not versioned.   

ci/all.sh runs those scripts in sequence:  
 - build.sh: build all dockerfiles from the folder dockerfiles/, tag them with the proper name.  
 - push.sh: push the image into the openshift registry.  
 - deploy.sh: deploy all the configuration from the folder kubernetes/ on Openshift and restart existing Deployment.  

