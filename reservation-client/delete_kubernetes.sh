#!/bin/bash

# delete the service
kubectl delete service reservation-client

# delete the deployment
kubectl delete deployment reservation-client