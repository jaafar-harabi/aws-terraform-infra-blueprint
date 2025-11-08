# aws-terraform-infra-blueprint

Production-shaped AWS IaC with multi-env (dev/stage/prod): VPC, EKS, RDS (Postgres), S3, IAM, remote state, and CI (plan/apply).

## Key features
- Remote state (S3 + DynamoDB lock)
- Minimal VPC/EKS/RDS/S3 modules
- GitHub Actions: lint/validate, plan on PR, apply on main via OIDC
- Conventional commits + semantic-release tags/changelog
- Renovate for automated dependency PRs
- Pre-commit hooks: fmt/validate/tflint/tfsec


