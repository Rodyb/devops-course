#!/bin/bash

if [ -f .env ]; then
    source .env
fi

#Set TOKEN for Digital Ocean
DO_API_TOKEN=${AUTH_TOKEN}

# DigitalOcean API endpoint for listing SSH keys
SSH_KEYS_API_URL="https://api.digitalocean.com/v2/account/keys"

# Fetch all existing SSH keys using
keys_response=$(curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DO_API_TOKEN" "$SSH_KEYS_API_URL")

# Extract the fingerprint of the first SSH key (you may modify this logic based on your needs)
ssh_key_fingerprint=$(echo "$keys_response" | jq -r '.ssh_keys[0].fingerprint')

# DigitalOcean API endpoint for creating droplets
CREATE_DROPLET_API_URL="https://api.digitalocean.com/v2/droplets"

# Set desired Droplet configuration
DROPLET_NAME="testdroplet"
REGION="ams3"
SIZE="s-4vcpu-8gb"
IMAGE="ubuntu-20-04-x64"
SSH_KEYS_API_URL="https://api.digitalocean.com/v2/account/keys"

# DigitalOcean API endpoint for creating droplets
API_URL="https://api.digitalocean.com/v2/droplets"

# Create JSON payload with Droplet configuration
JSON_DATA=$(cat <<EOF
{
  "name": "$DROPLET_NAME",
  "region": "$REGION",
  "size": "$SIZE",
  "image": "$IMAGE",
  "ssh_keys": ["$ssh_key_fingerprint"]
}
EOF
)

# Make the API request to create the droplet using cURL
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $DO_API_TOKEN" -d "$JSON_DATA" "$API_URL"

DROPLET_URL="https://api.digitalocean.com/v2/droplets?name=testdroplet"

# Retrieve the public IP address
public_ip=$(curl -s --location "${DROPLET_URL}" \
                 --header 'Content-Type: application/json' \
                 --header "Authorization: Bearer ${AUTH_TOKEN}" | jq -r '.droplets[0].networks.v4[] | select(.type == "public").ip_address')

# Loop until the public IP address is available
while [ -z "$public_ip" ]; do
    echo "Public IP address not available yet. Waiting..."
    sleep 5  # Wait for 5 seconds before polling again
    public_ip=$(curl -s --location "${DROPLET_URL}" \
                   --header 'Content-Type: application/json' \
                   --header "Authorization: Bearer ${AUTH_TOKEN}" | jq -r '.droplets[0].networks.v4[] | select(.type == "public").ip_address')
done

echo "Public IP Address: $public_ip"

service_port=22
# Loop until the server is ready to accept connections
while true; do
    if nc -z "$public_ip" $service_port; then
        echo "Server is ready to accept connections on port $service_port."
        break
    else
        echo "Server not ready yet. Waiting..."
        sleep 5
    fi
done

# Create npm package
cd app
npm pack
cd ..

# Install all needed packages to run the application
ssh -o "StrictHostKeyChecking=no" -T -A -i ~/.ssh/digital_ocean_macbook root@$public_ip << 'EOF'
   echo "Running apt-get update..."
   sudo apt-get update && \
   echo "apt-get update successful. Running node js"
   sudo apt install net-tools
   sudo apt install nodejs -y
   sudo apt-get install npm -y
   node -v && npm -v && mkdir node_app
EOF

# Copy files to server
scp -i ~/.ssh/digital_ocean_macbook app/bootcamp-node-project-1.0.0.tgz root@$public_ip:/root/node_app

## Unpack the tar and install npm, run the application and verify application is running
ssh -A -i ~/.ssh/digital_ocean_macbook root@$public_ip << 'EOF'
   echo "Changing directory to node_app..."
   cd node_app && \
   echo "Extracting tar file..."
   tar -xvzf bootcamp-node-project-1.0.0.tgz && \
   echo "Changing directory to package..."
   cd package && \
   echo "Running npm install..."
   npm install
EOF

# Get Droplet ID by name and open port on firewall
DROPLET_ID=$(curl -s -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $DO_API_TOKEN" "https://api.digitalocean.com/v2/droplets?name=testdroplet" | jq -r ".droplets[] | select(.name == \"$DROPLET_NAME\") | .id")
curl --location 'https://api.digitalocean.com/v2/firewalls' \
     --header 'Content-Type: application/json' \
     --header "Authorization: Bearer ${AUTH_TOKEN}" \
     --data '{
         "name": "SpecialFireWall",
         "inbound_rules": [
             {
                 "protocol": "tcp",
                 "ports": "22",
                 "sources": {
                     "addresses": ["0.0.0.0/0"]
                 }
             },
             {
                 "protocol": "tcp",
                 "ports": "3000",
                 "sources": {
                     "addresses": ["0.0.0.0/0"]
                 }
             }
         ],
         "droplet_ids": ["'$DROPLET_ID'"]
     }'
sleep 5
ssh -A -i ~/.ssh/digital_ocean_macbook root@$public_ip << 'EOF'
   pwd
   cd node_app/package
   echo "Starting server..."
   nohup node server.js > server.log 2>&1 &
   # Wait for a moment to allow the server to start
   sleep 5
   echo "Checking port 3000..."
    ss -tuln
EOF

# Check if the specified port is open
nc -zv "$public_ip" "3000"

# Display the result
if [ $? -eq 0 ]; then
    echo "Port 3000 is open and accessible."
else
    echo "Port 3000 is not accessible."
fi

