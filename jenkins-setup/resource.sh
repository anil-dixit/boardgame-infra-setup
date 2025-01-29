#!/bin/bash

# Update package lists
sudo apt update -y

# Update the system
sudo apt upgrade -y

# Install software-properties-common
sudo apt install -y software-properties-common

# Add Ansible PPA and install Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# Add HashiCorp GPG key and repository, then install Terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y
sudo apt install -y terraform

# Install OpenJDK 17
sudo apt install -y openjdk-17-jre

# Add Jenkins repository and install Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins

# Enable and start Jenkins service
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Create a directory named 'terraform' and terraform files 
# Install Git
echo "Installing Git..."
sudo apt-get install -y git

sudo -u ubuntu mkdir -p /home/ubuntu/k8s

echo "Cloning repository..."
git clone https://username:token@github.com/anil-dixit/k8s-cluster-setup.git /home/ubuntu/k8s

echo "Changing directory to /home/ubuntu/k8s"
cd /home/ubuntu/k8s

# Install dos2unix if available
if ! command -v dos2unix &> /dev/null
then
    echo "dos2unix not found, installing it..."
    sudo apt-get update
    sudo apt-get install -y dos2unix
else
    echo "dos2unix is already installed"
fi

# Convert line endings of all .sh files to Unix format
echo "Converting line endings..."
find /home/ubuntu/k8s -type f -name "*.sh" -exec dos2unix {} \;

# Generate an SSH key pair without prompts 
sudo -u ubuntu ssh-keygen -t rsa -b 2048 -f /home/ubuntu/.ssh/id_rsa -q -N ""

# Extract the public key 
pub_key=$(sudo cat /home/ubuntu/.ssh/id_rsa.pub) 

# Append the public key to terraform.tfvars as a variable 
echo "ssh_public_key = \"$pub_key\"" | sudo tee -a /home/ubuntu/terraform/terraform.tfvars

# Install dependencies
sudo apt install -y wget gnupg

# Add Trivy repository
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee /etc/apt/sources.list.d/trivy.list

# Update package list and install Trivy
sudo apt update
sudo apt install -y trivy

# Verify installation
trivy --version

# Example usage: Scan a Docker image
# Replace <image_name> with the name of the Docker image you want to scan
# trivy image <image_name>

echo "Trivy installation and configuration completed successfully!"

# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install kubectl
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin
kubectl version --short --client

# Download the latest Node Exporter release
echo "Downloading Node Exporter..."
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

# Extract the tar file
echo "Extracting Node Exporter..."
tar -xvf node_exporter-1.6.1.linux-amd64.tar.gz

# Remove the tar file
echo "Removing tar file..."
rm node_exporter-1.6.1.linux-amd64.tar.gz

# Change to the extracted directory
cd node_exporter-1.6.1.linux-amd64

# Start Node Exporter in the background
echo "Starting Node Exporter..."
./node_exporter &

echo "Node Exporter installation and start complete!"

sudo usermod -aG docker jenkins




