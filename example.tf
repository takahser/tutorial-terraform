// A provider is responsible for creating and managing resources
provider "aws" {
  access_key = "AKIAIH6FYVH3BTXP37NQ"
  secret_key = "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"
  region     = "us-east-1"
}

// The resource block defines a resource that exists within the infrastructure.
// It can be either physical (e.g. ec2 instance) or logical (e.g. heroku app)
resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}

// "aws_eip" resource type => allocates and associates an elastic IP to an EC2 instance
resource "aws_eip" "ip" {
  instance = "${aws_instance.example.id}" // EC2 instance 'aws_instance' to assign the IP to
}