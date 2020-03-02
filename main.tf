# ------------------------------------------------------------------------------
# Resources
# ------------------------------------------------------------------------------

resource "aws_ecr_repository" "ecr_repo" {
  name = var.name_prefix

  image_tag_mutability = var.image_tag_mutability ? "MUTABLE" : "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = var.enable_scan_on_push
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  repository = aws_ecr_repository.ecr_repo.id
  policy     = data.aws_iam_policy_document.ecr_policy_doc.json
}

data "aws_iam_policy_document" "ecr_policy_doc" {

  statement {
    effect = "Allow"

    principals {
      type = "AWS"

      identifiers = formatlist("arn:aws:iam::%s:root", var.trusted_accounts)
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

resource "aws_ecr_lifecycle_policy" "keep_last_N" {
  repository = aws_ecr_repository.ecr_repo.id

  policy = <<EOF
  {
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last N images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": ${var.max_images_retained}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
  }
EOF
}
