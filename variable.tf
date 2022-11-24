variable "image" {

  type    = string
  default = "ami-074dc0a6f6c764218"
}

variable "name" {
  type    = string
  default = "one"

}

variable "subnet_id"{
    default = "subnet-03fc813c6be74e950"
}

variable "region" {
  type    = string
  default = "ap-south-1"

}

variable "instance_type" {
  type    = string
  default = "t2.large"
}

variable "certificate_arn" {
  type    = string
  default = "arn:aws:acm:ap-south-1:935139307435:certificate/0347964d-104d-4a61-a0dd-517ab6b3c6f7"
}