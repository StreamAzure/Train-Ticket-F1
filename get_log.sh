#!/bin/bash

# Set the namespace
NAMESPACE="default"

# Get all pod names in the specified namespace
POD_NAMES=$(kubectl get pods -n $NAMESPACE --output=jsonpath='{.items[*].metadata.name}')

# Loop through each pod and print its logs
for POD in $POD_NAMES; do
  echo "Logs for Pod: $POD"
  kubectl logs -n $NAMESPACE $POD
  echo "-------------------------"
done
