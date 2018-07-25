# ------------------------------------------------------------------------------
# Output
# ------------------------------------------------------------------------------
output "repository_arn" {
  description = "Full ARN of the repository."
  value       = "${aws_ecr_repository.ecr-repo.arn}"
}

output "repository_url" {
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName )"
  value       = "${aws_ecr_repository.ecr-repo.repository_url}"
}
