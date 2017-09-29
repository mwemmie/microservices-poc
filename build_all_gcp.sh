#!/bin/bash

# First build a cluster of GCP.  This takes a while (minutes) ...
gcloud container clusters create microservice-poc-cluster \
  --num-nodes 2 \
  --machine-type n1-standard-1 \
  --zone us-central1-c

# Build and deploy reservation-service microservice
cd reservation-service
sh build_docker_deploy_kubernetes.sh

# Build and deploy reservation-service microservice
cd ../reservation-client
sh build_docker_deploy_kubernetes.sh
