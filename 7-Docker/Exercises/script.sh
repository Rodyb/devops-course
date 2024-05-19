#!/bin/bash

#NEXUS_URL="http://localhost:8081"
NEXUS_URL="http://nexus:8081"


REPO_NAME="docker"
BLOB_STORE_NAME="docker-default"

# Create JSON payload for repository creation
JSON_PAYLOAD=$(cat <<EOF
{
  "name": "$REPO_NAME",
  "online": true,
  "storage": {
    "blobStoreName": "$BLOB_STORE_NAME",
    "strictContentTypeValidation": true,
    "writePolicy": "ALLOW_ONCE"
  },
  "docker": {
    "v1Enabled": true,
    "forceBasicAuth": true,
    "httpPort": 8085,
    "forceHostname": true,
    "cleanup": {
      "policyNames": [
        "docker:hosted"
      ]
    }
  }
}
EOF
)
container_id=$(docker ps -aqf "name=nexus_container")

if [ -f .env ]; then
    source .env
fi

# Check if the container ID is not empty
if [ -n "$container_id" ]; then
    echo "Container ID: $container_id"

    # Use docker exec to retrieve admin.password
    TMP_PASSWORD=$(docker exec "$container_id" cat /nexus-data/admin.password)
    echo "NEXUS_ADMIN: $NEXUS_ADMIN"

    # Print the retrieved password
    echo "Retrieved Password: $TMP_PASSWORD"
else
    echo "Container not found or not running."
fi

curl --location --request PUT "${NEXUS_URL}/service/rest/v1/security/users/admin/change-password" \
--header 'accept: application/json' \
--header 'Content-Type: text/plain' \
--header "Authorization: Basic $(echo -n ${NEXUS_ADMIN}:${TMP_PASSWORD} | base64)" \
--data "${NEXUS_PASSWORD}"

# Create Blob Store
curl --location "${NEXUS_URL}/service/rest/v1/blobstores/file" \
--header 'Content-Type: application/json' \
--header "Authorization: Basic $(echo -n ${NEXUS_ADMIN}:${NEXUS_PASSWORD} | base64)" \
--data '{
  "softQuota": {
    "type": "spaceRemainingQuota",
    "limit": 1
  },
  "path": "string",
  "name": "'"${BLOB_STORE_NAME}"'"
}'

# Create Docker Hosted Repository
curl -v --location "$NEXUS_URL/service/rest/v1/repositories/docker/hosted" \
  --header 'Content-Type: application/json' \
  --header "Authorization: Basic $(echo -n ${NEXUS_ADMIN}:${NEXUS_PASSWORD} | base64)" \
  --data-raw "$JSON_PAYLOAD"

## Login into docker, build the image and push it.
docker login -u ${NEXUS_ADMIN} -p ${NEXUS_PASSWORD} 127.0.0.1:8085
docker build -t java_test:latest -f Dockerfile .
docker tag java_test:latest 127.0.0.1:8085/java_test:latest
docker push 127.0.0.1:8085/java_test:latest
