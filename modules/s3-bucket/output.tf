output "bucket_id" {
    value = aws_s3_bucket.s3_bucket.id
    description = "S3 Bucket name"
}

output "bucket_arn" {
    value = aws_s3_bucket.s3_bucket.arn
    description = "S3 Bucket arn"
}

output "bucket_regional_domain_name" { 
    value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}
