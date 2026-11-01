# DB Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "app-db-subnet-group"
  subnet_ids = aws_subnet.database[*].id
}

# RDS Instance
resource "aws_db_instance" "app_db" {
  identifier        = "app-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = var.db_instance_class
  allocated_storage = 20

  db_name  = var.db_name
  username = var.username

  
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  multi_az            = true
  publicly_accessible = false
  skip_final_snapshot = true
}
