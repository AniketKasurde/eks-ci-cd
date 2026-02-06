#!/usr/bin/env bash
set -ex

# Log everything to a custom file for easier debugging
exec > >(tee /var/log/user-data.log)
exec 2>&1

echo "========== Starting user data script =========="

# Update and Install basics
echo "Installing basic packages..."
apt-get update -y
apt-get install -y curl unzip fontconfig openjdk-21-jre wget apt-transport-https ca-certificates gnupg lsb-release

# Install Jenkins (Official LTS)
echo "Installing Jenkins..."
mkdir -p /etc/apt/keyrings
wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
  tee /etc/apt/sources.list.d/jenkins.list > /dev/null

apt-get update -y
apt-get install -y jenkins
systemctl enable jenkins
systemctl start jenkins

# Wait for Jenkins to start
echo "Waiting for Jenkins to initialize..."
sleep 10

# Install Docker & Permissions
echo "Installing Docker..."
apt-get install -y docker.io
systemctl enable docker
systemctl start docker

# Add jenkins user to docker group
usermod -aG docker jenkins
usermod -aG docker ubuntu  # If you're using Ubuntu AMI


# Restart Jenkins to pick up new group membership
echo "Restarting Jenkins to apply Docker permissions..."
systemctl restart jenkins

# Wait for Jenkins to restart
sleep 10

# Install AWS CLI
echo "Installing AWS CLI..."
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
./aws/install --update
rm -rf awscliv2.zip ./aws

# Verify AWS CLI installation
aws --version

# Install kubectl
echo "Installing kubectl..."
K8S_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin/


# Create kubeconfig directory for jenkins user
mkdir -p /var/lib/jenkins/.kube
chown jenkins:jenkins /var/lib/jenkins/.kube

