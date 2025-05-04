resource "aws_instance" "dev" {
    ami = "ami-062f0cc54dbfd8ef1"
    instance_type = "t2.micro"
  
}
resource "aws_vpc" "name" {
    cidr_block="10.0.0.0/16"
    depends_on = [ aws_instance.dev ]
  
}