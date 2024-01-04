
resource "aws_launch_template" "proje2_launch_template" {
  name        = "proje2_launch_template"
  description = "Blog Web Page version 1"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size          = 8
      volume_type          = "gp2"
      delete_on_termination = true
    }
  }

  image_id      = "ami-055744c75048d8296"             ## degistir
  instance_type = "t2.micro"
  key_name      = var.user_name     #"neu"

  iam_instance_profile {
    name = aws_iam_instance_profile.proje2_iam_profile.name
  }

  network_interfaces {
    security_groups = [aws_security_group.proje2_EC2_Sec_Group.id]
  }


  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "proje2_web_server"                # "WebApp${count.index + 1}"
    }
  }

  user_data = filebase64("./s3_Website/userdata.sh")

  # user_data = base64encode(<<EOF
  #             #!/bin/bash
  #             apt-get update -y
  #             apt-get install -y git python3
  #             cd /home/ubuntu/
  #             git clone https://@github.com/Herr-Aksoy/Proje2-Team.git
  #             cd /home/ubuntu/Proje2-Team
  #             apt-get install -y python3-pip python3.7-dev libmysqlclient-dev
  #             pip3 install -r requirements.txt
  #             cd /home/ubuntu/Proje2-Team/src
  #             python3 manage.py collectstatic --noinput
  #             python3 manage.py makemigrations
  #             python3 manage.py migrate
  #             python3 manage.py runserver 0.0.0.0:80
  #             EOF
  # )
}





# # Launch Template oluşturma
# resource "aws_launch_template" "proje2_launch_template" {
#   name        = "proje2_launch_template"
#   description = "Blog Web Page version 1"

#   block_device_mappings {
#     device_name = "/dev/xvda"
#     ebs {
#       volume_size = 8
#       volume_type = "gp2"
#       delete_on_termination = true
#     }
#   }

#   image_id          = "ami-06aa3f7caf3a30282"
#   instance_type     = "t2.micro"
#   key_name          = "neu"
#   iam_instance_profile {
#     name = aws_iam_role.proje2_EC2_S3_Full_Access.name
#   }

#   network_interfaces {
#     security_groups = [aws_security_group.proje2_EC2_Sec_Group.id]
#   }

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "proje2_web_server"
#     }
#   }

#   user_data = <<-EOF
#               #!/bin/bash
#               apt-get update -y
#               apt-get install git -y
#               apt-get install python3 -y
#               cd /home/ubuntu/
#               TOKEN=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
#               git clone https://$TOKEN@github.com/Herr-Aksoy/Proje2-Team.git
#               cd /home/ubuntu/Proje2-Team
#               apt install python3-pip -y
#               apt-get install python3.7-dev libmysqlclient-dev -y
#               pip3 install -r requirements.txt
#               cd /home/ubuntu/Proje2-Team/src
#               python3 manage.py collectstatic --noinput
#               python3 manage.py makemigrations
#               python3 manage.py migrate
#               python3 manage.py runserver 0.0.0.0:80
#               EOF
# }






