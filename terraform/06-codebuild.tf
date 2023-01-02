resource "aws_iam_role" "example" {
  name = "${local.name}-build"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  role = aws_iam_role.example.name

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:us-west-2:421320058418:log-group:/aws/codebuild/${local.name}",
                "arn:aws:logs:us-west-2:421320058418:log-group:/aws/codebuild/${local.name}:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::codepipeline-us-west-2-*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:GetObjectVersion",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.id}",
                "arn:aws:s3:::${aws_s3_bucket.codepipeline_bucket.id}/*"
            ],
            "Action": [
                "s3:PutObject",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "codebuild:CreateReportGroup",
                "codebuild:CreateReport",
                "codebuild:UpdateReport",
                "codebuild:BatchPutTestCases",
                "codebuild:BatchPutCodeCoverages"
            ],
            "Resource": [
                "arn:aws:codebuild:us-west-2:421320058418:report-group/${local.name}-*"
            ]
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:ListSecrets",
                "secretsmanager:GetSecretValue"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "secretsmanager:*",
            "Resource": "arn:aws:secretsmanager:us-west-2:421320058418:secret:/mongodb/rachit-mongodb-url-U4usVz"
        },
        {
            "Effect": "Allow",
            "Resource": [
                "arn:aws:logs:us-west-2:421320058418:log-group:${local.group_name}",
                "arn:aws:logs:us-west-2:421320058418:log-group:${local.group_name}:*"
            ],
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ]
        },
	{
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_codebuild_project" "example" {
  name          = "${local.name}-project"
  description   = "test_codebuild_project"
  build_timeout = "5"
  service_role  = aws_iam_role.example.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = local.image
    type                        = local.type
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = local.group_name
      stream_name = local.stream_name
    }
  }

  source {
    type            = "GITHUB"
    location        = local.location
    git_clone_depth = 1

    git_submodules_config {
      fetch_submodules = true
    }
  }
}
