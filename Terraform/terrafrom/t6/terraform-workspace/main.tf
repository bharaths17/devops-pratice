provider "aws" {
    region = "us-east-1"
    access_key = "AKIASYEAWNEUIHN6VE7P"
    secret_key = "HoTDubSfoitiEtW1piK2quCcCWmuR+apjaCk"
}
variable "ami" {
    description = "create ec2"
  
}
variable "instance_type" {
    description = "select configure"
    type = map(string)

    default = {
      "dev" = "t2.micro"
      "stage" = "t2.medium"
      "prod" = "t2.xlarge"
    }
  
}
module "ec2_instance" {
    source = "../modules/ec2_instance"
    ami = var.ami
    instance_type = lookup(var.instance_type,terraform.workspace, "t2.micro")

  
}
