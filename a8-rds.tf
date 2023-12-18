
resource "aws_db_parameter_group" "custom_default_param_group" {
  family      = "mysql8.0"
  description = "My custom default parameter group"
  name        = "custom-default-mysql-8"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
  parameter {
    name  = "collation_server"
    value = "utf8mb4_general_ci"
  }
}

resource "aws_db_instance" "proje2_rds" {
  allocated_storage           = 20
  auto_minor_version_upgrade  = true
  backup_retention_period     = 7
  backup_window               = "01:00-02:00"
  db_subnet_group_name        = aws_db_subnet_group.proje2_RDS_Subnet_Group.name
  engine                      = "mysql"
  engine_version              = "8.0.33"
  identifier                  = "proje2-rds"
  instance_class              = "db.t2.micro"
  max_allocated_storage       = 40
  db_name                     = "database1"
  parameter_group_name        = aws_db_parameter_group.custom_default_param_group.name
  password                    = "admin123"
  skip_final_snapshot         = true
  storage_type                = "gp2"
  username                    = "admin"
  vpc_security_group_ids      = [aws_security_group.proje2_RDS_Sec_Group.id]
  
  publicly_accessible         = false
  maintenance_window          = "wed:03:00-wed:04:00"
}






# resource "aws_db_instance" "proje2_rds" {
#   allocated_storage           = 20
#   auto_minor_version_upgrade  = true
#   backup_retention_period     = 7
#   backup_window               = "01:00-02:00"
#   db_subnet_group_name        = aws_db_subnet_group.proje2_RDS_Subnet_Group.name
#   engine                      = "mysql"
#   engine_version              = "8.0.33"
#   identifier                  = "proje2-rds"
#   instance_class              = "db.t2.micro"
#   max_allocated_storage       = 40
#   db_name                     = "database1"
#   parameter_group_name        = aws_db_parameter_group.custom_default_param_group.name  # Burada özel parametre grubuna referans veriliyor
#   password                    = "admin123"
#   skip_final_snapshot         = true
#   storage_type                = "gp2"
#   username                    = "admin"
#   vpc_security_group_ids      = [aws_security_group.proje2_RDS_Sec_Group.id]
  
#   publicly_accessible         = false
#   maintenance_window          = "wed:03:00-wed:04:00"
# }

# resource "aws_db_parameter_group" "custom_default_param_group" {
#   family        = "mysql8.0"
#   description   = "My custom default parameter group"
#   name          = "custom-default-mysql-8" # Ad kurallara uygun olarak değiştirildi

#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "collation_server"
#     value = "utf8mb4_general_ci"
#   }
# }





# resource "aws_db_instance" "proje2_rds" {
#   allocated_storage    = 20
#   auto_minor_version_upgrade = true
#   backup_retention_period = 7
#   backup_window         = "01:00-02:00"
#   db_subnet_group_name  = aws_db_subnet_group.proje2_RDS_Subnet_Group.name
#   engine                = "mysql"
#   engine_version        = "8.0.33"
#   identifier            = "proje2-rds"
#   instance_class        = "db.t2.micro"
#   max_allocated_storage = 40
#   db_name               = "database1"
#   parameter_group_name  = "default.mysql8.0"
#   password              = "admin123"
#   skip_final_snapshot   = true
#   storage_type          = "gp2"
#   username              = "admin"
#   vpc_security_group_ids = [aws_security_group.proje2_RDS_Sec_Group.id]
  
  
#   publicly_accessible = false

#   maintenance_window = "wed:03:00-wed:04:00"
# }


# resource "aws_db_parameter_group" "custom_default_param_group" {
#   family      = "mysql8.0"
#   description = "My custom default parameter group"
#   name        = "custom-default-mysql-8" # Ad kurallara uygun olarak değiştirildi

#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "collation_server"
#     value = "utf8mb4_general_ci"
#   }
# }



# resource "aws_db_parameter_group" "default" {       #parametre grubu oluşturmak içindir. AWS RDS parametre grupları, veritabanı 
#   family      = "mysql8.0"                          #sunucusunun veya motorunun davranışını, yapılandırmasını ve özelliklerini yönetmek için kullanılır.
#   description = "My parameter group"
#   name        = "default.mysql8.0"
#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
#   parameter {
#     name  = "collation_server"
#     value = "utf8mb4_general_ci"
#   }
# }




