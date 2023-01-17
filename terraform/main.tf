provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_security_group" "my-sg" {
  vpc_id = module.vpc.vpc_id
  name   = join("_", ["sg", module.vpc.vpc_id])

  dynamic "ingress" {
    for_each = var.rules

    content {
      from_port   = ingress.value["from"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_Rules"
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "default_key2"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "jenkins" {
  count = 1

  ami                    = "ami-0039da1f3917fa8e3"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = module.vpc.public_subnets[count.index % length(module.vpc.public_subnets)]
  vpc_security_group_ids = [aws_security_group.my-sg.id]
  user_data = templatefile("${path.module}/init-script.sh", {
    file_content = "temp content"
  })

  tags = {
    Name = "Jenkins.EC2.micro"
  }
}