provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"
  name = "main-vpc"
  cidr = var.vpc_cidr_block

  azs             = data.aws_availability_zones.available.names
  private_subnets = []
  public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway = false
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
  key_name   = "default_key3"
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "jenkins" {
  count = 1

  ami                    = "ami-0039da1f3917fa8e3"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.generated_key.key_name
  subnet_id              = module.vpc.public_subnets[count.index % length(module.vpc.public_subnets)]
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 32
    volume_type = "gp2"
  }

  user_data = templatefile("${path.module}/init-script.sh", {
    file_content = "temp content"
  })

  tags = {
    Name = "Jenkins.EC2.micro"
  }
}

resource "aws_lb_target_group" "jenkins" {
  name     = "jenkins-lb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "jenkins" {
  count            = length(aws_instance.jenkins)
  target_group_arn = aws_lb_target_group.jenkins.arn
  target_id        = aws_instance.jenkins[count.index].id
  port             = 80
}

resource "aws_lb" "app" {
  name               = "main-app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [aws_security_group.my-sg.id]
}

resource "aws_lb_listener" "app" {

  load_balancer_arn = aws_lb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type            = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.jenkins.arn
        weight = 100
      }

      stickiness {
        enabled  = false
        duration = 1
      }
    }
  }
}