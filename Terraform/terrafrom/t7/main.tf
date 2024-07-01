provider "aws" {
  region = "us-east-1"
    access_key = "AKIASYEAWNEHN6VE7P"
    secret_key = "HoTDubSfoVJK2quCcCWmuR+apjaCk"
}

provider "vault" {
  address = "http://3.80.195.161:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "302d81d6-dddb-af77-7f8f-093d9a8f820f"
      secret_id = "adcd9bac-7307-2565-5c10-484ec0e53f97"
    }
  }
}
data "vault_kv_secret_v2" "example" {
  mount = "kv" // change it according to your mount
  name  = "test-secret" // change it according to your secret
}

resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  subnet_id = "subnet-0ca408fa7f141c374"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["username"]
  }
}
resource "aws_s3_bucket" "example" {
  bucket = data.vault_kv_secret_v2.example.data["username"]
  
}