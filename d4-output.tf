
## route NAt ekleme direk komut

data "aws_route_table" "proje2_private_rt" {
  vpc_id = aws_vpc.proje2_vpc.id
  depends_on = [ aws_route_table.proje2_private_rt ]

  tags = {
    Name = "proje2-private-RT"
  }
}

data "aws_instance" "nat_instance" {
    depends_on = [ aws_instance.nat_instance ]
  filter {
    name   = "tag:Name"
    values = ["Proje2 Nat Instance"]
  }

    filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

output "create_route_command" {
  value = "aws ec2 create-route --route-table-id ${data.aws_route_table.proje2_private_rt.id} --destination-cidr-block 0.0.0.0/0 --instance-id ${data.aws_instance.nat_instance.id}"
}


# Bu kisim ansible direk baglanmak icin ssh baglantisi

data "aws_instance" "example" {
    depends_on = [ aws_instance.ornek ]
  filter {
    name   = "tag:Name"
    values = ["Ansible-instance"]
  }
  
  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

output "ssh_command" {
  value = "ssh -i 'ramo.pem' ec2-user@${data.aws_instance.example.public_dns}"
}


# Bu kisim Load Balancer DNS name

output "load_balancer_dns" {
  value = aws_lb.proje2ALB.dns_name
}


# Burasi auto scaling olusturdugu Ec2 privat ipsi

# output "privatIpler" {
#   value = "aws ec2 describe-instances --filters 'Name=tag:Name,Values=proje2_web_server' 'Name=instance-state-name,Values=running' --query 'Reservations[].Instances[].[PrivateIpAddress]' --output text"
# }





data "aws_instances" "proje2_running_instances" {
  depends_on = [ aws_db_instance.proje2_rds ]
  instance_tags = {
    Name = "proje2_web_server"
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

locals {
  ip_addresses = data.aws_instances.proje2_running_instances[*].private_ips

  ip1 = can(local.ip_addresses[0]) ? tostring(local.ip_addresses[0][0]) : null
  ip2 = can(local.ip_addresses[0]) && length(local.ip_addresses[0]) > 1 ? tostring(local.ip_addresses[0][1]) : null
}

# output "IP1" {
#   value = local.ip1
# }

# output "IP2" {
#   value = local.ip2
# }








# burasi tamamdir

# data "aws_instances" "proje2_running_instances" {
#   depends_on = [ aws_db_instance.proje2_rds ]
#   instance_tags = {
#     Name = "proje2_web_server"
#   }

#   filter {
#     name   = "instance-state-name"
#     values = ["running"]
#   }
# }

# output "private_ips_running_instances" {
#   value = data.aws_instances.proje2_running_instances.*.private_ips
# }











