# TFLint configuration file for Terraform static analysis

config {
  # Enable all rules by default
  disabled_by_default = false
  
  # Force the use of colors in output
  force = false
  
  # Set the minimum severity level for issues to be reported
  # Options: error, warning, notice
  format = "default"
}

# Enable Azure provider plugin
plugin "azurerm" {
  enabled = true
  version = "0.24.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# Azure-specific rules
rule "azurerm_resource_missing_tags" {
  enabled = true
  tags = [
    "Environment",
    "Project",
    "CreatedBy"
  ]
}

# General Terraform rules
rule "terraform_required_version" {
  enabled = true
}

rule "terraform_required_providers" {
  enabled = true
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_typed_variables" {
  enabled = true
}

rule "terraform_unused_declarations" {
  enabled = true
}

rule "terraform_comment_syntax" {
  enabled = true
}

rule "terraform_deprecated_index" {
  enabled = true
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = true
}