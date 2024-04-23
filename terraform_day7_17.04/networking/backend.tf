terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "aidana-tf-day6"
    key    = "day7cswork/netwroking/terraform.tfstate"
  }
}
