## Chapter 7: Dockerize an application

## Exercise 1 & 2
- Done locally

# Exercise 3


## Exercise 4
- Created a simple dockerfile that creates a folder /app and runs the CMD which created the JAR file 7-Docker/build/libs/bootcamp-java-mysql-project-1.0-SNAPSHOT.jar

## Exercise 5 & 6
- Added Nexus to the docker compose, it starts up, creates a blob store and creates a docker hosted repository. After that, it changes the initial password from the admin via the API in a script. `./script.js`
- Logs into to docker, Builds, tags and pushes the image to the docker hosted repository.


## NOTE
- I have added Nexus to the docker compose file this to have a working setup without having costs from the cloud provider. Normally the Nexus application will be running on the cloud provider. 