output "ip" {
 value = aws_instance.dev.public_ip 
}


output "private_ip" {
 value = aws_instance.dev.subnet_id 
 sensitive = true
}
