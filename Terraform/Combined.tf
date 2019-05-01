provider "aws" {
  access_key = "YOURAWSACCESSKEY"
  secret_key = "YOURAWSSECRETKEY"
  region     = "us-east-1"
}
resource "aws_vpc" "main2" {
  cidr_block = "10.9.0.0/16"
}
