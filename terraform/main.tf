data "http" "myip" {
    url = "http://ipv4.icanhazip.com"
}

variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "ap-northeast-1"
}

variable "images" {
    default = {
        redhat8 = "ami-09f31cc5d5eecca1a"
        amazon_linux1 = "ami-0ab3e16f9c414dee7"
        amazon_linux2 = "ami-068a6cefc24c301d2"
    }
}

variable "server_count" {
    default = {
        manager_server = 3
        application_server = 2
    }
}

variable "key_name" {
    default = "sshkey_for_ansible"
}

variable "public_key_path" {
    default = "~/.ssh/id_rsa.pub"
}

provider "aws" {
    access_key = var.access_key
    secret_key = var.secret_key
    region = var.region
}

resource "aws_security_group" "score_hub_sg" {
    name = "score_hub"
    description = "security group for scoreHub platform"
}

resource "aws_key_pair" "auth" {
    key_name = var.key_name
    public_key = file(var.public_key_path)
}

resource "aws_security_group_rule" "inbound_consul" {
    type = "ingress"
    from_port = 8500
    to_port = 8500
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_security_group_rule" "inbound_nomad" {
    type = "ingress"
    from_port = 4646
    to_port = 4646
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_security_group_rule" "inbound_ssh" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_security_group_rule" "inbound_http" {
    type = "ingress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_security_group_rule" "inbound_any_from_self" {
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = -1
    self = true

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_security_group_rule" "outbound_http" {
    type = "egress"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_security_group_rule" "outbound_https" {
    type = "egress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_security_group_rule" "outbound_any_to_self" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = -1
    self = true

    security_group_id = aws_security_group.score_hub_sg.id
}

resource "aws_instance" "manager_server" {
    count = var.server_count.manager_server
    ami   = var.images.amazon_linux2
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.auth.id}"
    vpc_security_group_ids = ["${aws_security_group.score_hub_sg.id}"]
    associate_public_ip_address = "true"

    tags = {
        Name = "${format("manager_server%02d", count.index + 1)}"
    }
}

resource "aws_instance" "application_server" {
    count = var.server_count.application_server
    ami   = var.images.amazon_linux2
    instance_type = "t2.micro"
    key_name = "${aws_key_pair.auth.id}"
    vpc_security_group_ids = ["${aws_security_group.score_hub_sg.id}"]
    associate_public_ip_address = "true"

    tags = {
        Name = "${format("application_server%02d", count.index + 1)}"
    }
}
