output "vpc_id" {
  description = "vpc id"
  value = aws_vpc.my-vpc.id
}

output "public_subnet_id" {
  description = "public_subnet_id"
  value = aws_subnet.public_subnet_1.id
}

output "private_subnet_id" {
  description = "private_subnet_id"
  value = aws_subnet.private_subnet_1.id
}

output "public_subnet_id_2" {
  description = "public_subnet_id"
  value = aws_subnet.public_subnet_2.id
}

output "private_subnet_id_2" {
  description = "private_subnet_id"
  value = aws_subnet.private_subnet_2.id
}