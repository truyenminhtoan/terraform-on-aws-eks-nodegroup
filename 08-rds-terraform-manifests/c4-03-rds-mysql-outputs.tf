# RDS DB Outputs
output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.rds_mysql_instance.db_name
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.rds_mysql_instance.endpoint
}