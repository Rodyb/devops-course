#!/bin/bash

# Nexus Repository Manager base URL
NEXUS_URL="http://localhost:8081"

# Source admin credentials from the environment variables
source nexus_credentials.env

# Team-specific details
TEAM_NAME="project2-team"
USER_NAME="project2-user"
USER_PASSWORD="project2-password"

# Repository details
REPO_NAME="maven-repo"
GROUP_ID="com.example"
ARTIFACT_ID="my-project"
VERSION="1.0.0"
JAR_FILE="${PWD}/java/build-tools-exercises/build/libs/build-tools-exercises-1.0-SNAPSHOT.jar"

# Build the project (Assuming you have a Maven project)
#mvn clean install

# Create a Maven hosted repository
curl --location "${NEXUS_URL}/service/rest/beta/repositories/maven/hosted" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data '{
    "name": "'"${REPO_NAME}"'",
    "online": true,
    "storage": {
        "blobStoreName": "default",
        "strictContentTypeValidation": true,
        "writePolicy": "ALLOW_ONCE"
    },
    "maven": {
        "versionPolicy": "RELEASE",
        "layoutPolicy": "STRICT"
    }
}'

# Create Nexus user for Team 2
curl --location "${NEXUS_URL}/service/rest/v1/security/users" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data-raw '{
     "userId": "'"${USER_NAME}"'",
      "firstName": "rody-user-2",
      "lastName": "b",
      "emailAddress": "rodybothe2@gmail.com",
      "password": "'"${USER_PASSWORD}"'",
      "status": "active",
      "roles" :["nx-admin"]
}'

# Assign Team 2 user to npm repository role
curl --location "${NEXUS_URL}/service/rest/beta/security/roles/readers" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data-raw '{
    "userId": "'"${USER_NAME}"'",
    "source": "default",
    "roles": ["nx-repository-view-maven-'"${TEAM_NAME}"'-repo-read"]
}'

# Upload jar to Repository
curl --verbose --user "${USER_NAME}:${USER_PASSWORD}" --upload-file "${JAR_FILE}" \
  "${NEXUS_URL}/repository/${REPO_NAME}/${GROUP_ID}/${ARTIFACT_ID}/${VERSION}/${ARTIFACT_ID}-${VERSION}.jar"
