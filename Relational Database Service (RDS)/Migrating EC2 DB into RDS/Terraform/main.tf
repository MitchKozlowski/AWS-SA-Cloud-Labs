provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {}


resource "aws_vpc" "a4l" {
  cidr_block           = "10.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "a4l-vpc1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.a4l.id

  tags = {
    Name = "A4L-vpc1-igw"
  }
}


resource "aws_subnet" "web_a" {
  vpc_id                  = aws_vpc.a4l.id
  cidr_block              = "10.16.48.0/20"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "sn-web-A"
  }
}

resource "aws_subnet" "web_b" {
  vpc_id            = aws_vpc.a4l.id
  cidr_block        = "10.16.112.0/20"
  availability_zone = data.aws_availability_zones.available.names[1]

  map_public_ip_on_launch = true

  tags = {
    Name = "sn-web-B"
  }
}


resource "aws_route_table" "web" {
  vpc_id = aws_vpc.a4l.id

  tags = {
    Name = "A4L-vpc1-rt-web"
  }
}

resource "aws_route" "default_ipv4" {
  route_table_id         = aws_route_table.web.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "web_a" {
  subnet_id      = aws_subnet.web_a.id
  route_table_id = aws_route_table.web.id
}


resource "aws_security_group" "instance_sg" {
  name   = "a4l-instance-sg"
  vpc_id = aws_vpc.a4l.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Self reference
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_iam_role" "ec2_role" {
  name = "a4l-wordpress-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cw" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "profile" {
  name = "a4l-profile"
  role = aws_iam_role.ec2_role.name
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"]
  }
}

resource "aws_instance" "wordpress" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.web_a.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.profile.name

  user_data = templatefile("${path.module}/userdata/wordpress.sh", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
    db_host     = aws_instance.mariadb.private_dns
  })

  tags = {
    Name = "A4L-Wordpress"
  }
}


resource "aws_instance" "mariadb" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.web_a.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.profile.name

  user_data = templatefile("${path.module}/userdata/mariadb.sh", {
    db_name          = var.db_name
    db_user          = var.db_user
    db_password      = var.db_password
    db_root_password = var.db_root_password
  })

  tags = {
    Name = "A4L-DB-Wordpress"
  }
}