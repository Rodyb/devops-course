## Kubernetes on AWS - EKS
### Demo Projects and Descriptions
1. **Create AWS EKS Cluster with a Node Group**
    - **Technologies Used**: Kubernetes, AWS EKS
    - **Description**:
        - Create an EKS cluster with a CloudFormation template for worker nodes.
        - Add a Node Group for worker nodes and attach it to the EKS cluster.
        - Configure auto-scaling for the worker nodes.
        - Deploy a sample application to the EKS cluster.

2. **Create EKS Cluster with Fargate Profile**
    - **Technologies Used**: Kubernetes, AWS EKS, AWS Fargate
    - **Description**:
        - Create an EKS cluster with a Fargate profile.
        - Deploy a sample application to the EKS cluster using Fargate.

3. **Create EKS Cluster with eksctl**
    - **Technologies Used**: Kubernetes, AWS EKS, eksctl, Linux
    - **Description**:
        - Use `eksctl` to automate the creation of an EKS cluster, reducing manual effort.

4. **CD - Deploy to EKS Cluster from Jenkins Pipeline**
    - **Technologies Used**: Kubernetes, Jenkins, AWS EKS, Docker, Linux
    - **Description**:
        - Install kubeconfig and AWS IAM authenticator on the Jenkins server.
        - Add AWS credentials and configure Jenkins for deployment.
        - Deploy the application to the EKS cluster as part of the CI/CD pipeline.

5. **CD - Deploy to LKE Cluster from Jenkins Pipeline**
    - **Technologies Used**: Kubernetes, Jenkins, Linode LKE, Docker, Linux
    - **Description**:
        - Create an LKE cluster on Linode.
        - Install kubeconfig in Jenkins and deploy to the LKE cluster.

6. **Complete CI/CD Pipeline with EKS and Private DockerHub Registry**
    - **Technologies Used**: Kubernetes, Jenkins, AWS EKS, Docker Hub, Java, Maven, Linux, Docker, Git
    - **Description**:
        - Write K8s manifests for deployment and service configuration.
        - Integrate deployment in the CI/CD pipeline to deploy applications from DockerHub.
        - Pipeline Steps:
            - Build Java Maven artifact.
            - Build and push Docker image to DockerHub.
            - Deploy application image to the EKS cluster.

7. **Complete CI/CD Pipeline with EKS and AWS ECR**
    - **Technologies Used**: Kubernetes, Jenkins, AWS EKS, AWS ECR, Java, Maven, Linux, Docker, Git
    - **Description**:
        - Authenticate Docker for AWS ECR.
        - Adjust Jenkins to build and push Docker images to AWS ECR.
        - CI/CD Steps:
            - Build artifact for Java Maven application.
            - Build and push Docker image to AWS ECR.
            - Deploy application image to the EKS cluster.
            - Commit the version updates.

---

### Technologies used
- **Kubernetes**
- **AWS EKS**
- **AWS Fargate**
- **eksctl**
- **Jenkins**
- **Linode LKE**
- **Docker**
- **Docker Hub**
- **AWS ECR**
- **Java**
- **Maven**
- **Linux**
- **Git**