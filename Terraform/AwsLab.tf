provider "aws" {
  access_key = "YOURAWSACCESSKEY"
  secret_key = "YOURSECRETAWSACCESSKEY"
  region     = "us-east-1"
}

resource "aws_vpc" "myVPC" {
  cidr_block = "10.1.1.0/24"
}

resource "aws_subnet" "VPCSubnetOne" {
  vpc_id     = "${aws_vpc.myVPC.id}"
  cidr_block = "10.1.1.0/25"
}
resource "aws_subnet" "VPCSubnetTwo" {
  vpc_id     = "${aws_vpc.myVPC.id}"
  cidr_block = "10.1.1.128/25"
}

data "aws_ami" "ubuntuAMI" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntuAMI.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.VPCSubnetOne.id}"
}
