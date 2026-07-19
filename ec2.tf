# ==========================================
# Security Groups for Three-Tier Architecture
# ==========================================

# 1. UI Server Security Group (Public facing)
resource "aws_security_group" "ui_sg" {
  name        = "${var.environment}-ui-sg"
  description = "Allow inbound HTTP and SSH traffic from anywhere"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-ui-sg"
  }
}

# 2. App Server Security Group (Private)
resource "aws_security_group" "app_sg" {
  name        = "${var.environment}-app-sg"
  description = "Allow inbound traffic from UI server and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow all traffic from UI Security Group"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.ui_sg.id]
  }

  ingress {
    description = "Allow SSH traffic for management"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Can be restricted to VPC CIDR in production
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-app-sg"
  }
}

# 3. Database Server Security Group (Isolated Database Subnet)
resource "aws_security_group" "db_sg" {
  name        = "${var.environment}-db-sg"
  description = "Allow database traffic only from App tier"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow PostgreSQL access from App Server"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  ingress {
    description     = "Allow MySQL/Aurora access from App Server"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-db-sg"
  }
}


# ==========================================
# EC2 Instances for Three-Tier Architecture
# ==========================================

# 1. UI Server (Public Subnet)
resource "aws_instance" "ui_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.ui_sg.id]

  tags = {
    Name = "${var.environment}-ui-server"
  }
}

# 2. App Server (Private Subnet)
resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "${var.environment}-app-server"
  }
}

# 3. DB Server (Private Database Subnet)
resource "aws_instance" "db_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.database[0].id
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "${var.environment}-db-server"
  }
}


# ==========================================
# Outputs
# ==========================================

output "ui_server_public_ip" {
  description = "The public IP address of the UI server"
  value       = aws_instance.ui_server.public_ip
}

output "app_server_private_ip" {
  description = "The private IP address of the App server"
  value       = aws_instance.app_server.private_ip
}

output "db_server_private_ip" {
  description = "The private IP address of the DB server"
  value       = aws_instance.db_server.private_ip
}
