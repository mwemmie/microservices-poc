#!/bin/bash

# Build and deploy reservation-service microservice
cd reservation-service
sh build_docker.sh
sh push_docker_registry_gcp.sh
sh deploy_kubernetes.sh

# Build and deploy reservation-service microservice
cd ../reservation-client
sh build_docker.sh
sh push_docker_registry_gcp.sh
sh deploy_kubernetes.sh
