## Create digital 
- Create a droplet on digital ocean 
- Install docker and add a docker user to the droplet
- ``docker run -p 8080:8080 -p 50000:50000 -d -v /var/run/docker.sock:/var/run/docker.sock -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts``
- 