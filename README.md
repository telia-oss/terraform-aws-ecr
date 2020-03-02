## ECR Module

[![workflow](https://github.com/telia-oss/terraform-aws-ecr/workflows/workflow/badge.svg)](https://github.com/telia-oss/terraform-aws-ecr/actions)

This module creates a repository on ECR (and associated policies) that other accounts can be given push and pull access to.

- Creates a repository on ECR
- Creates a policy to allow other accounts push and pull access
- Creates a lifecycle policy that expires oldest images when a specified limit (default 100) is reached
- Enable/Disable vulnerability scan on image push (default enabled)



