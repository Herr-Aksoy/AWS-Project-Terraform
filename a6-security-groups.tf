


resource "aws_security_group" "proje2_ALB_Sec_Group" {
  vpc_id      = aws_vpc.proje2_vpc.id
  name        = "proje2_ALB_Sec_Group"
  description = "HTTP and HTTPS ports from anywhere"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # Çıkış kuralları (egress rules)
  egress {
    description = "All traffic" # Tüm trafiği izin ver
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Tüm protokolleri izin vermek için -1 kullanılabilir
    cidr_blocks = ["0.0.0.0/0"] # Dikkatli olun, tüm bağlantıları izin vermek güvenlik riski oluşturabilir
  }
}

resource "aws_security_group" "proje2_EC2_Sec_Group" {
  vpc_id      = aws_vpc.proje2_vpc.id
  name        = "proje2_EC2_Sec_Group"
  description = "Allows traffic coming from proje2_ALB_Sec_Group Security"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.proje2_ALB_Sec_Group.id]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.proje2_ALB_Sec_Group.id]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # Çıkış kuralları (egress rules)
  egress {
    description = "All traffic" # Tüm trafiği izin ver
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Tüm protokolleri izin vermek için -1 kullanılabilir
    cidr_blocks = ["0.0.0.0/0"] # Dikkatli olun, tüm bağlantıları izin vermek güvenlik riski oluşturabilir
  }
}

resource "aws_security_group" "proje2_RDS_Sec_Group" {
  vpc_id      = aws_vpc.proje2_vpc.id
  name        = "proje2_RDS_Sec_Group"
  description = "MYSQL/Aurora port"

  ingress {
    description = "MYSQL/Aurora"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.proje2_EC2_Sec_Group.id]
  }

    # Çıkış kuralları (egress rules)
  egress {
    description = "All traffic" # Tüm trafiği izin ver
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Tüm protokolleri izin vermek için -1 kullanılabilir
    cidr_blocks = ["0.0.0.0/0"] # Dikkatli olun, tüm bağlantıları izin vermek güvenlik riski oluşturabilir
  }
}

resource "aws_security_group" "proje2_NAT_Sec_Group" {
  vpc_id      = aws_vpc.proje2_vpc.id
  name        = "proje2_NAT_Sec_Group"
  description = "Allows traffic HTTP, HTTPS, and SSH"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # Çıkış kuralları (egress rules)
  egress {
    description = "All traffic" # Tüm trafiği izin ver
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Tüm protokolleri izin vermek için -1 kullanılabilir
    cidr_blocks = ["0.0.0.0/0"] # Dikkatli olun, tüm bağlantıları izin vermek güvenlik riski oluşturabilir
  }
}







