## Commands
- aws ecr get-login-password —region-eu-central-1 | docker login —username AWS —password-stdin
  626212666125.dkr.ecr.eu-central-1.amazonaws.com
- cat .docker/config.json | base64
- sh
  kubectl create secret generic my-registry-key \
  --from-file=.dockerconfigjson=.docker/config.json \
  --type=kubernetes.io/dockerconfigjson