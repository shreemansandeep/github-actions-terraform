# output "db_endpoint" {
#   description = "The connection endpoint for the RDS instance"
#   value       = aws_db_instance.mysql.endpoint
# }

# output "db_username" {
#   description = "The master username for the database"
#   value       = aws_db_instance.mysql.username
# }

# output "db_password" {
#   description = "The master password for the database"
#   value       = aws_db_instance.mysql.password
#   sensitive   = true
# }

# output "lambda_function_name" {
#   description = "Name of the deployed AWS Lambda function"
#   value       = aws_lambda_function.hello_lambda.function_name
# }

# output "lambda_function_arn" {
#   description = "ARN of the deployed AWS Lambda function"
#   value       = aws_lambda_function.hello_lambda.arn
# }

# output "lambda_iam_role_arn" {
#   description = "ARN of the execution IAM Role for AWS Lambda"
#   value       = aws_iam_role.lambda_exec_role.arn
# }

