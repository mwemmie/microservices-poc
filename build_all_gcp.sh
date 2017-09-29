#!/bin/bash

# First build a cluster of GCP.  This takes a while (minutes) ...
gcloud container clusters create microservice-poc-cluster \
  --num-nodes 2 \
  --machine-type n1-standard-1 \
  --zone us-central1-c

sh build_all_except_cluster_gcp.sh
