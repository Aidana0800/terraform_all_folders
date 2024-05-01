terraform {
  backend "s3" {
    region = "us-east-1"
    bucket = "aidana-tf-day6"
    key    = "day8cswork/modules/vpc/terraform.tfstate"
    # workspace_key_prefix = "env"
  }
}
