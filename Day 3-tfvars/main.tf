resource "aws_instance" "dev" {
  ami = var.ami
  instance_type = "t2.micro"
}

# resource "aws_s3_bucket" "name" {
#   bucket = "var.bucket"
# }




# tf destroy -target=aws_s3_bucket.name if we want controlparticular resource used target