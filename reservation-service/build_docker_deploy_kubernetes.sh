#!/bin/bash

# Build app
./mvnw -DskipTests clean package

# Build docker image
docker build -t reservation-service:v1 .

# Deploy to Kubernetes
kubectl run reservation-service --image=reservation-service:v1 --port=8080

# Expose as a service on kubernetes
kubectl expose deployment reservation-service --port=80 --target-port=8080