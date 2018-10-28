data "terraform_remote_state" "env" {
  backend = "s3"
  config {
    bucket = "tf-cs-prod-st-dnb"
    key = "env/EsPoC/vpc.tfstate"
    region = "eu-west-1"
  }
}