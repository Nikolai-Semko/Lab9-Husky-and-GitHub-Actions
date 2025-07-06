# Variable definitions for the Terraform configuration

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "East US"

  validation {
    condition = contains([
      "East US", "West US", "West Europe", "East Asia"
    ], var.location)
    error_message = "Location must be one of: East US, West US, West Europe, East Asia."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^(dev|staging|prod)$", var.environment))
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "devops-lab"
}