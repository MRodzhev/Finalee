output "bucket_arn" {
  value = aws_s3_bucket.s3-bucket.arn
}

output "bucket_name" {
  value = aws_s3_bucket.s3-bucket.bucket_domain_name
}
output "s3_bucket" {
    value = aws_s3_bucket.s3-bucket.id
  
}
