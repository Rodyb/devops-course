##  Create Docker repository on Nexus and push to it
- Install nexus on server: http://157.245.75.110:8083
- Update docker bearer token in Nexus "Docker realm"
- docker login to 157.245.75.110:8083
- docker tag <some tag> 157.245.75.110:8083:/<some tag>
- docker push 157.245.75.110:8083:/<some tag>

``{
"builder": {
"gc": {
"defaultKeepStorage": "20GB",
"enabled": true
}
},
"insecure-registries" : ["http://157.245.75.110:8083"]
"experimental": false
}``
