output "alb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.app_alb.dns_name
}

output "db_secret_arn" {
  description = "ARN of the secret containing DB credentials"
  value       = aws_db_instance.app_db.master_user_secret[0].secret_arn
}
