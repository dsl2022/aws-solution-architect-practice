output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "private_subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "public_subnet1_id" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet2_id" {
  value = aws_subnet.public_subnet2.id
}

output "primary_instance_id" {
  value = aws_instance.primary_instance.id
}

output "standby_instance_id" {
  value = aws_instance.standby_instance.id
}

output "test_instance_id" {
  value = aws_instance.test_instance.id
}


output "eni_id" {
  value = aws_network_interface.eni.id
}
