terraform {
  backend "s3" {
    bucket = "backendforstate"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
