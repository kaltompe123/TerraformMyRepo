output "frontendsg_id" {
  value = aws_security_group.frontend-server-sg.id
}

output "backendsg_id" {
  value = aws_security_group.backend-server-sg.id
}

output "book-rds-sgid" {
value = aws_security_group.book-rds-sg.id
}

output "bastion_hostsg_id" {
  value = aws_security_group.bastion-host.id 
  
}

output "alb-backend-sg" {
  value = aws_security_group.alb-backend-sg.id
}

output "alb-frontend-sg" {
  value = aws_security_group.alb-frontend-sg.id
}