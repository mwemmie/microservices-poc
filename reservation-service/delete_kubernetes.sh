#!/bin/bash

# delete the service
kubectl delete service reservation-service

# delete the deployment
kubectl delete deployment reservation-service