# # Network resources for secure database deployment

# data "aws_availability_zones" "available" {
#   state = "available"
# }

# resource "aws_vpc" "main" {
#   cidr_block           = "10.0.0.0/16"
#   enable_dns_hostnames = true
#   enable_dns_support   = true

#   tags = {
#     Name = "${var.environment}-vpc"
#   }
# }

# resource "aws_subnet" "private_1" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = data.aws_availability_zones.available.names[0]

#   tags = {
#     Name = "${var.environment}-private-subnet-1"
#   }
# }

# resource "aws_subnet" "private_2" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = data.aws_availability_zones.available.names[1]

#   tags = {
#     Name = "${var.environment}-private-subnet-2"
#   }
# }

# resource "aws_db_subnet_group" "rds" {
#   name       = "${var.environment}-rds-subnet-group"
#   subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

#   tags = {
#     Name = "${var.environment}-rds-subnet-group"
#   }
# }
