resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

}
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT.id

}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT.id

}
resource "aws_security_group" "mysg" {
  name   = "web-sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "web-sg"
  }
}

resource "aws_s3_bucket" "jenkins18181" {
  bucket = "jenkins18181"

}

resource "aws_instance" "web-1" {
  ami                    = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.subnet1.id
  user_data              = base64encode(file("userdata.sh"))
}
resource "aws_instance" "web-2" {
  ami                    = "ami-04b70fa74e45c3917"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.mysg.id]
  subnet_id              = aws_subnet.subnet2.id
  user_data              = base64encode(file("userdata1.sh"))

}

resource "aws_alb" "myalb" {

  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.mysg.id]
  subnets         = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]

}
resource "aws_alb_target_group" "my-tg" {

  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"

  }

}

resource "aws_alb_target_group_attachment" "my-tga-1" {
  target_group_arn = aws_alb_target_group.my-tg.arn
  target_id        = aws_instance.web-1.id
  port             = 80

}

resource "aws_alb_target_group_attachment" "my-tga-2" {
  target_group_arn = aws_alb_target_group.my-tg.arn
  target_id        = aws_instance.web-2.id
  port             = 80

}
resource "aws_alb_listener" "my-listener" {
  load_balancer_arn = aws_alb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.my-tg.arn
    type             = "forward"

  }

}

output "load_balancerdns" {

  value = aws_alb.myalb.dns_name

}