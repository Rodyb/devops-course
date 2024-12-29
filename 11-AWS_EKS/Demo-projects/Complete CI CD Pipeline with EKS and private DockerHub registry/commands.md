## 
- Create docker registry secret on Kubernetes
  kubectl create secret docker-registry my-registry-key \
  --docker-server=docker.io \
  --docker-username=rodybothe2 \
  --docker-password=<somepass> 
