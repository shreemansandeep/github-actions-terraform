# GitHub Actions Terraform CI/CD

Automated Terraform deployment pipeline using GitHub Actions with AWS provider configured for Mumbai region (ap-south-1).

## 📋 Prerequisites

- AWS Account with programmatic access
- GitHub Repository
- GitHub Secrets configured:
  - `AWS_ACCESS_KEY`: AWS access key ID
  - `AWS_SECRET_KEY`: AWS secret access key

## 🔧 Setup Instructions

### 1. Configure GitHub Secrets

Add the following secrets to your GitHub repository:

```
Settings → Secrets and variables → Actions → New repository secret
```

| Secret Name | Value |
|---|---|
| `AWS_ACCESS_KEY` | Your AWS Access Key ID |
| `AWS_SECRET_KEY` | Your AWS Secret Access Key |

### 2. Project Structure

```
.
├── provider.tf           # AWS provider configuration
├── variables.tf          # Input variables
├── backend.tf            # Remote state configuration (S3)
├── terraform.tfvars.example  # Example variables file
├── .gitignore            # Git ignore for sensitive files
└── .github/
    └── workflows/
        └── terraform.yml # CI/CD workflow
```

### 3. Local Development

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt -recursive

# Plan changes
terraform plan -out=tfplan

# Apply changes
terraform apply tfplan
```

## 🚀 Workflow Stages

The GitHub Actions workflow includes 4 stages:

### Stage 1: Validate
- **Trigger**: Every push and PR
- **Tasks**: Format checking, initialization, validation
- **Branch**: main, develop

### Stage 2: Plan
- **Trigger**: PR or push to develop
- **Tasks**: Full terraform plan, artifact upload, PR comment
- **Environment**: Varies by branch (dev/prod)

### Stage 3: Apply
- **Trigger**: Push to main only
- **Tasks**: Initialize, apply changes, output results
- **Environment**: Production

### Stage 4: Cleanup
- **Trigger**: Workflow failure on PR
- **Tasks**: Notify and cleanup

## 📝 Configuration Details

**Region**: `ap-south-1` (Mumbai)  
**Terraform Version**: 1.5.0  
**AWS Provider Version**: ~> 5.0  

## 🔐 Security Notes

- ✅ Credentials stored as GitHub Secrets (not in code)
- ✅ Apply auto-approval only on main branch
- ✅ Plan always created for review before main merges
- ✅ Terraform state should be stored in S3 backend (see backend.tf)

## 📦 Remote State Configuration

To enable S3 backend for state management:

1. Create S3 bucket for Terraform state
2. Create DynamoDB table for state locking
3. Update `backend.tf` with your bucket details
4. Run: `terraform init` (it will prompt to migrate state)

## ⚙️ GitHub Actions Job Dependencies

```
validate
├── plan (on PR/develop)
└── apply (on main push)
```

## 🔄 Workflow Triggers

| Event | Branch | Action |
|---|---|---|
| Push | main | Validate + Apply |
| Push | develop | Validate + Plan |
| Pull Request | main, develop | Validate + Plan |

## 📊 Environment Variables

| Variable | Value | Source |
|---|---|---|
| `AWS_REGION` | `ap-south-1` | Workflow env |
| `AWS_ACCESS_KEY_ID` | *** | GitHub Secret |
| `AWS_SECRET_ACCESS_KEY` | *** | GitHub Secret |
| `TF_VAR_environment` | prod/dev | Workflow env |

## 🐛 Troubleshooting

### AWS Credentials Not Found
- Verify secrets are added to repository settings
- Check secret names match exactly: `AWS_ACCESS_KEY`, `AWS_SECRET_KEY`

### Terraform Validation Fails
- Run `terraform validate` locally
- Check variable definitions in `variables.tf`
- Review error messages in GitHub Actions logs

### Plan Upload Fails
- Ensure artifact name matches reference
- Verify retention-days setting

## 📚 References

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [GitHub Actions Terraform Setup](https://github.com/hashicorp/setup-terraform)
- [AWS SDK Configuration](https://docs.aws.amazon.com/sdk-for-go/latest/developer-guide/configuring-sdk.html)
