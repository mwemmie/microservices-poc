#!/bin/bash

cd reservation-service
sh build_docker_deploy_kubernetes.sh

cd ../reservation-client
sh build_docker_deploy_kubernetes.sh
