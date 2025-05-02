resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_typetype
    availability_zone = "ap-sout-1"

    tags = {
      name ="dev"
    }
}