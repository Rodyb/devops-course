
- Go to aws and create private repository
- Login to the registry
- aws ecr get-login-password —region-eu-central-1 | docker login —username AWS —password-stdin
  626212666125.dkr.ecr.eu-central-1.amazonaws.com
---
- docker build -t <some tag> .
- docker tag <some tag> 626212666125.dkr.ecr.eu-central-1.amazonaws.com
- docker push 626212666125.dkr.ecr.eu-central-1.amazonaws.com


