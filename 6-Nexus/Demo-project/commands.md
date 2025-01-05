## Run Nexus on Droplet and Publish Artifact to Nexus
- Create droplet
- SSH into the droplet: 167.99.209.26
- Install `sudo apt update && sudo apt install openjdk-11-jdk`
- wget https://download.sonatype.com/nexus/3/nexus-3.53.0-01-unix.tar.gz
- cd /opt
- adduser nexus
- chown -R nexus:nexus nexus-3.53.0-01
- chown -R nexus:nexus sonatype-work
- vim nexus-3.53.0-01/bin/nexus.rc and add user nexus
- su - nexus
- /opt/nexus-3.53.0-01/bin/nexus start
- open port 8081 on Digital ocean in networking
- Find password: `/opt/sonatype-work/nexus3`
- Access Nexus: 167.99.209.26:8081
- Create a new Nexus user after initial login: Security > Users > Create user
- Add the permissions to the user

## Java App
- Go to the java-app and update the build.gradle file and build.gradle
- Add the connection tot the Nexus repository with publishing and publications
- Add the repository in which you want to push it to
- Add gradle.properties file with credentials
- Build the gradle app: `gradle build`
- Publish gradle app to repository `gradle publish`
- Check maven-snapshots

## Java Maven App
- In pom.xml add the Nexus configuration url etc..
- Go to `~/.m2/settings.xml` and update the username and password
- Go to the java-maven-app and do `mvn package` after that `mvn deploy`
- Check maven-snapshots