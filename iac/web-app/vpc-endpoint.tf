
resource "aws_vpc_endpoint" "default" {

  vpc_id            = module.vpc.default_vpc_id
  service_name      = "dynamodb"
  vpc_endpoint_type =  "Interface"
  auto_accept       = true

  security_group_ids  = [aws_security_group.lambda_sg.id]
  subnet_ids          = module.vpc.private_subnets

}
# resource "aws_vpc_endpoint_route_table_association" "private-dynamodb" {
#     vpc_endpoint_id = "${aws_vpc.default.id}"
#     route_table_id  = "${aws_vpc.default.main_route_table_id}"
#   }