terraform {
  backend "s3" {
    # Backend configuration for remote state storage
    # Uncomment and update with your S3 bucket details
    
    # bucket         = "your-terraform-state-bucket"
    # key            = "github-actions-terraform/terraform.tfstate"
    # region         = "ap-south-1"
    # encrypt        = true
    # dynamodb_table = "terraform-locks"
  }
}
