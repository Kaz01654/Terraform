terraform {
  required_version = "~> 1.9.8"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}