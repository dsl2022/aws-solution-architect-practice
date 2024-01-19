variable "ami_id" {  
  description = "The AMI ID to use for the instances"
  default = "ami-0005e0cfe09cc9050"
}

variable "key_name" {
  description = "The key name to use for the instance"
  default = "eni-ec2-demo"
}
