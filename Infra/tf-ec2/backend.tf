terraform {
  backend "s3" {
    bucket  = "tf-cs-prod-st-dnb"
    key     = "env/EsPoC/testlab/testlab-check.tfstate"
    region  = "eu-west-1"
    encrypt = true
    acl     = "bucket-owner-full-control"
  }
}
