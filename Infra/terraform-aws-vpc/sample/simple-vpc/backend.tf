terraform {
  backend "s3" {
    bucket  = "tribute-infra"
    key     = "env/stg/vpc/vpc.tfstate"
    region  = "eu-west-1"
    profile = "trib-stg"
    encrypt = true
  }
}
