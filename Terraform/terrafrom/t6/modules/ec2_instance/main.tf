provider "aws" {
    region = "us-east-1"
    access_key = "AKIASYEAWNEUIHN6VE7P"
    secret_key = "HoTDtVJK2quCcCWmuR+apjaCk"
}

variable "ami" {
description = "this is ami to create ec2"  
}

variable "instance_type" {
    description = "this is to create type of instance"
}

resource "aws_instance" "terrform-workspace" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = "subnet-0ca408fa7f141c374"
    tags = {
      "name" = "terraform-workspace"
    }
  
}
