variable "bastion_host-sg-tag" {
  type = string
  default = "bastion-host-server-sg"
}
variable "alb-frontend-sg-tag" {
  type = string
  default = "alb-frontend-sg"
}
variable "frontend-server-sg-tag" {
  type = string
default = "frontend-server-sg"
}

variable "alb-backend-sg-tag" {
  type = string
  default = "alb-backend-sg"
}

variable "backend-server-sg-tag" {
    type = string
    default = "backend-server-sg"
}

variable "book-rds-sg-tag" {
  type = string
  default = "book-rds-sg"
}

variable "vpc_id" {}

variable "vpcname" {}