#!/bin/bash
echo "Simulating CrashLoopBackOff on backend pod..."

POD_NAME=$(kubectl get pod -l app=backend -o jsonpath='{.items[0].metadata.name}')
echo "Targeting pod: $POD_NAME"

for i in {1..15}; do
  echo "Iteration $i: Killing PID 1 in container..."
  kubectl exec $POD_NAME -- kill 1
  echo "Waiting 5 seconds for restart..."
  sleep 5
done

echo "Done. Check pod restart count with: kubectl get pods"