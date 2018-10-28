# RDS Module  - This module is meant for Enterprise ESPOC AWS account
Please update the data_env.tf file for other AWS environments 
```
###
This Terraform will create
Resources Created :
-- RDS Mysql Instance
-- RDS Subnet Group


output
In order to lookup the existing username and password you need to install terraform and have administrator privilege to read the states.

git clone ...this-repo...
cd ..this-repo..
terraform init
terraform output

```
Sample example :

terraform {
  backend "s3" {
    bucket  = "tf-cs-prod-st-dnb"
    key     = "env/EsStg/ems-pcmxform/rds.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}
provider "aws" {
  region = "eu-west-1"
}

module "pcmxform_rds" {
  source = "git::ssh://git@stash.aws.dnb.com:7999/strf/tf-module-rds.git"

  db_username = "root" 
  db_name     = "pcmxform" /* Database Name  : you will get a name attached with Environment name mentioned in tags , e.g pcmxformstg */
  account     = "EsStg"  /*  Supported values :  EsPoc | EsStg | EsDevQA | EsProd | DAAS */
  multi_az ="true"



  instance_tags = "${map(
                    "Name"  ,             "pcmxform",
                    "ApplicationName",    "pcmxform",
                    "Environment",        "stg",
                    "Jira",               "ESD-505"
                    "Owner",              "allenv@dnb.com",
                    "CreatedBy",          "parmars@DNB.com",
                    "Team",               "DevInTest",
                    "CostCenter" ,        "1265",
                    "DataClassification", "Commercial In Confidence")}"

  allocated_storage = "5"
}