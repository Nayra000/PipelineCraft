
# 🚀 Jenkins-Based CI/CD Pipeline with Ansible, Docker, and Terraform

## 📘 Project Overview

This project implements a robust **CI/CD pipeline** to automate the deployment of a **Node.js application** on AWS infrastructure using:
- **Jenkins** (CI/CD orchestration)
- **Ansible** (configuration management)
- **Terraform** (infrastructure as code) 
- **Docker** (containerization)
- **Slack** (notifications and alerts)

The infrastructure features:
- Private EC2 instance running the application
- Application Load Balancer (ALB) for public access
- Bastion host for secure access to private resources

---

## 🌟 Key Features

### 🏗️ Infrastructure Automation with Terraform
- **VPC Architecture**: Public and private subnets with proper routing
- **Compute Resources**:
  - EC2 instances (Jenkins slave in private subnet)
  - Bastion host in public subnet
- **Networking**:
  - Application Load Balancer (ALB)
  - Security groups with least-privilege access

### 🔔 Slack Integration
- Real-time notifications for:
  - Pipeline start/completion
  - Build failures
  - Deployment status
  - Infrastructure changes
- Configurable alert channels for:
  - Development team
  - Operations team
  - Critical alerts

### ⚙️ Configuration Management with Ansible
- **Jenkins Slave Setup**:
  - Installs OpenJDK 17
  - Configures Docker and Docker Compose
  - Creates Jenkins working directory
  - Sets up proper user permissions
- **Secure Access Pattern**:
  - Uses `ProxyCommand` via bastion host
  - SSH key-based authentication
  - No public IP required for private instance

### 🛠️ Jenkins Pipeline Automation
- **Multi-stage CI/CD Pipeline**:
  1. **Build & Test**: Node.js application
  2. **Deploy**: Docker containers via compose
  3. **Provision/Destroy**: AWS infrastructure
  4. **Notify**: Slack channel on pipeline events
- **Secure Agent Connection**:
  - SSH tunnel through bastion host
  - Local port forwarding (2222 → private instance:22)

---

## 🔍 Detailed Components

### 🔗 Secure Jenkins Slave Connection
**SSH Tunnel Configuration**:
```bash
ssh -N -L 2222:10.0.2.249:22 proxy
```

**SSH Config (~/.ssh/config)**:
```ssh-config
Host proxy
    HostName 3.81.201.193
    User ubuntu
    IdentityFile /home/nayra/project/id_rsa
```

### 💬 Slack Notification Setup
**Jenkins Configuration**:
1. Install "Slack Notification" plugin
2. Configure Slack workspace connection:
   ```jenkins
   Slack Connection:
   - Workspace: your-team.slack.com
   - Credential: Slack bot token
   - Default Channel: #build-notifications
   ```
3. Add pipeline steps:
   ```
    post {
        success {}
        failure {}
      }

   ```

---

## 🛠️ Technology Stack

| Component       | Purpose                          |
|-----------------|----------------------------------|
| **Terraform**   | Infrastructure provisioning      |
| **Ansible**     | Configuration management         |
| **Jenkins**     | CI/CD pipeline orchestration     |
| **Docker**      | Application containerization     |
| **AWS**         | Cloud infrastructure             |
| **Slack**       | Notifications and alerts         |

---

## 🚀 Getting Started

### Prerequisites
- AWS account with credentials
- local machine contains jenkins ,terraform , node js and ansible
- Jenkins with SSH and Slack plugins
- Docker and Docker Compose on the private instance
- Slack workspace with admin permissions

### Deployment Steps
1. **Infrastructure Provisioning**:
   - Trigger TerraformApply pipeline to build the infrastrucure
   - Trigger TerraformDestroy pipeline to destroy the infrastrucure

2. **Configure Slack Integration**:
   - Configure Jenkins Slack plugin
   - Test notification flow

3. **Run CI/CD Pipeline**:
   - Trigger developPipeline for testing app 
   - Monitor Slack for build status
   - Trigger productionPipeline for deployment
   - Receive deployment confirmation in Slack

---

## 🔒 Security Considerations
- Private EC2 instances have no public IP
- All access via bastion host with SSH keys  
- Security groups restrict traffic to minimum required



