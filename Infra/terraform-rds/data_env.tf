data "terraform_remote_state" "env" {
  backend = "s3"
  config {
    bucket  = "tribute-infra"
    key     = "env/stg/vpc/vpc.tfstate"
    region  = "eu-west-1"
    profile = "trib-stg"
    encrypt = true
  }
}