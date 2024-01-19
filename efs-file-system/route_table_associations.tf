# Associate Public Route Table with Public Subnets
resource "aws_route_table_association" "public_subnet1_association_1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet1_association_2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_subnet1_association_3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.public.id
}

