terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "aidana-tf-day6"
    key    = "day7cswork/s3/terraform.tfstate"
    # workspace_key_prefix = "env"
  }
}

locals {
  #   bucket_name = toset(["First", "Second", "Third"])
  bucket_versioning = {

    bucket-aidana-1 = {}
    bucket-aidana-2 = {}
    bucket-aidana-3 = {}

  }
}

resource "aws_s3_bucket" "buckets" {
  for_each = local.bucket_versioning
  bucket   = each.key
  tags = {
    Name        = each.key
    Environment = "Dev"
  }

}


resource "aws_s3_bucket_versioning" "bucket_vr" {
  for_each = local.bucket_versioning
  bucket   = aws_s3_bucket.buckets[each.key].id

  versioning_configuration {
    status = lookup(each.value, "versioning", "Enabled")
  }
}
