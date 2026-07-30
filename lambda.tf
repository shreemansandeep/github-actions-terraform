# ==============================================================================
# AWS Lambda Configuration (Commented out for reference)
# ==============================================================================

# # 1. Package the Python source code into a ZIP file for Lambda deployment
# data "archive_file" "lambda_zip" {
#   type        = "zip"
#   source_dir  = "${path.module}/python"
#   output_path = "${path.module}/lambda_function.zip"
# }

# # 2. Create IAM Execution Role for AWS Lambda
# # This role gives AWS Lambda permission to assume the role and execute.
# resource "aws_iam_role" "lambda_exec_role" {
#   name = "${var.environment}-lambda-exec-role"
# 
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# # 3. Attach AWS Managed Policy for CloudWatch Logs
# # Allows Lambda to write execution logs to CloudWatch
# resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
#   role       = aws_iam_role.lambda_exec_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# # 4. AWS Lambda Function Resource
# resource "aws_lambda_function" "hello_lambda" {
#   filename         = data.archive_file.lambda_zip.output_path
#   source_code_hash = data.archive_file.lambda_zip.output_base64sha256
#   function_name    = "${var.environment}-hello-lambda"
#   role             = aws_iam_role.lambda_exec_role.arn
# 
#   # Specifies the handler entry point: <file_name_without_extension>.<function_name>
#   handler = "lambda_function.lambda_handler"
#   runtime = "python3.11"
# 
#   environment {
#     variables = {
#       ENVIRONMENT = var.environment
#     }
#   }
# }
