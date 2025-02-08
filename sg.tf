resource "aws_security_group" "fiapx_rds_sg" {
  name        = "fiapx_rds_sg"
  description = "Security Group for RDS"
  vpc_id      = data.aws_vpc.default.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "rds_ingress_from_ecs" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.fiapx_rds_sg.id
  source_security_group_id = data.aws_security_group.ecs_sg.id  # Permite apenas o ECS acessar o RDS
}