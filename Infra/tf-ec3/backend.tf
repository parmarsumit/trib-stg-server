terraform {
  backend "s3" {
    bucket  = "tribute-infra"
    key     = "env/stg/ec2/server.tfstate"
    region  = "eu-west-1"
    profile = "trib-stg"
    encrypt = true
  }
}
