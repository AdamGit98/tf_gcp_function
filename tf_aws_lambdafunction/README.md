## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | 2.3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.60.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role_policy_attachment.policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [null_resource.install_dependencies](https://registry.terraform.io/providers/hashicorp/null/3.2.1/docs/resources/resource) | resource |
| [random_uuid.lambda_src_hash](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/uuid) | resource |
| [archive_file.lambda_source_package](https://registry.terraform.io/providers/hashicorp/archive/2.3.0/docs/data-sources/file) | data source |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to be deployed into. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | lambda description | `string` | `""` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | name for the IAM role | `string` | n/a | yes |
| <a name="input_lambda_log_level"></a> [lambda\_log\_level](#input\_lambda\_log\_level) | Log level for the Lambda Python runtime. | `string` | `"DEBUG"` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | lambda name | `string` | n/a | yes |
| <a name="input_lambda_source"></a> [lambda\_source](#input\_lambda\_source) | relative path for the lambda source code | `string` | n/a | yes |
| <a name="input_lambda_version"></a> [lambda\_version](#input\_lambda\_version) | reqiured lambda version | `string` | `"0.0.0"` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | ARN of any layers used for this lambda | `set(string)` | `[]` | no |
| <a name="input_log_retention_period"></a> [log\_retention\_period](#input\_log\_retention\_period) | AWS log retention period for this lambda in days | `number` | `30` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | default memory size for the lambda | `number` | `128` | no |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | polices for the ARN | `set(string)` | n/a | yes |
| <a name="input_python_runtime"></a> [python\_runtime](#input\_python\_runtime) | Required python runtime | `string` | `"python3.9"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Default timout for the lambda in seconds | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_policies"></a> [arn\_policies](#output\_arn\_policies) | ARM for the AWS policies for this lambda |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | ARN required for invoking this lambda |
| <a name="output_logging_name"></a> [logging\_name](#output\_logging\_name) | Cloudwatch logging group for this lambda |
| <a name="output_version"></a> [version](#output\_version) | AWS Version for this lambda |
