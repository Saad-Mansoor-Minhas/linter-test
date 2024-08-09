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

plugin "template" {
  enabled = true
  version = "0.1.0"
  source  = "C:\\Users\\saadr\\.tflint.d\\plugins\\tflint-ruleset-template.so"
}

# Add any other TFLint configurations or rules here



rule "terraform_required_version" {
  enabled = false
}

rule "terraform_required_providers" {
  enabled = false
}

