plugin "aws" {
  enabled = true
}
config {
  module = true
  deep_check = true
}
rule "terraform_required_providers" { enabled = true }