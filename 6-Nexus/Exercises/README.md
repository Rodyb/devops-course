## Chapter 6: Nexus Sonatype  

## PRE-STEPS
- Pull the image `docker pull sonatype/nexus3`
- Run the container `docker run -d -p 8081:8081 --name nexus-container sonatype/nexus3`
- Get the password `docker exec -it nexus-container cat /nexus-data/admin.password`
- Go to the http://localhost:8081 and change the password for the admin to be able to use the script

## Note
- If you run it like this, Nexus will not keep the changes that you make. To keep the changes: `docker run -d -p 8081:8081 --name nexus \
  -v /path/on/host/data:/nexus-data \
  -v /path/on/host/sonatype-work:/sonatype-work \
  sonatype/nexus3
  `

## EXERCISE 1 to 4 
- Update the created credentials from the presteps in `nexus_credentials.env`
- Run the following command when the docker container is up and running `./npm_hosted.sh` this will create a blobstore, create the repository, create a user and create a team where the user is in via the API. 

## EXERCISE 5 to 7
- Run the following command when the docker container is up and running `./maven_hosted.sh` this create a maven hosted repository and create a team with a specific. It will upload the jar file via the API.

## EXERCISE 8 & 9
- Run the following command when the docker container is up and running `./download.sh` this will download the file from the repository from Nexus and extract in a folder
