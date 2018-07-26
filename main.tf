# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

resource "aws_ecr_repository" "ecr-repo" {
  name = "${var.name_prefix}"
}

resource "aws_ecr_repository_policy" "ecr-policy" {
  repository = "${aws_ecr_repository.ecr-repo.id}"
  policy     = "${data.aws_iam_policy_document.ecr-policy-doc.json}"
}

data "aws_iam_policy_document" "ecr-policy-doc" {
  "statement" {
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = [
        "${formatlist("arn:aws:iam::%s:root", var.trusted_accounts)}",
      ]
    }

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
    ]
  }
}

resource "aws_ecr_lifecycle_policy" "keep-last-N" {
  repository = "${aws_ecr_repository.ecr-repo.id}"

  policy = <<EOF
  {
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last N images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.lifecycle_count_number}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
  }
EOF
}
