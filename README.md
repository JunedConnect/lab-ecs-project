# Threat Composer App Deployment

This project automates the deployment of the **Threat Composer App** using **AWS**, **Terraform**, **Docker**, and **CI/CD pipelines**. Originally set up manually using **AWS Console**, the process has been automated to provide a secure, scalable, and streamlined deployment.

<br>

## Overview

The **Threat Composer App** is a containerised Node.js application deployed on **AWS ECS Fargate**. The deployment process is fully automated using **CI/CD pipeline** to handle Docker image building, security scans, and deployment to AWS through **Terraform**.

<br>

### Key Components:

- **Dockerisation**: The app is containerised using a **Dockerfile** for consistency across environments.

- **Infrastructure as Code (IaC)**: Terraform provisions the following AWS resources:
    - **ECS Fargate** for serverless container orchestration.
    - **Application Load Balancer (ALB)** for routing HTTP/HTTPS traffic.
    - **Route 53** for custom domain name mapping.
    - **Security Groups** to control network access.
    - **VPC, Subnets, and Internet Gateway** to establish the network architecture.

- **CI/CD Pipeline**: GitHub Actions automate:
    - **Building and pushing the Docker image** to **Amazon ECR**.
    - **Applying Terraform** to deploy or update AWS infrastructure.
    - **Performing security and compliance scans** to ensure code quality and security.
    - **Destroying Terraform resources** when necessary.

<br>

## Directory Structure

```
./
├── Docker
│   ├── app
│   │   └── Dockerfile
│   └── docker-compose.yml
├── Terraform
│   ├── modules
│   │   ├── alb
│   │   ├── ecs
│   │   ├── network
│   │   └── route53
│   ├── main.tf
│   ├── provider.tf
│   └── variables.tf
└── .github
    └── workflows
        ├── DockerBuild&Deploy.yml
        ├── TerraformApply.yml
        └── TerraformDestroy.yml
```

- **Docker Files**:
    - **Dockerfile**: Defines the app's containerised environment.
    - **docker-compose.yml**: Manages the app's container configuration for local development.

- **Terraform Files**:
    - **modules/alb**: Sets up the **Application Load Balancer** (ALB).
    - **modules/ecs**: Configures the **ECS Cluster** and **Fargate service**.
    - **modules/network**: Provisions **Security Groups**, **VPC**, and **Subnets**.
    - **modules/route53**: Manages **Route 53 DNS records** and **SSL certificates**.
    - **main.tf**: Defines the AWS infrastructure using Terraform modules.
    - **provider.tf**: Specifies the AWS provider configuration.
    - **variables.tf**: Stores configurable values for the Terraform setup.

- **CI/CD Pipelines (`.github/workflows/`)**:
    - **DockerBuild&Deploy.yml**:
        - Builds and pushes the Docker image to **ECR**.
        - Runs **Trivy** to scan the image for vulnerabilities.
    
    - **TerraformApply.yml**:
        - Applies the Terraform configuration to provision AWS resources.
        - Runs **TFLint** and **Checkov** for security and syntax checks.
    
    - **TerraformDestroy.yml**: Destroys Terraform-managed infrastructure.

<br>

## CI/CD Deployment Workflow

The deployment process is fully automated via GitHub Actions:

1. **Docker Image Build & Deployment** (`DockerBuild&Deploy.yml`):
    - Builds the Docker image.
    - Runs **Trivy** to scan for critical vulnerabilities before pushing to ECR.
    - Pushes the image to **Amazon ECR**.
    
2. **Terraform Apply** (`TerraformApply.yml`):
    - Initialises and applies the Terraform configuration.
    - Provisions the necessary AWS resources (ECS, ALB, Route 53, Security Groups).
    - Runs **TFLint** to validate Terraform syntax and best practices.
    - Runs **Checkov** to scan for security issues in Terraform code.
    
3. **Terraform Destroy** (`TerraformDestroy.yml`):
    - Destroys all Terraform-managed resources when necessary.

<br>

To trigger any of these workflows, go to **GitHub Actions** and manually run the desired workflow.
