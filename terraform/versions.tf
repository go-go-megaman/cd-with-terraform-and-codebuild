terraform {
  required_version = "= 1.2.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.22.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "2.20.2"
    }
  }
}
