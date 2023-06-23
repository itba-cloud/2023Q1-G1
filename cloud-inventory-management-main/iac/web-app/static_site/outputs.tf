output "www_bucket_id" {
  value = aws_s3_bucket.www.id
  description = "id of www_bucket_id"
}

output "root_bucket_id" {
  value = aws_s3_bucket.root.id
  description = "id of root_bucket_id"
}

output "logs_bucket_id" {
  value = aws_s3_bucket.logs.id
  description = "id of logs_bucket_id"
}

output "domain_name" {
  description = "Root Domain Name"
  value       = aws_s3_bucket.root.bucket_domain_name
}

output "logs_bucket_domain_name" {
  value = aws_s3_bucket.logs.bucket_domain_name
  description = "id of logs_bucket_domain_name"
}
  