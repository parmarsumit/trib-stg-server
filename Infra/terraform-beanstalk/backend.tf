terraform {
  backend "s3" {
    bucket  = "tribute-infra"
    key     = "env/stg/beanstalk/staging.tfstate"
    region  = "eu-west-1"
    profile = "trib-stg"
    encrypt = true
  }
}
