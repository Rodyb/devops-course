#!/bin/bash

# Nexus Repository Manager base URL
NEXUS_URL="http://localhost:8081"

# Source admin credentials from the environment variables
source nexus_credentials.env

# Blob Store details
BLOB_STORE_NAME="npm-blob-store"

# Team-specific details
TEAM_NAME="project1-team"
USER_NAME="project1-user"
USER_PASSWORD="project1-password"

# Create Blob Store
curl --location "${NEXUS_URL}/service/rest/v1/blobstores/file" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data '{
  "softQuota": {
    "type": "spaceRemainingQuota",
    "limit": 1
  },
  "path": "string",
  "name": "'"${BLOB_STORE_NAME}"'"
}'

# Repository details
REPO_NAME="npm-repo"

# Create npm repository with the Blob Store
curl --location "${NEXUS_URL}/service/rest/beta/repositories/npm/hosted" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data '{
    "name": "'"${REPO_NAME}"'",
    "online": true,
    "storage": {
        "blobStoreName": "'"${BLOB_STORE_NAME}"'",
        "strictContentTypeValidation": true,
        "writePolicy": "ALLOW_ONCE"
    }
}'

# Create Nexus user for Team 1
curl --location "${NEXUS_URL}/service/rest/v1/security/users" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data-raw '{
     "userId": "'"${USER_NAME}"'",
      "firstName": "rody",
      "lastName": "b",
      "emailAddress": "rodybothe@gmail.com",
      "password": "'"${USER_PASSWORD}"'",
      "status": "active",
      "roles" :["nx-admin"]
}'

# Assign Team 1 user to npm repository role
curl --location "${NEXUS_URL}/service/rest/beta/security/roles/readers" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data-raw '{
    "userId": "'"${USER_NAME}"'",
    "source": "default",
    "roles": ["nx-repository-view-npm-'"${TEAM_NAME}"'-repo-read"]
}'

# Authenticate NPM
curl --location --request PUT "${NEXUS_URL}/service/rest/v1/security/realms/active" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${ADMIN_USERNAME}:${ADMIN_PASSWORD} | base64)" \
--data '[
    "NexusAuthenticatingRealm",
    "NpmToken"
]'

AUTH_HEADER=$(echo -n "${ADMIN_USERNAME}:${ADMIN_PASSWORD}" | base64)

# Build and publish a Node.js tar package to the npm repository
npm pack
npm set registry http://localhost:8081/repository/npm-repo/:_auth=${AUTH_HEADER}
npm publish --registry="${NEXUS_URL}/repository/${REPO_NAME}/"

# Verify package is uploaded
curl --location "${NEXUS_URL}/service/rest/v1/components?repository=${REPO_NAME}" \
--header 'Accept: application/json' \
--header "Authorization: Basic ${AUTH_HEADER}"

# Check the exit status of the curl command
if [ $? -eq 0 ]; then
  echo "success all good"
else
  echo "error no file found"
fi