## Deploy nexus as docker container
- Create Digital Ocean server
- SSH into the server `ssh root@157.245.75.110`
- `apt install docker.io`
- Create docker user 
- `docker pull sonatype/nexus3`
- `docker run -d -p 8081:8081 --name nexus -v /nexus-data:/nexus-data sonatype/nexus3`
- Find original password `docker exec -it nexus cat /nexus-data/admin.password`
- Access: 157.245.75.110:8081 and enter the password found in previous step

