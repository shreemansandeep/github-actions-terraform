# resource "random_password" "db_password" {
#   length  = 20
#   special = true
# }

# resource "aws_secretsmanager_secret" "mysql" {
#   name = "prod/mysql"
# }

# resource "aws_secretsmanager_secret_version" "mysql" {

#   secret_id = aws_secretsmanager_secret.mysql.id

#   secret_string = jsonencode({

#     username = "admin"

#     password = random_password.db_password.result
#   })
# }
