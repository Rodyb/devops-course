##  Create Docker repository on Nexus and push to it
- Install nexus on server: <ip>:8083
- Update docker bearer token in Nexus "Docker realm"
- Select http instead of https
- docker login to <ip>:8083
- docker tag <some tag> <ip>:8083:/<some tag>
- docker push <ip>:8083:/<some tag>

``{
"builder": {
"gc": {
"defaultKeepStorage": "20GB",
"enabled": true
}
},
"insecure-registries" : ["<ip>:8083"]
"experimental": false
}``
