kubectl apply -f ./capstone-deployment.yml
kubectl get pods -l run=cap-deployment -o wide
# kubectl get pods -l app=cap-service -o wide
# kubectl get pods -l run=cap-service -o yaml | grep podIP