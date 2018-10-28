module "vpc" {
  source = "../../"

  name = "tribute-staging"

  cidr = "10.10.0.0/16"

  azs                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets      = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
  #  database_subnets    = ["10.10.21.0/24", "10.10.22.0/24", "10.10.23.0/24"]
  # elasticache_subnets = ["10.10.31.0/24", "10.10.32.0/24", "10.10.33.0/24"]

  create_database_subnet_group = false

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_s3_endpoint       = false
  enable_dynamodb_endpoint = false

  tags = {
    Owner       = "Sumit"
    Project = "Tribute"
    Environment = "staging"
  }
}
