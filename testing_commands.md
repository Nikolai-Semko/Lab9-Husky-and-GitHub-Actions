# Testing Guide for DevOps CI/CD Pipeline

This guide provides step-by-step instructions for testing the CI/CD pipeline setup.

## 🔧 Initial Setup

### 1. Clone and Setup Repository

```bash
# Clone the repository
git clone <your-repository-url>
cd <repository-name>

# Install Node.js dependencies
npm install

# Make pre-commit hook executable (Linux/Mac)
chmod +x .husky/pre-commit

# Initialize Terraform
cd infrastructure
terraform init
cd ..
```

### 2. Verify Husky Installation

```bash
# Check if Husky is properly installed
ls -la .husky/
cat .husky/pre-commit
```

## 🧪 Testing Pre-commit Hooks

### Test 1: Terraform Format Check

1. **Create a formatting error:**
   ```bash
   # Edit infrastructure/main.tf and add unnecessary spaces
   # For example, add extra spaces before or after braces
   
   # Try to commit
   git add .
   git commit -m "Test formatting error"
   ```
   **Expected Result:** Commit should fail with formatting error

2. **Fix the formatting:**
   ```bash
   # Fix formatting
   cd infrastructure
   terraform fmt -recursive
   cd ..
   
   # Commit again
   git add .
   git commit -m "Fix formatting"
   ```
   **Expected Result:** Commit should succeed

### Test 2: Terraform Validation Error

1. **Create a syntax error:**
   ```bash
   # Edit infrastructure/main.tf and introduce a syntax error
   # For example, remove a closing brace or add invalid syntax
   
   git add .
   git commit -m "Test syntax error"
   ```
   **Expected Result:** Commit should fail with validation error

2. **Fix the syntax error:**
   ```bash
   # Fix the syntax error in main.tf
   
   git add .
   git commit -m "Fix syntax error"
   ```
   **Expected Result:** Commit should succeed

### Test 3: Bypass Pre-commit Hook

```bash
# Create an error and bypass pre-commit hook
# Edit main.tf to introduce formatting error
git add .
git commit -m "Bypass pre-commit test" --no-verify
```
**Expected Result:** Commit should succeed despite errors

## 🚀 Testing GitHub Actions Workflow

### Test 1: Pull Request with Errors

1. **Create a branch with errors:**
   ```bash
   git checkout -b test-formatting-error
   
   # Edit infrastructure/main.tf and introduce formatting errors
   # For example, remove proper indentation or add extra spaces
   
   git add .
   git commit -m "Add formatting errors" --no-verify
   git push origin test-formatting-error
   ```

2. **Create a Pull Request:**
   - Go to GitHub and create a pull request from `test-formatting-error` to `main`
   - Check the "Actions" tab to see the workflow running
   
   **Expected Result:** 
   - Workflow should fail on formatting check
   - You should see detailed error messages in the workflow summary

### Test 2: Fix Errors and Rerun

1. **Fix the errors:**
   ```bash
   # Still on test-formatting-error branch
   cd infrastructure
   terraform fmt -recursive
   cd ..
   
   git add .
   git commit -m "Fix formatting errors"
   git push origin test-formatting-error
   ```

2. **Check workflow:**
   - The workflow should automatically rerun
   
   **Expected Result:** 
   - Workflow should now pass
   - All jobs should show green checkmarks

### Test 3: Test Validation Job

1. **Create validation error:**
   ```bash
   git checkout -b test-validation-error
   
   # Edit infrastructure/main.tf and introduce a validation error
   # For example, reference a non-existent resource or use invalid syntax
   
   git add .
   git commit -m "Add validation error" --no-verify
   git push origin test-validation-error
   ```

2. **Create Pull Request and observe:**
   - Format check should pass (if properly formatted)
   - Validation job should fail
   
   **Expected Result:** Workflow fails at validation step

## 📊 Monitoring and Verification

### Check Workflow Results

1. **In GitHub:**
   - Go to "Actions" tab
   - Click on the workflow run
   - Check individual job results
   - Review step summaries

2. **Key things to verify:**
   - ✅ Format check results
   - ✅ Validation results  
   - ✅ TFLint analysis (if available)
   - ✅ Security scan results
   - ✅ Terraform plan generation

### Download Artifacts

```bash
# Security scan reports are uploaded as artifacts
# Download them from the GitHub Actions run page
```

## 🔍 Troubleshooting

### Common Issues

1. **Husky not working:**
   ```bash
   # Reinstall Husky
   npm uninstall husky
   npm install husky --save-dev
   npm run prepare
   chmod +x .husky/pre-commit
   ```

2. **Terraform not found in pre-commit:**
   ```bash
   # Make sure Terraform is installed and in PATH
   terraform version
   which terraform
   ```

3. **Permission denied on pre-commit hook:**
   ```bash
   chmod +x .husky/pre-commit
   ```

4. **GitHub Actions failing unexpectedly:**
   - Check the workflow logs in GitHub Actions
   - Verify file paths are correct
   - Ensure Terraform syntax is valid

### Manual Testing Commands

```bash
# Test pre-commit hook manually
./.husky/pre-commit

# Test Terraform commands
cd infrastructure
terraform fmt -check -recursive
terraform validate
terraform init
terraform plan

# Test Node.js scripts
npm run terraform:fmt
npm run terraform:validate
```

## 📋 Checklist

Before submitting, ensure:

- [ ] Pre-commit hooks prevent improperly formatted commits
- [ ] Pre-commit hooks prevent commits with validation errors
- [ ] GitHub Actions workflow runs on pull requests
- [ ] Format check job works correctly
- [ ] Validation job works correctly
- [ ] Security scanning produces reports
- [ ] Terraform plan job generates plans
- [ ] All documentation is complete
- [ ] Repository structure is correct

## 🎯 Expected Learning Outcomes

After completing all tests, you should understand:

1. How Git hooks work and when they execute
2. How to configure automated code quality checks
3. How GitHub Actions workflows are triggered
4. How to create comprehensive CI/CD pipelines
5. How to implement Infrastructure as Code best practices
6. How to integrate security scanning into DevOps workflows