## Chapter 11: AWS with EKS

# Exercise 1: 
- Run `./create_cluster.sh`

# Exercise 2:
deploy mysql & pma
- `kubectl create ns aws-test`
- `kubectl apply -f Java/mysql.yaml -n aws-test`
- `kubectl apply -f Java/pma.yaml -n aws-test`

Verify mysql is accessible
- `kubectl port-forward deployment/phpmyadmin-deployment 8083:80 -n aws-test`
- Go to localhost:8083 and see the phpmyadmin deployment

# Exercise 3: 
the namespace name needs to be the same as the fargate name
- `kubectl create ns java-application`

my docker is public so no authentication needed
- `kubectl apply -f Java/secret.yml -n java-application`
- `kubectl apply -f Java/configmap.yml -n java-application`
- `kubectl apply -f Java/mysql.yaml -n java-application`
- `kubectl apply -f Java/java.yaml -n java-application`

Scale the amount of replicas of the java app
- `kubectl scale deployment java-app-deployment --replicas=3 -n java-application`

# Exercise 4: 
- Make sure `docker_registry` has been executed on the instance in the Jenkins container once.
- See Jenkinsfile in Maven directory

# Exercise 5: 
