cat << 'EOF' > README.md
# 🔗 Serverless URL Shortener

🚀 **Live Demo:** [https://urlx.jhoja.tech/](https://urlx.jhoja.tech/)

A highly scalable, production-ready URL Shortener built with **AWS Serverless architecture**, managed via **Terraform (IaC)**, and deployed through an automated **CI/CD Pipeline**.

---

## 🛠️ Tech Stack
- **Cloud Backend:** AWS Lambda (Python), API Gateway, DynamoDB
- **Frontend & Hosting:** Docker, Nginx, AWS EC2 (Amazon Linux)
- **DevOps & IaC:** Terraform, GitHub Actions
- **Security & Networking:** Let's Encrypt (Certbot) SSL, Custom Domain, CORS

---

## 🏗️ Architecture Summary
1. **Serverless Core:** Handles high-speed URL generation and dynamic redirection with zero server maintenance.
2. **Containerized UI:** Lightweight HTML/JS interface served via a Dockerized Nginx web server.
3. **Automated CI/CD:** GitHub Actions automatically provisions SSL certificates, builds the Docker image, and deploys the application to EC2 on every push.

---

## ⚙️ Quick Deployment Guide

**1. Provision Infrastructure (Terraform)**
```bash
cd terraform
terraform init
terraform apply -auto-approve

---

**2. Configure CI/CD (GitHub Actions)**

Add the following Secrets to your repository:

EC2_HOST : Public IP of the EC2 instance

EC2_USER : ec2-user

EC2_SSH_KEY : The Terraform-generated RSA private key

---

3. Automated Release
Push code to the main branch. The pipeline will automatically handle SSL setup and Docker container deployment.

👨‍💻 Author: Aatif | Cloud & DevOps Engineer
Email: m.aatif0123@gmail.com