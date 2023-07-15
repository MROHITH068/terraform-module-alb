resource "aws_security_group" "main" {
  name        = "${var.component}-${var.env}-sg"
  description = "${var.component}-${var.env}-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = var.sg_subnet_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.component}-${var.env}-sg"
  }, var.tags)
}

resource "aws_lb" "main" {
  name               =  "${var.name}-${var.env}-lb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets

  tags = merge({Name = "${var.component}-${var.env}"}, var.tags)
}
