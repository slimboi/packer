# Packer plugin for AWS
packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.6"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = ">= 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

# AMI configuration
source "amazon-ebs" "amazon-linux" {
  region        = "eu-west-2"
  ami_name      = "ami-version-1.0.1-{{timestamp}}"
  instance_type = "t2.micro"
  source_ami    = "ami-05ea2888c91c97ca7"
  ssh_username  = "ec2-user"
  ami_regions = [
    "eu-west-2"
  ]
}

# Build process with Ansible provisioner
build {
  name = "hq-packer"
  sources = [
    "source.amazon-ebs.amazon-linux"
  ]

  # Ansible provisioner
  provisioner "ansible" {
    playbook_file = "playbook.yml"  # Path to your Ansible playbook
  }
}