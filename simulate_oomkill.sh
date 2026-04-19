#!/bin/bash
echo "Simulating OOMKill memory exhaustion on backend pod..."

POD_NAME=$(kubectl get pod -l app=backend -o jsonpath='{.items[0].metadata.name}')
echo "Targeting pod: $POD_NAME"

echo "Starting memory exhaustion inside container..."
kubectl exec $POD_NAME -- sh -c '
  # Allocate memory by writing to /dev/shm which counts against memory limit
  i=0
  while true; do
    dd if=/dev/zero of=/dev/shm/fill$i bs=1M count=10 2>/dev/null
    i=$((i+1))
    echo "Allocated ${i}0MB so far..."
  done
'