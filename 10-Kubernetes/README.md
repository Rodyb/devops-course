 ## Chapter 10: Kubernetes

## Exercise 1 & 2
- `minikube start --kubernetes-version=stable`

# Exercise 3
- Created a configmap that reflects the environment variables similar to the Docker compose
- The secrets I added to a secret file with a base64 encoding (still in prod would do it more secure by adding it to the CI/CD tool)
- all yaml files can be found in the Java folder: java.yaml, pma.yaml, mysql.yaml 
- `kubectl apply -f configmap.yaml`
- `kubectl apply -f secret.yaml`
- `kubectl apply -f java.yaml`
- `kubectl apply -f pma.yaml`
- `kubectl apply -f mysql.yaml`

# Exercise 4 
- Created a pma.yaml added replica 1

# Exercise 5
- Removed the LoadBalancer type and nodePort
- Added an ingress.yaml
- Install Ingress in minikube `minikube addons enable ingress`

# Exercise 6
- `sudo vim /etc/hosts`
- add the domain to the host file i.e. bla.com
- Deployed ingress `kubectl apply -f ingress.yml` 
- `minikube tunnel` 

# Exercise 7
- `kubectl port-forward deployment/phpmyadmin-deployment 8083:80`
- Then go to localhost:8083 and you will see it. 

# Exercise 8
- Transform the separate files into a helm chart see folder: Java/java-app-chart
- `helm install new-app ./java-app-chart`