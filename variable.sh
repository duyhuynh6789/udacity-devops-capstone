kubectl get service > service.txt
if grep -q 'capstone-frontend' service.txt; then
  kubectl describe service capstone-frontend > capstone.txt
  if grep -q "role=green" capstone.txt; then
    echo 'COLOR=blue'
  else
    echo 'COLOR=green'
  fi
else
  echo ' COLOR=blue' 
fi