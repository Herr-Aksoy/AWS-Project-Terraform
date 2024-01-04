


resource "aws_instance" "nat_instance" {
  ami           = "ami-0e64637f6498ed00f"
  instance_type = "t2.micro"
  key_name      = var.user_name       #"neu"
  source_dest_check = false // Kaynak/Hedef doğrulama ayarını durdurma (stop) işlemi
  user_data = data.template_file.user_data_template.rendered
  
  subnet_id     = aws_subnet.proje2_public_subnet[0].id
  vpc_security_group_ids = [aws_security_group.proje2_NAT_Sec_Group.id]

  tags = {
    Name = "Proje2 Nat Instance"
  }


  root_block_device {
    volume_size = 8
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
  }

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_network_interface" "nat_network_interface" {
  subnet_id         = aws_subnet.proje2_public_subnet[0].id
  security_groups   = [aws_security_group.proje2_NAT_Sec_Group.id]
}



# resource "aws_instance" "nat_instance" {
#   ami           = "amzn2-ami-kernel-5.10-hvm-2.0.20231116.0-x86_64-gp2"
#   instance_type = "t2.micro"
#   key_name      = "your_key_pair_name"
  
#   subnet_id     = aws_subnet.proje2_public_subnet[0].id
#   vpc_security_group_ids = [aws_security_group.proje2_NAT_Sec_Group.id]

#   tags = {
#     Name = "Proje2 Nat Instance"
#   }

#   network_interface {
#     subnet_id   = aws_subnet.proje2_public_subnet[0].id
#     security_groups = [aws_security_group.proje2_NAT_Sec_Group.id]
#   }

#   root_block_device {
#     volume_size = 8
#   }


#   metadata_options {
#     http_endpoint               = "enabled"
#     http_tokens                 = "optional"
#   }

#   ebs_block_device {
#     device_name = "/dev/xvda"
#     volume_type = "gp2"
#     volume_size = 8
#     delete_on_termination = true
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }


