terraform {
  backend "gcs" {
    bucket = "terraform-cvortex-challenge"
    prefix = "terraform/tfstate"
  }
}