terraform {
  backend "s3" {
    bucket  = "tribute-infra"
    key     = "env/stg/efs/efs.tfstate"
    region  = "eu-west-1"
    profile = "trib-stg"
    encrypt = true
  }
}
