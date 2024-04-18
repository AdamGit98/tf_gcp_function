# Define a local variable for the Lambda function
# source code path in order to avoid repetitions.
locals {
  lambda_handler       = format("%s.lambda_handler", var.lambda_name)
  requirements_txt     = format("%s/requirements.txt", var.lambda_source)
  cloudwatch_log_group = format("/aws/lambda/%s", var.lambda_name)
  arn_policy_string    = join("~", var.policy_arn)
}

# Compute the source code hash, only taking into
# consideration the actual application code files
# and the dependencies list.
resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(var.lambda_source, "*.py"),
      fileset(var.lambda_source, "requirements.txt"),
    ) :
    filename => filemd5(format("%s/%s", var.lambda_source, filename))
  }
}

resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = <<EOT
        cd ${var.lambda_source};
        python -m venv .venv;
        ./.venv/scripts/activate;
        pip install -r requirements.txt -t .;
        ./.venv/scripts/deactivate;
      EOT

    interpreter = ["powershell", "-Command"]
  }

  # Only re-run this if the dependencies or their versions
  # have changed since the last deployment with Terraform
  triggers = {
    #dependencies_versions = filemd5(local.requirements_txt)
    source_code_hash = random_uuid.lambda_src_hash.result # This is a suitable option too
    description      = var.description
  }

}

# Create an archive form the Lambda source code,
# filtering out unneeded files.
data "archive_file" "lambda_source_package" {
  type        = "zip"
  source_dir  = var.lambda_source
  output_path = format("%s/.tmp/%s.zip", path.module, random_uuid.lambda_src_hash.result)

  excludes = [
    ".venv"
  ]

  # This is necessary, since archive_file is now a
  # `data` source and not a `resource` anymore.
  # Use `depends_on` to wait for the "install dependencies"
  # task to be completed.
  depends_on = [null_resource.install_dependencies]
}


data "aws_iam_role" "iam_for_lambda" {
  # IAM Roles are "global" resources. Lambda functions aren't.
  # In order to deploy the Lambda function in multiple regions
  # within the same account, separate Roles must be created.
  # The same Role could be shared across different Lambda functions,
  # but it's just not convenient to do so in Terraform.
  name = var.iam_role_name
}


# Deploy the Lambda function to AWS
resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_name
  role             = data.aws_iam_role.iam_for_lambda.arn
  filename         = data.archive_file.lambda_source_package.output_path
  runtime          = var.python_runtime
  handler          = local.lambda_handler
  memory_size      = var.memory_size
  timeout          = var.timeout
  description      = var.description
  publish          = true
  source_code_hash = data.archive_file.lambda_source_package.output_base64sha256

  layers = var.layers

  environment {
    variables = {
      LOG_LEVEL = var.lambda_log_level
    }
  }

  lifecycle {
    # Terraform will any ignore changes to the
    # environment variables after the first deploy.
    ignore_changes = [environment]
  }

  depends_on = [
    aws_iam_role_policy_attachment.policies,
    aws_cloudwatch_log_group.lambda
  ]
}

# The Lambda function would create this Log Group automatically
# at runtime if provided with the correct IAM policy, but
# we explicitly create it to set an expiration date to the streams.
resource "aws_cloudwatch_log_group" "lambda" {
  name              = local.cloudwatch_log_group
  retention_in_days = var.log_retention_period
}

resource "aws_iam_role_policy_attachment" "policies" {
  role       = var.iam_role_name
  count      = length(var.policy_arn)
  policy_arn = trimspace(split("~", local.arn_policy_string)[count.index])
}