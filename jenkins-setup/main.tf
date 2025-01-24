resource "aws_instance" "web" {
  ami                    = "ami-09b0a86a2c84101e1"
  instance_type          = "t2.medium"
  key_name               = "puttyKey"
  user_data              = templatefile("./resource.sh", {})

  tags = {
    Name = "Master"
  }
  root_block_device {
    volume_size = 30
  }
}
resource "aws_instance" "sonarqube" {
  ami                    = "ami-09b0a86a2c84101e1"
  instance_type          = "t2.medium"
  key_name               = "puttyKey"
  user_data              = templatefile("./sonarqube.sh", {})

  tags = {
    Name = "Sonar"
  }
  root_block_device {
    volume_size = 20
  }
}
resource "aws_instance" "nexus" {
  ami                    = "ami-09b0a86a2c84101e1"
  instance_type          = "t2.medium"
  key_name               = "puttyKey"
  user_data              = templatefile("./nexus.sh", {})

  tags = {
    Name = "Nexus"
  }
  root_block_device {
    volume_size = 20
  }
}
resource "aws_instance" "monitor" {
  ami                    = "ami-09b0a86a2c84101e1"
  instance_type          = "t2.medium"
  key_name               = "puttyKey"
  user_data              = templatefile("./monitor.sh", {})

  tags = {
    Name = "Monitor"
  }
  root_block_device {
    volume_size = 20
  }
}
