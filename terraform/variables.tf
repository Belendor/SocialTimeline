variable "region" {
  description = "The region Terraform deploys your instances"
  type        = string
  default     = "eu-central-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_count" {
  description = "Number of public subnets."
  type        = number
  default     = 2
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]
}

variable "rules" {
  type = list(object({
    from        = number
    port        = number
    proto       = string
    cidr_blocks = list(string)
  }))

  default = [
    {
      from        = 1
      port        = 60000
      proto       = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}