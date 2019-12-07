resource "aws_security_group" "score_hub_alb_sg" {
    name = "score-hub-alb"
    description = "security group for scoreHub alb"
    vpc_id = aws_vpc.vpc_main.id
}

resource "aws_security_group_rule" "inbound_consul" {
    type = "ingress"
    from_port = 8500
    to_port = 8500
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]

    security_group_id = aws_security_group.score_hub_alb_sg.id
}

resource "aws_security_group_rule" "inbound_nomad" {
    type = "ingress"
    from_port = 4646
    to_port = 4646
    protocol = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]

    security_group_id = aws_security_group.score_hub_alb_sg.id
}

resource "aws_lb" "main" {
  load_balancer_type = "application"
  name               = "scorehub-alb"

  security_groups = ["${aws_security_group.score_hub_alb_sg.id}"]
  subnets         = ["${aws_subnet.vpc_main-public1-subnet.id}", "${aws_subnet.vpc_main-public2-subnet.id}"]
}
