#!/bin/bash
echo "Simulating CPU spike on backend pod..."

POD_NAME=$(kubectl get pod -l app=backend -o jsonpath='{.items[0].metadata.name}')
echo "Targeting pod: $POD_NAME"

echo "Starting CPU stress loop for 5 minutes..."
kubectl exec $POD_NAME -- sh -c '
  END=$(($(date +%s) + 300))
  while [ $(date +%s) -lt $END ]; do
    echo "scale=10000; 4*a(1)" | bc -l > /dev/null 2>&1
  done
  echo "CPU spike complete."
'