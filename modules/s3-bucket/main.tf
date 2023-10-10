resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  tags   = var.tags

  # required for seamless update w/ resources using the bucket
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "s3_versioning" {
  depends_on = [
    aws_s3_bucket.s3_bucket
  ]

  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_ownership_control" {
  depends_on = [
    aws_s3_bucket.s3_bucket
  ]

  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  depends_on = [
    aws_s3_bucket.s3_bucket
  ]

  bucket = aws_s3_bucket.s3_bucket.id

  eventbridge = var.bucket_event_bridge
}
