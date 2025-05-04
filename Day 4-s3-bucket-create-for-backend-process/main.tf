resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet" "test" {
    cidr_block = "10.0.0.0/24"
  vpc_id =aws_vpc.dev.id
}


resource "aws_subnet" "uat" {
    cidr_block = "10.0.3.0/24"
  vpc_id =aws_vpc.dev.id
}


resource "aws_subnet" "prod" {
    cidr_block ="10.0.2.0/24"
    vpc_id = aws_vpc.dev.id

  
}


#creating s3 bucket and dynamo DB for state backend storgae and applying the lock mechanisam for statefile

provider "aws" { 
}

resource "aws_s3_bucket" "example" {
  bucket = "testdevnareshit"
  
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}
