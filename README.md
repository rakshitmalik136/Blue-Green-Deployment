# Zero-Downtime Blue-Green Deployment Lab

## Overview
In a production environment, deploying a new version of an app shouldn't crash the site for users. This project demonstrates a **Blue-Green Deployment** strategy using **Nginx** as a Load Balancer to switch traffic between two identical environments with **zero downtime**.

## Tech Stack
* **Orchestration:** Docker & Docker Compose
* **Web Server / Load Balancer:** Nginx
* **Automation:** Bash Scripting
* **CI/CD:** Jenkins

## System Architecture
The setup consists of three containers:
1.  **nginx-lb**: Acts as the Reverse Proxy and Traffic Switch.
2.  **app_blue**: Running Version 1.0 of the application.
3.  **app_green**: Running Version 2.0 of the application.

## Project Structure
```text
blue-green-deploy/
├── app
│   ├── index-blue.html
│   └── index-green.html
├── docker-compose.yml
├── jenkins
│   └── Jenkinsfile
├── nginx
│   ├── Dockerfile
│   └── nginx.conf
├── README.md
└── scripts
    └── script.sh
```

## How it Works
1.  **Blue** is currently live. Users access the site via port `8081`.
2.  The `scripts/script.sh` automates the update of the Nginx configuration.
3.  By running `nginx -s reload`, the traffic shifts from Blue to Green instantly without dropping active connections.

## How to Run Locally
1. Clone the repo:
   ```bash
   git clone https://github.com/rakshitmalik136/Blue-Green-Deployment.git
   ```
2. Start and Build Containers
   ```bash
   docker-compose up -d --build
   ```
3. Run the script
   ```bash
   chmod 774 ./scripts/script.sh
   ./scripts/script.sh
   ```
4. Visit Port
   ```bash
   http://localhost:8081
   ```

## Learning Outcomes
* High Availability: Understanding how to eliminate downtime during updates.
* Reverse Proxy Management: Configuring Nginx upstreams and proxy headers.
* Linux Automation: Using sed and file streams to manipulate live production configs.
* Infrastructure Resilience: Implementing "Revert-on-Failure" logic in deployment scripts.
* Docker Volumes: Solving complex Inode and SELinux file-binding issues.

## In Future
* Integrate Prometheus for real-time monitoring of traffic shifts.
* Migrate orchestration to Kubernetes (EKS/Minikube) using Ingress Controllers.
* Implement automated Health Checks before switching traffic.

## Author
**Rakshit Malik**
