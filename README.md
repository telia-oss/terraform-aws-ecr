## ECR Module

[![Build Status](https://travis-ci.com/telia-oss/terraform-aws-ecr.svg?branch=master)](https://travis-ci.com/telia-oss/terraform-aws-ecr)

This module creates a repository on ECR (and associated policies) that other accounts can be given push and pull access to.

- Creates a repository on ECR
- Creates a policy to allow other accounts push and pull access
- Creates a lifecycle policy that expires oldest images when a specified limit (default 100) is reached