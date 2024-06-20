# MultiCloudDevOpsProject

Welcome to the MultiCloudDevOpsProject! This project is designed to demonstrate the implementation of a complete DevOps pipeline with multi-cloud support. The project covers infrastructure provisioning, configuration management, containerization, continuous integration, automated deployment, monitoring, and logging. The tools and technologies used include Terraform, Ansible, Docker, Jenkins, and AWS services.

## Project Architecture 
![Diagram](https://raw.githubusercontent.com/marwantarek11/MultiCloudDevOpsProject/main/Marwan%20Diagram.drawio%20(4).svg)
## Table of Contents
- [Prerequisites](#prerequisites)
- [Infrastructure Provisioning with Terraform](#infrastructure-provisioning-with-terraform)
- [Configuration Management with Ansible](#configuration-management-with-ansible)
- [Containerization](#containerization)
- [Automated Deployment Pipeline](#automated-deployment-pipeline)
- [Monitoring and Logging](#monitoring-and-logging)
- [AWS Integration](#aws-integration)
- [Documentation](#documentation)


## Project Structure
```bash
MultiCloudDevOpsProject
├── Ansible
├── Application
├── Terraform
├── OpenShift 
├── jenkinsfile
└── README.md
```

## Prerequisites
  Before using this project, ensure that you have the following prerequisites:

  - Git: For version control and cloning the project repository.
  - AWS Account: For Amazon Web Services
  - Docker: For building and managing containerized applications.
  - Docker Hub Account: For storing Docker images.
  - Kubernetes/OpenShift: For orchestrating containerized applications.
  - Jenkins: For implementing continuous integration and continuous deployment (CI/CD) pipelines.
  
  

### GitHub Repository Setup:
1. Create a new GitHub repository Named "MultiCloudDevOpsProject."

   ```bash
   git clone https://github.com/marwantarek11/MultiCloudDevOpsProject.git`
   ```
3. Create `main`:Contains the production-ready code and `dev`: Used for ongoing development work.

    ```bash
   git checkout -b Dev
   git push origin Dev
   ```

## Infrastructure Provisioning with Terraform

### Task:
Deliver Terraform scripts for AWS resource provisioning, including:
- VPC with specified configurations.
- Subnets within the VPC.
- Security Groups to control inbound and outbound traffic.
- EC2 instances for deploying applications.
- CloudWatch Module Monitoring CPU For EC2.

### Deliverables:
- Terraform Scripts: The Terraform scripts are organized and committed to this repository. They are structured to maintain clarity, modularity, and easy maintenance.
- Use of Terraform Modules: Terraform modules are utilized to encapsulate and reuse infrastructure components efficiently. This promotes consistency and simplifies updates across multiple deployments.

### Repository Structure
The repository structure is designed to maintain clarity and organization:
```bash
Terraform/
├── backend.tf
├── main.tf
├── modules
│   ├── Cloudwatch
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── EC2
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   └── VPC
│       ├── main.tf
│       ├── output.tf
│       └── variables.tf
├── terraform.tfvars
└── variables.tf
```
### Usage Instructions
- Prerequisites:
  
    Install Terraform
    
    AWS CLI configured with appropriate IAM permissions
  
- Getting Started To deploy the infrastructure:
  
    Steps
  
    Navigate to the Terraform Directory:
  
  ```bash
   cd Terraform
  ```
    Initialize Terraform:
    ```bash
      terraform init
    ```
    ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/5e897fcb-15e5-48c3-8322-bd647dd23396)

    ```bash
    terraform apply -auto-approve
    ```
    ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/ead7d522-a462-4584-a03e-ca39c2ca17c4)

  ### Verification
  
  1- VPC
      ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/6e04fc86-1d9a-4e70-943b-8c98f1074e0e)

  2- Security group
      ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/cd39f670-9512-4696-b13e-0ffe99effe38)

  3- EC2
      ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/4f264967-7dc5-49bc-a76b-a5539c3cfb22)


  4- CloudWatch
      ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/8d4d669c-7047-4067-aa3f-d227316c4968)
      ![Screenshot 2024-06-20 092328](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/ade8189a-0e7b-4864-9465-86b4ec6ae64c)


  5- DynamoDB
      ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/1491a9e6-5af2-4276-942d-b91ea7ecbc0f)

  6- S3
      ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/9331d995-17fb-4bc7-a530-aa2cb11e4e25)


## Configuration Management with Ansible

Ansible playbooks and roles for configuring EC2 instances with the specified requirements.

### Task

- Deliver Ansible playbooks for EC2 instance configuration:
  - Install the required packages (e.g., Git, Docker, Java).
  - Install the required packages for Jenkins.
  - Install the required packages for SonarQube.
  - Set up necessary environment variables.

### Deliverables

- Ansible playbooks to Develop Ansible playbooks to automate the configuration tasks mentioned above.
The playbooks should be committed to the repository provided.
- Ansible roles Organize the Ansible playbooks using roles to promote modularity, reusability, and maintainability.
Utilize roles to encapsulate the configuration tasks for Git, Docker, Java, Jenkins, and SonarQube.

### Directory Structure

```plaintext
MultiCloudDevOpsProject/
├── ansible.cfg
├── aws_ec2.yml
├── EC2-KEY.pem
├── playbook.yml
└── roles
    ├── docker
    │   └── tasks
    │       └── main.yml
    ├── Git
    │   ├── tasks
    │   │   └── main.yml
    │   └── vars
    │       └── main.yml
    ├── jenkins
    │   ├── tasks
    │   │   └── main.yml
    │   └── vars
    │       └── main.yml
    ├── packages
    │   └── tasks
    │       └── main.yml
    ├── postgres
    │   └── tasks
    │       └── main.yml
    └── SonarQube
        ├── files
        │   └── sonarqube.service
        └── tasks
            └── main.yml
```

### Usage

1. Ensure you have Ansible installed on your system.
2. Replace `aws_ec2.yml` with your actual inventory file containing EC2 instance details.
3. Replace `EC2-KEY.pem` with your AWS key pair file.
4. Modify `playbook.yml` according to your requirements.
5. Run the playbook using the command:
   ```
   ansible-playbook -i aws_ec2.yml playbook.yml
   ```

### Notes

- Ensure your EC2 instances are accessible and correctly configured with SSH access.
- Modify role variables and tasks as needed to fit your specific environment and requirements.
  
### Verification

1- OutPut
    ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/9465efcc-da81-4a08-9576-e7156d133890)
    
2- Jenkins
    ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/93847a60-4d6a-4144-ad17-b967fe3382ab)

3- SonarQube
    ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/c2c8e402-8cf1-4411-9368-b6aeef15572d)

## Containerization
Containerization plays a crucial role in this project's architecture, facilitating efficient deployment and management of applications. Docker is the primary tool used for containerization.

### Task
Deliver Dockerfile for building the application image.
Below are the key components and tasks related to containerization:

### Dockerfile:
A Dockerfile is provided to build the application image. It includes instructions on how to package the application and its dependencies into a Docker container.
```bash
# Use a minimal base image for building
FROM gradle:7.3.3-jdk11 AS build

# Set the working directory
WORKDIR /app

# Copy only the build files needed for dependency resolution
COPY build.gradle settings.gradle ./

# Download and resolve dependencies using the Gradle Wrapper
COPY gradlew .
COPY gradle gradle
RUN chmod +x gradlew
RUN ./gradlew dependencies

# Copy the rest of the source code
COPY . .

# Build the application using the Gradle Wrapper
RUN chmod +x gradlew
RUN ./gradlew build --stacktrace

# Use a minimal base image for the runtime
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/build/libs/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the port your app runs on
EXPOSE 8080

# Define the command to run your application
CMD ["java", "-jar", "app.jar"]
```

### Image Repository:

The Docker image is pushed to a container registry, such as Docker Hub or a private registry, for storage and distribution.

### Container Deployment:

The Docker image is deployed as containers on the target environment, ensuring consistent and isolated execution of the application.
Deliverables
Dockerfile committed to the repository.

## Automated Deployment Pipeline
instructions for setting up and configuring an automated deployment pipeline using Jenkins. The pipeline includes stages for Git Checkout, Build, Unit Test, SonarQube Test, and Deploy on OpenShift. Additionally, it leverages a shared Jenkins library for reusable functions and configurations.
### Prerequisites
Before setting up the pipeline, ensure you have the following prerequisites:

- Jenkins installed and running.
- Access to a Git repository containing the source code.
- SonarQube server configured and running.
- OpenShift cluster accessible for deployment.
- Necessary credentials and access permissions for Git, SonarQube, and OpenShift.

### Pipeline Stages
The Jenkins pipeline consists of the following stages:

- Git Checkout: Clone the source code from the Git repository.
- Build: Compile the source code.
- Unit Test: Run unit tests to ensure code quality.
- SonarQube Test: Analyze the code using SonarQube for static code analysis.
- Deploy on OpenShift: Deploy the application to the OpenShift cluster.  


### Jenkins Configuration
1- Create Credentials:
  - GitHub token
  - SonarQube token
  - OpenShift token
  - DockerHub token
    ![Screenshot 2024-06-20 103544](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/85d92866-f7e3-417e-a1aa-237517368877)
    
2- Configure SonarQube server under "Configure System".

   ![Screenshot 2024-06-20 103636](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/2244f15b-35c0-4434-ac80-4f92cdb6de15)

3- Configuring Shared Jenkins Library
   Create Shared Library:
  
  - Create a Git repository for your shared library.
  - Define reusable functions and configurations in the vars directory of the shared library repository. [Shared-Library](https://github.com/marwantarek11/Shared-Library-MCDEVOPS.git)
  - Include Shared Library in Jenkins:
  
  - Go to "Manage Jenkins" > "Configure System" > "Global Pipeline Libraries".
  - Add a new library with the name of your shared library repository.

   ![Screenshot 2024-06-20 103816](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/611b4ef7-c300-4b7b-afe5-e3de7546074c)

4- Create a Jenkins Pipeline Job
  - Go to Jenkins Dashboard.
  - Click on "New Item".
  - Enter the job name and select "Pipeline".
  - Click "OK" to create the job.
      ![Screenshot 2024-06-20 103910](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/a704f1b0-56ce-4545-998b-78ab798163fd)
      Configure Pipeline Job
      ![Screenshot 2024-06-20 104026](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/58ae735e-8686-47ba-9262-b3493f62721f)
      Verfiy All Satges Succeed
      ![Screenshot 2024-06-20 110232](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/296fa27c-4768-46d6-bb14-0151c2e3f652)
      Check the SonarQube for Code
      ![Screenshot 2024-06-20 110423](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/ace976e6-7a71-422a-acb5-3475eb29730a)
      Check DockerHub Image
      ![Screenshot 2024-06-20 110757](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/7dd3189a-026e-459e-bf35-c56c98d0c131)
      The Application Deployed on OpenShift
      ![Screenshot 2024-06-20 110505](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/4d33a5a8-1437-4fc5-af71-1787bb220d75)
      Access Appication Using Url in Route
      ![Screenshot 2024-06-20 110532](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/c0610437-41d0-4b17-a987-858a45d54c2a)

      



### Deliverables:
- Jenkinsfile: Pipeline configuration script located in the root directory of your project repository.
- Shared Jenkins Library: Git repository containing reusable Jenkins functions and configurations.


## Monitoring and Logging

### Overview
instructions for setting up centralized logging on OpenShift for container logs. The setup includes the deployment of Elasticsearch, Fluentd, and Kibana (EFK stack) for log aggregation, storage, and visualization.

### Prerequisites
- An OpenShift cluster with administrative access.
- OpenShift CLI (`oc`) installed and configured.
- Sufficient cluster resources to deploy the EFK stack.
- Access to the OpenShift OperatorHub.

### Setup Instructions

### Step 1: Install OpenShift Logging Operator
1. Log in to your OpenShift cluster:
    ```bash
    oc login <OpenShift_API_URL>
    ```
2. Navigate to the OpenShift Web Console.
3. Go to the **OperatorHub**.
4. Search for **OpenShift Logging**.
5. Click **Install** and follow the prompts to install the operator.

### Step 2: Create a Namespace for Logging
1. Create a new namespace for logging components:
    ```bash
    oc create namespace openshift-logging
    ```

### Step 3: Deploy Elasticsearch
1. Create an `Elasticsearch` custom resource (CR):
    ```yaml
    apiVersion: logging.openshift.io/v1
    kind: Elasticsearch
    metadata:
      name: elasticsearch
      namespace: openshift-logging
    spec:
      managementState: Managed
      nodeSpec:
        resources:
          limits:
            memory: 2Gi
          requests:
            memory: 1Gi
        nodeCount: 1
    ```
2. Apply the CR:
    ```bash
    oc apply -f elasticsearch.yaml
    ```

### Step 4: Deploy Fluentd
1. Create a `ClusterLogForwarder` custom resource (CR) to forward logs to Elasticsearch:
    ```yaml
    apiVersion: logging.openshift.io/v1
    kind: ClusterLogForwarder
    metadata:
      name: instance
      namespace: openshift-logging
    spec:
      outputs:
        - name: default
          type: elasticsearch
          endpoint: elasticsearch.openshift-logging.svc:9200
      pipelines:
        - name: default
          inputRefs:
            - infrastructure
            - application
            - audit
          outputRefs:
            - default
    ```
2. Apply the CR:
    ```bash
    oc apply -f cluster-log-forwarder.yaml
    ```

### Step 5: Deploy Kibana
1. Create a `Kibana` custom resource (CR):
    ```yaml
    apiVersion: logging.openshift.io/v1
    kind: Kibana
    metadata:
      name: kibana
      namespace: openshift-logging
    spec:
      managementState: Managed
    ```
2. Apply the CR:
    ```bash
    oc apply -f kibana.yaml
    ```

### Step 6: Configure Log Forwarding
1. Update the `ClusterLogging` custom resource (CR) to include Fluentd, Elasticsearch, and Kibana:
    ```yaml
    apiVersion: logging.openshift.io/v1
    kind: ClusterLogging
    metadata:
      name: instance
      namespace: openshift-logging
    spec:
      managementState: Managed
      logStore:
        type: elasticsearch
        retentionPolicy:
          application:
            maxAge: 7d
        elasticsearch:
          nodeCount: 1
          resources:
            limits:
              memory: 4Gi
            requests:
              memory: 2Gi
      visualization:
        type: kibana
        kibana:
          replicas: 1
      collection:
        logs:
          type: fluentd
          fluentd: {}
    ```
2. Apply the CR:
    ```bash
    oc apply -f cluster-logging.yaml
    ```

### Step 7: Verify the Setup
1. Check the status of the Elasticsearch, Fluentd, and Kibana pods:
    ```bash
    oc get pods -n openshift-logging
    ```
2. Access Kibana via the OpenShift console or directly using the route created in the `openshift-logging` namespace:
    ```bash
    oc get route kibana -n openshift-logging
    ```

### Troubleshooting
- Ensure all pods in the `openshift-logging` namespace are running.
- Check the logs of individual components (Elasticsearch, Fluentd, Kibana) for errors.
- Verify the `ClusterLogForwarder` and `ClusterLogging` resources are correctly configured.


## AWS Integration

### Task:
Provide instructions for integrating AWS services including:
- Use S3 Terraform Backend state.
- Integrate CloudWatch for monitoring.

### Deliverables:
- Instructions for AWS integration in the Terraform code.
  
  S3 Backend ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/9331d995-17fb-4bc7-a530-aa2cb11e4e25)

  DynamoDB Lock State ![image](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/1491a9e6-5af2-4276-942d-b91ea7ecbc0f)

  Cloud Watch for Monitoring CPU For Ec2 ![Screenshot 2024-06-20 110722](https://github.com/marwantarek11/MultiCloudDevOpsProject/assets/167176241/0b885f47-061b-43b9-8a00-0463d54a079e)




## Troubleshooting Guidelines
Common Issues
1- Terraform Errors:

Ensure that your cloud provider credentials are correctly set up in the .env file.
```bash
AWS_ACCESS_KEY_ID=your_aws_access_key_id
AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key
```
Verify that you have the necessary permissions to create resources.

2- Ansible Errors:

Check the inventory file to ensure all hosts are correctly listed.
Ensure that the SSH keys are correctly configured for the remote machines.

2-Docker Issues:

If Docker containers fail to build, check the Dockerfile for errors.
Ensure that Docker Daemon is running.

3-OpenShift Issues:

If OpenShift resources fail to apply, check the manifest files for syntax errors.
Ensure that the OpenShift cluster is properly configured and running.
Logs and Monitoring
Check Terraform logs in the terraform directory.
Check Ansible logs in the ansible directory.
Use docker logs <container_id> to view Docker container logs.
Use oc logs <pod_name> to view OpenShift pod logs.

## Documentation 

| Resource                     | Link                               |
|------------------------------|------------------------------------|
| Ansible Documentation        | [Ansible Documentation](https://docs.ansible.com/)        |
| Ansible Galaxy               | [Ansible Galaxy](https://galaxy.ansible.com/)             |
| Jenkins Documentation        | [Jenkins Documentation](https://www.jenkins.io/doc/)      |
| Docker Documentation         | [Docker Documentation](https://docs.docker.com/)          |
| Terraform Documentation      | [Terraform Documentation](https://www.terraform.io/docs/) |
| SonarQube Documentation      | [SonarQube Documentation](https://docs.sonarqube.org/)    |
| OpenShift CLI Documentation  | [OpenShift CLI Documentation](https://docs.openshift.com/container-platform/4.6/cli_reference/index.html) |
| AWS EC2 Documentation        | [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/) |
