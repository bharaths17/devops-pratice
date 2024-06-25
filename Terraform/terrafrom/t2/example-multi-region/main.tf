provider "aws" {
  alias = "A"
  region     = "us-east-1"
  access_key = "AKIASYEAWNEUIHN6VE7P"
  secret_key = "HoTDubSfoitiEt"
}
provider "aws" {
  alias = "B"
  region     = "us-west-2"
  access_key = "AKIASYEAWNEUIHN6VE7P"
  secret_key = "HoTDubSfoitiEtW1pik"
}



resource "aws_instance" "terrafrom-ec2" {
    ami           = "ami-08a0d1e16fc3f61ea"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    subnet_id = "subnet-0ca408fa7f141c374"
    provider = "aws.A"
}


resource "aws_instance" "terrafrom-ec21" {
  ami = "ami-0ca1f30768d0cf0e1"
  instance_type = "t2.micro"
  subnet_id = "subnet-6dc1090b"
  provider = "aws.B"
}
