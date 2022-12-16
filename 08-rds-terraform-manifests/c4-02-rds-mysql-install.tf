resource "aws_db_subnet_group" "aws_db_subnet_group" {
  name       = "main"
  subnet_ids = data.terraform_remote_state.eks.outputs.database_subnets

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "rds_mysql_instance" {
  db_name              = var.db_name
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  identifier = var.db_instance_identifier

  storage_encrypted     = false
  allocated_storage    = 10
  max_allocated_storage = 20

  multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.aws_db_subnet_group.name
  vpc_security_group_ids = [module.rdsdb_sg.security_group_id]

  enabled_cloudwatch_logs_exports = ["general", "slowquery"]
  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"

#   performance_insights_enabled = true
#   performance_insights_retention_period = 7
}


### Test
# kubectl run -it --rm --image=mysql:5.7.22 --restart=Never mysql-client -- mysql -h webappdb.cwzcu1fp6eui.ap-northeast-1.rds.amazonaws.com -u dbadmin -pdbpassword11
