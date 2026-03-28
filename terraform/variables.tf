variable "aws_region" {
  description = "AWS region to deploy in"
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI (us-east-1)"
  default     = "ami-0261755bbcb8c4a84"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"   # Free Tier eligible
}

variable "key_name" {
  description = "Your AWS key pair name (for SSH)"
  default     = "my-key-pair"  # CHANGE THIS
}
