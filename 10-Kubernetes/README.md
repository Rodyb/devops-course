## Container Orchestration with Kubernetes
### Demo Projects and Descriptions

1. **Deploy MongoDB and Mongo Express into Local K8s Cluster**
    - **Technologies Used**: Kubernetes, Docker, MongoDB, Mongo Express
    - **Description**:
        - Set up a local K8s cluster with Minikube.
        - Deploy MongoDB and Mongo Express with configuration and credentials extracted into ConfigMap and Secret.

2. **Deploy Mosquitto Message Broker with ConfigMap and Secret Volume Types**
    - **Technologies Used**: Kubernetes, Docker, Mosquitto
    - **Description**:
        - Define configuration and passwords for Mosquitto message broker using ConfigMap and Secret Volume Types.

3. **Install a Stateful Service (MongoDB) on Kubernetes Using Helm**
    - **Technologies Used**: Kubernetes, Helm, MongoDB, Mongo Express, Linode LKE, Linux
    - **Description**:
        - Create a managed K8s cluster with Linode Kubernetes Engine.
        - Deploy replicated MongoDB service in the cluster using a Helm chart.
        - Configure data persistence for MongoDB with Linode’s cloud storage.
        - Deploy UI client Mongo Express for MongoDB.
        - Configure ingress to access the UI application from the browser.

4. **Deploy Your Web Application in K8s Cluster from Private Docker Registry**
    - **Technologies Used**: Kubernetes, Helm, AWS ECR, Docker
    - **Description**:
        - Create secrets for credentials for the private Docker registry.
        - Configure the Docker registry secret in the application deployment.
        - Deploy a web application image from the private Docker registry to the K8s cluster.

5. **Deploy Microservices Application in Kubernetes with Production & Security Best Practices**
    - **Technologies Used**: Kubernetes, Redis, Linux, Linode LKE
    - **Description**:
        - Create K8s manifests for deployments and services for all microservices of an online shop application.
        - Deploy microservices to Linode’s managed Kubernetes cluster.

6. **Create Helm Chart for Microservices**
    - **Technologies Used**: Kubernetes, Helm
    - **Description**:
        - Create a shared Helm chart for all microservices to reuse common deployment and service configurations.

7. **Deploy Microservices with Helmfile**
    - **Technologies Used**: Kubernetes, Helm, Helmfile
    - **Description**:
        - Deploy microservices using Helm.
        - Deploy microservices with Helmfile.

## Technologies used
- Kubernetes
- Docker
- MongoDB
- Mongo Express
- Mosquitto
- Helm
- Linode LKE
- Linux
- AWS ECR
- Redis
- Helmfile