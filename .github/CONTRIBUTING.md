# Contributing

This repository is a public, sanitized reference architecture. Contributions must not contain employer, customer or production subscription information.

## Safety requirements

- Use synthetic address spaces, zero-value GUIDs and documentation-only domains.
- Never commit credentials, Terraform state, plans, tenant/subscription IDs, private DNS records or Azure exports.
- Prefer managed identity, narrow RBAC scope, private endpoints and auditable diagnostics.
- Document reliability, security, operability and cost consequences of each design change.

## Validation

```bash
terraform fmt -recursive
terraform init -backend=false
terraform validate
terraform plan -var-file=examples/dev.tfvars
```

Replace the zero subscription ID only in a secure local input or environment variable. Review every plan before applying it to a lab subscription.
