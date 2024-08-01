resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "lambda_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = "s3:GetObject",
        Effect = "Allow",
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_lambda_function" "s3_trigger_function" {
  filename         = "/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/lambda-function/lambda_function.zip"  # Ensure this file exists in your working directory
  function_name    = "s3_trigger_function"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "lambda-function.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256("/mnt/c/Users/Clops_Shobin/Terraform/terraform-practice3/modules/lambda-function/lambda_function.zip")

  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
    }
  }
}