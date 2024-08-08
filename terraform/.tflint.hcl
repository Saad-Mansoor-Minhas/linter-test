plugin "aws" {
  source  = "https://github.com/terraform-linters/tflint-ruleset-aws"
  enabled = true
  version = "0.27.0"
}

rule "terraform_required_version" {
  enabled = false
}

rule "terraform_required_providers" {
  enabled = false
}
