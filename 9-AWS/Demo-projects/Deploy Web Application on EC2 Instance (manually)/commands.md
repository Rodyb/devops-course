# Create an EC2 instance on AWS with the correct image
- create an ec2 instance with the correct image 
- sudo apt update
- apt install docker.io
- verify docker is installed
- create docker group and add user
- docker login rodybothe2
- docker pull rodybothe2/node-js-aws:latest
- docker run -p 3080:3080 -d rodybothe2/node-js-aws:latest