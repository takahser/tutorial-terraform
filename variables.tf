variable "access_key" {}

variable "secret_key" {}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-b374d5a5"
    "us-west-2" = "ami-4b32be2b"
  }
}

variable "region" {
  default = "us-east-1"
}