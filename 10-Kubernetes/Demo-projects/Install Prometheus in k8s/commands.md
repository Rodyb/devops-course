## Install prometheus
- minikube start
- Add helm repo from prometheus 
- Add kube state metrics
- helm install prometheus prometheus-community/prometheus
- kubectl port-forward deploy/prometheus-server 9090
- access localhost:9090