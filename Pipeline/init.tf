/*Instantiate variables, and sometimes provide default values*/
provider "aws" {
  region     = "eu-west-1"
  profile    = "personal" # personal profile created with his personal keys for personal account.
  #version = "~> 1.54.0"
  version = "~> 2.22.0"

}

terraform {
  backend "s3" {
    bucket = "dt-terraform-states"
    key    = "terraform.tfstate"
    region = "eu-west-1"
    profile    = "personal" #dtonge has a personal profile created with his personal keys for personal account.

  }
}

