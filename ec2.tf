# resource "aws_instance" "web" {
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   subnet_id              = aws_subnet.public[0].id
#   vpc_security_group_ids = [aws_security_group.web_sg.id]
# 
#   tags = {
#     Name = "${var.environment}-web-instance"
#   }
# }
# 
# output "instance_id" {
#   description = "The ID of the EC2 instance"
#   value       = aws_instance.web.id
# }
# 
# output "instance_public_ip" {
#   description = "The public IP address of the EC2 instance"
#   value       = aws_instance.web.public_ip
# }

