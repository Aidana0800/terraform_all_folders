output "s3_bucket_names" {
  value = { for i, v in aws_s3_bucket.buckets : i => v.id }
}
