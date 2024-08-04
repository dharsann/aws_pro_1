resource "aws_vpc" "prod-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    instance_tenancy = "default"

    tags = {
      Name = "prod-vpc"
    }
}

resource "aws_subnet" "prod-subnet-public-1" {
    vpc_id =  "${aws_vpc.prod-vpc.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "prod-subnet-public-1"
    }
}

resource "aws_instance" "web1" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.prod-subnet-public-1.id}"
    vpc_security_group_ids = ["${aws_security_group.ssh_allowed.id}"]
    key_name = "${aws_key_pair.mumbai-region-key-pair.id}"
}

resource "aws_key_pair" "mumbai-region-key-pair" {
    key_name = "mumbai-region-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}