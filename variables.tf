variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "amis" {
    description = "AMIs by region"
    default = {
        ap-south-1 = "ami-034a4d85b5ef5e779" # WindowsServer2019
		
    }
}
variable "ami_id" { default="ami-034a4d85b5ef5e779"}
variable "vpc_cidr"{}
variable "vpc_name" {}
variable "IGW_name" {}
variable "key_name" {}
variable "public_subnet1_cidr" {}
variable "public_subnet1_name" {}
variable Main_Routing_Table {}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type = list
  default = ["ap-south-1"]
}
variable "environment" { default = "dev" }
variable "instance_type" {
  type = map
  default = {
    dev = "t2.micro"
    }
}