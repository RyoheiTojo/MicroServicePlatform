variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "ap-northeast-1"
}

provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region
}

resource "aws_instance" "scorehub" {
    count = 2
    ami   = "ami-785c491f"  #Ubuntu 16.04
    instance_type = "t2.micro"

    tags = {
        Name = "${format("app-%02d", count.index + 1)}"
    }
}
