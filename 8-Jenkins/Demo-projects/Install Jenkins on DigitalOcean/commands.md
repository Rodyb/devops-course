## Create digital ocean Droplet
- Create a droplet on digital ocean 
- Install docker and add a docker user to the droplet
- `apt update`
- `apt install docker.io`
- ``docker run -p 8080:8080 -p 50000:50000 -d -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts``
- Retrieve the initial password
- `docker exec -it <container> /bin/bash`
- `cat var/jenkins_home/secrets/initialAdminPassword`
---
Run Docker commands in Jenkins container
---
- `ls -l /var/run/docker.sock` change permissions
- `chmod 666 /var/run/docker.sock`
