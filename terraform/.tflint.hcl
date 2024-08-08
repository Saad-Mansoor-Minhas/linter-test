plugin "aws" {
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
  enabled = true
  version = "0.32.0"
}

plugin "terraform" {
  enabled = true
  version = "0.9.1"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}

rule "terraform_required_version" {
  enabled = false
}

rule "terraform_required_providers" {
  enabled = false
}
