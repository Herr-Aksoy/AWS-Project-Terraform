

resource "aws_key_pair" "Mykeypair" {
  key_name   = var.user_name
  public_key =  tls_private_key.rsa.public_key_openssh  #"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}


resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "local_file" "Mykeypair" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "${var.user_name}.pem"     ## BUrada path belirtiliyor. userdan alacagiz variable olarak
  file_permission = "400"
}


locals {
  my_private_key_content = tls_private_key.rsa.private_key_pem
}

# locals {
#   my_private_key_content = tls_private_key.rsa.private_key_pem
#   pem_key_name = var.user_name
#   another_value = "another data"
# }



