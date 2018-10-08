// A provider is responsible for creating and managing resources
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

// The resource block defines a resource that exists within the infrastructure.
// It can be either physical (e.g. ec2 instance) or logical (e.g. heroku app)
resource "aws_instance" "example" {
  ami           = "${lookup(var.amis, var.region)}"

  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

// "aws_eip" resource type => allocates and associates an elastic IP to an EC2 instance
// dependencies: aws_instance
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}" // EC2 instance 'aws_instance' to assign the IP to
}

// dependencies: none => will be created parallel to the others
resource "aws_instance" "another" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}
