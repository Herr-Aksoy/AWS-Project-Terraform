variable "user_name" {
  default = "ramo"            # description = "Kullanıcı adı"     #
}

# variable "region" {
#   default = "us-east-1"
# }

# variable "instance_type" {
#   default = "t2.micro"
# }

# variable "vpc_cidr_block" {
#   description = "CIDR for the vpc" 
#   default     = "10.0.0.0/16"
# }

# variable "public_subnet_cidr_block" {
#   description = "CIDR for the public subnet" 
#   default     = "10.0.1.0/24"
# }
# variable "private_subnet_cidr_block" {
#   description = "CIDR for the private subnet" 
#   default     = "10.0.2.0/24"
# }

# variable "server_name" {
#   default = [
#     "ubuntu","ec2-user"
#   ]
# }

variable "instance_name" {
  default = [
    "ubuntu-nginx","centos-grafana"
  ]
}


