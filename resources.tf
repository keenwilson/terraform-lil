resource "aws_vpc" "environment-example-two" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags {
      Name = "terraform-aws-vpc-example-two"
  }
}

resource "aws_instance" "example" {
  ami           = "ami-a0cfeed8"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}"
}

resource "aws_subnet" "subnet1" {
    cidr_block = "${cidrsubnet(aws_vpc.environment-example-two.cidr_block, 3, 1)}"
    vpc_id = "${aws_vpc.environment-example-two.id}"
    availability_zone = "us-west-2a"
}

resource "aws_subnet" "subnet2" {
    cidr_block = "${cidrsubnet(aws_vpc.environment-example-two.cidr_block, 2, 2)}"
    vpc_id = "${aws_vpc.environment-example-two.id}"
    availability_zone = "us-west-2b"
}

