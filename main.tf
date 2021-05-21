#This Terraform Code Deploys Basic VPC Infra.
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_name}"
	Owner = "Raju Bothra"
	
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags = {
        Name = "${var.IGW_name}"
    }
}

resource "aws_subnet" "subnet1-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet1_cidr}"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "${var.public_subnet1_name}"
    }
}





resource "aws_route_table" "terraform-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags = {
        Name = "${var.Main_Routing_Table}"
    }
}

resource "aws_route_table_association" "terraform-public" {
    subnet_id = "${aws_subnet.subnet1-public.id}"
    route_table_id = "${aws_route_table.terraform-public.id}"
}

resource "aws_security_group" "SecurityGroup" {
  name        = "MySecurityGroup"
  description = "Allow for RDP"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    }


  tags = {
    Name = "MySecurityGroup"
  }
  
}

resource "aws_eip" "ip" {
  vpc      = true
  tags = {
    Name = "MyElasticip"
  }
}



 #resource "aws_instance" "web-1" {
 #  ami = var.ami_id
 #   availability_zone = "ap-south-1a"
 #   instance_type = "t2.micro"
 #   key_name = "laptop"
 #   subnet_id = "${aws_subnet.subnet1-public.id}"
 #   vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
 #   associate_public_ip_address = true	
 #   tags = {
 #       Name = "Server-1"
 #
 #	
 #   }
 #

