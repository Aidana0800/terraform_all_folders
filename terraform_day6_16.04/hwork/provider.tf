provider "aws" {
  region = terraform.workspace == "dev" ? "us-east-1" : terraform.workspace == "prod" ? "us-west-1" : "us-east-2"
}
