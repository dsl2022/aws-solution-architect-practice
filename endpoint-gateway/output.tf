output "vpc_id" {
  value = aws_vpc.main.id
}

output "instance_ids" {
  value = aws_instance.primary_instance.id
}

output "dynamodb_endpoint_id" {
  value = aws_vpc_endpoint.dynamodb_endpoint.id
}