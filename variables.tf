# variables.tf
variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "master_instance_type" {
  description = "Instance type for the master EC2 instance"
  type        = string
}

variable "slave_instance_type" {
  description = "Instance type for the slave EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for the EC2 instance"
  type        = string
}
