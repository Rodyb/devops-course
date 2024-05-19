#!/bin/bash

# Nexus Repository Manager base URL
NEXUS_URL="http://localhost:8081"

# Source admin credentials from the environment variables
source nexus_credentials.env
AUTH_HEADER=$(echo -n "${ADMIN_USERNAME}:${ADMIN_PASSWORD}" | base64)

response=$(curl --location "${NEXUS_URL}/service/rest/v1/components?repository=npm-repo&sort=version" \
--header "Authorization: Basic ${AUTH_HEADER}")

# Extract downloadUrl using jq
downloadUrl=$(echo "$response" | jq -r '.items[0].assets[0].downloadUrl')

# Download the artifact and place it in folder
mkdir downloadFolder
wget --http-user=${ADMIN_USERNAME} --http-password=${ADMIN_PASSWORD} -O "downloadFolder/artifact-1.0.0.tgz" "$downloadUrl"
tar -tzvf downloadFolder/artifact-1.0.0.tgz
tar -xzvf artifact-1.0.0.tgz -C downloadFolder --strip-components=1

echo "Download URL: $downloadUrl"