# DevOps Lab: Terraform CI/CD with GitHub Actions and Husky

This project demonstrates a complete CI/CD pipeline for Infrastructure as Code (IaC) using Terraform, GitHub Actions, and Git hooks with Husky.

## 🏗️ Project Structure

```
.
├── .github/
│   └── workflows/
│       └── action-terraform-verify.yml   # GitHub Actions workflow
├── .husky/
│   └── pre-commit                        # Git pre-commit hook
├── infrastructure/
│   ├── main.tf                          # Main Terraform configuration
│   ├── variables.tf                     # Variable definitions
│   └── versions.tf                      # Provider requirements
├── package.json                         # Node.js project configuration
└── README.md                           # This file
```

## 🚀 Features

### Pre-commit Hooks (Husky)
- **Terraform Format Check**: Ensures all `.tf` files are properly formatted
- **Terraform Validation**: Validates syntax and configuration
- **TFLint**: Static analysis for Terraform (optional)

### GitHub Actions CI/CD Pipeline
1. **Terraform Format Check**: Validates formatting on changed files
2. **Terraform Validation & Security**: 
   - Runs `terraform validate`
   - Performs static analysis with TFLint
   - Security scanning with Checkov
3. **Terraform Plan**: Generates execution plan for review

## 📋 Prerequisites

- Node.js (for Husky)
- Terraform >= 1.0
- Git
- Azure CLI (for Azure authentication)

### Optional Tools
- TFLint (for enhanced static analysis)
- Checkov (for security scanning)

## 🛠️ Setup Instructions

### 1. Initialize Node.js Project and Husky

```bash
# Install dependencies
npm install

# Initialize Husky (if not already done)
npm run prepare

# Make pre-commit hook executable
chmod +x .husky/pre-commit
```

### 2. Initialize Terraform

```bash
cd infrastructure
terraform init
```

### 3. Test Pre-commit Hooks

```bash
# Test formatting
terraform fmt -check -recursive

# Test validation
terraform validate
```

## 🧪 Testing the Pipeline

### Testing Pre-commit Hooks

1. **Create a formatting error:**
   ```bash
   # Add unnecessary spaces or incorrect indentation to a .tf file
   git add .
   git commit -m "Test formatting error"
   # This should fail and prevent the commit
   ```

2. **Fix the error:**
   ```bash
   terraform fmt -recursive
   git add .
   git commit -m "Fix formatting"
   # This should succeed
   ```

3. **Bypass pre-commit for testing:**
   ```bash
   git commit -m "Test commit" --no-verify
   ```

### Testing GitHub Actions

1. **Create a pull request with formatting errors:**
   - Introduce formatting or validation errors
   - Commit with `--no-verify` to bypass pre-commit hooks
   - Create a pull request
   - Watch the GitHub Actions workflow fail

2. **Fix errors and watch workflow pass:**
   - Fix the formatting/validation errors
   - Push to the same branch
   - Watch the workflow succeed

## 📊 Terraform Resources

This configuration creates:

- **Azure Resource Group**: Container for all resources
- **Azure Storage Account**: Basic storage resource for demonstration
- **Random String**: For unique resource naming

### Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `location` | Azure region | `East US` | No |
| `environment` | Environment name | `dev` | No |
| `project_name` | Project name | `devops-lab` | No |

## 🔍 Pipeline Jobs Explained

### Job 1: Terraform Format Check
- Runs on all pull requests
- Checks only modified `.tf` files
- Prevents improperly formatted code from being merged

### Job 2: Terraform Validation & Security
- Validates Terraform syntax and configuration
- Runs TFLint for best practices analysis
- Performs security scanning with Checkov
- Uploads security reports as artifacts

### Job 3: Terraform Plan
- Generates an execution plan
- Shows what resources would be created/modified
- Runs only on pull requests
- Does not apply changes (dry-run only)

## 🔧 Common Commands

```bash
# Format Terraform files
npm run terraform:fmt

# Validate Terraform configuration
npm run terraform:validate

# Initialize Terraform
npm run terraform:init

# Generate Terraform plan
npm run terraform:plan

# Apply Terraform configuration (use with caution)
npm run terraform:apply

# Destroy Terraform resources (use with caution)
npm run terraform:destroy
```

## 🚨 Security Notes

- This configuration uses local state (not recommended for production)
- For production use, configure a remote backend (Azure Storage, Terraform Cloud, etc.)
- Ensure proper Azure authentication is configured
- Review Checkov security scan results before applying

## 🎯 Learning Objectives

After completing this lab, you will understand:

1. **Infrastructure as Code (IaC)**: How to define infrastructure using code
2. **Git Hooks**: How to enforce quality checks before commits
3. **CI/CD Pipelines**: How to automate testing and validation
4. **Terraform Best Practices**: Formatting, validation, and security scanning
5. **GitHub Actions**: How to create automated workflows

## 📚 Additional Resources

- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Husky Documentation](https://typicode.github.io/husky/)
- [TFLint Rules](https://github.com/terraform-linters/tflint/tree/master/docs/rules)
- [Checkov Documentation](https://www.checkov.io/)