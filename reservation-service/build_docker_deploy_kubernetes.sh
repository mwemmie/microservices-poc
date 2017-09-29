#!/bin/bash

# Build app
./mvnw -DskipTests clean package

# Build docker image
docker build -t reservation-service:v1 .

# Deploy to Kubernetes and expose as a service on kubernetes
sh deploy_kubernetes.sh