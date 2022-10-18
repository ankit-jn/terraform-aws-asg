# ARJ-Stack: AWS Autoscaling Group Terraform module

A Terraform module for configuring Auto Scaling Groups

## Resources
This module features the following components to be provisioned with different combinations:

- Auto Scaling Group [[aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group)]
- Launch Template [[aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)]
- IAM Instance profile [[aws_iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile)]
- IAM Policy [[aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)]
    - Policies to define permissions used in Instance Profile
- IAM Role [[aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)]
    - IAM Role that will be used with Instance Profile
- IAM Roles-Policy Attachments [[aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)]

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22.0 |

## Examples

Refer [Configuration Examples](https://github.com/arjstack/terraform-aws-examples/tree/main/aws-asg) for effectively utilizing this module.

## Inputs
---

#### ASG Specific Properties

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | Name of the Auto Scaling Group | `string` |  | yes |  |
| <a name="min_size"></a> [min_size](#input\_min_size) | Minimum size of the Auto Scaling Group | `number` |  | yes |  |
| <a name="max_size"></a> [max_size](#input\_max_size) | Maximum size of the Auto Scaling Group | `number` |  | yes |  |
| <a name="desired_capacity"></a> [desired_capacity](#input\_desired_capacity) | The number of Amazon EC2 instances that should be running in ASG | `number` |  | no |  |
| <a name="vpc_zone_identifier"></a> [vpc_zone_identifier](#input\_vpc_zone_identifier) | List of subnet IDs to launch resources in | `list(string)` |  | yes | <pre>[ "subnet-xxxxx......", "subnet-xxxx4747cv..." ] |
| <a name="capacity_rebalance"></a> [capacity_rebalance](#input\_capacity_rebalance) | Whether capacity rebalance is enabled | `bool` | `false` | no |  |
| <a name="default_cooldown"></a> [default_cooldown](#input\_default_cooldown) | Amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` |  | no |  |
| <a name="default_instance_warmup"></a> [default_instance_warmup](#input\_default_instance_warmup) | Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics | `number` |  | no |  |
| <a name="protect_from_scale_in"></a> [protect_from_scale_in](#input\_protect_from_scale_in) | Whether newly launched instances are automatically protected from termination by Amazon EC2 Auto Scaling when scaling in | `bool` | `false` | no |  |

#### Launch Template Specific Properties

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="launch_template_name"></a> [launch_template_name](#input\_launch_template_name) | The name of the launch template | `string` | `<ASG Name>-template` | no |  |
| <a name="launch_template_description"></a> [launch_template_description](#input\_launch_template_description) | Description of the launch template | `string` |  | no |  |
| <a name="instance_type"></a> [instance_type](#input\_instance_type) | The type of the instance | `string` |  | yes |  |
| <a name="image_id"></a> [image_id](#input\_image_id) | The AMI from which to launch the instance | `string` |  | yes |  |
| <a name="user_data"></a> [user_data](#input\_user_data) | The Base64-encoded user data to provide when launching the instance | `string` |  | no |  |
| <a name="health_check_type"></a> [health_check_type](#input\_health_check_type) | `EC2` or `ELB`. Controls how health checking is done | `string` |  | no |  |
| <a name="block_device_mappings"></a> [block_device_mappings](#block\_device\_mappings) | List of Volumes to attach to the instance besides the volumes specified by the AMI | `list(any)` |  | no |  |
| <a name="cpu_options"></a> [cpu_options](#cpu\_options) | The CPU options Map for the instance | `map(number)` |  | no |  |
| <a name="cpu_credits"></a> [cpu_credits](#cpu\_credits) | CPU Credit specification, CPU Credits can be `standard` or `unlimited` | `string` |  | no |  |

#### Instance Profile Specific Properties

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="create_instance_profile"></a> [create_instance_profile](#input\_create_instance_profile) | Flag to decide is an IAM instance profile is created | `bool` | `false` | no |  |
| <a name="instance_profile_name"></a> [instance_profile_name](#input\_instance_profile_name) | The name of the instance profile | `string` | `<ASG Name>-instance-profile` | no |  |
| <a name="instance_profile_path"></a> [instance_profile_path](#input\_instance_profile_path) | Path to the instance profile | `string` | `"/"` | no |  |
| <a name="create_instance_profile_role"></a> [create_instance_profile_role](#input\_create_instance_profile_role) | Flag to decide if new role for Instance Profile is required or to use existing IAM Role | `bool` | `true` | no |  |
| <a name="instance_profile_role_name"></a> [instance_profile_role_name](#input\_instance_profile_role_arn) | Name of the IAM role if `create_instance_profile_role` is false | `string` |  | no |  |
| <a name="instance_profile_policies"></a> [instance_profile_policies](#instance_profile_policy) | List of Policies (to be provisioned) to be attached to Instance profile | `list` |  | no | <pre>[<br>   {<br>     "name" = "arjstack-custom-policy"<br>   },<br>   {<br>     "name"  = "AWSCloudTrail_ReadOnlyAccess"<br>     "arn"   = "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess"<br>   }<br>]<br> |

#### Tags Specific Properties

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="default_tags"></a> [default_tags](#input\_default_tags) | A map of tags to assign to all the resource. | `map` | `{}` | no |  |
| <a name="instance_profile_tags"></a> [instance_profile_tags](#input\_instance_profile_tags) | A map of tags to assign to Instance profile. | `map` | `{}` | no |  |


## Nested Configuration Maps:  

#### instance_profile_policy

Policy content to be add to the new policy (i.e. the policy for which arn is not defined) will be read from the JSON document.<br>
&nbsp;&nbsp;&nbsp;- JSON document must be placed in the directory `policies` under root directory.<br>
&nbsp;&nbsp;&nbsp;- The naming format of the file: <Value set in `name` property>.json

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | Policy Name | `string` |  | yes |  |
| <a name="arn"></a> [arn](#input\_arn) | Policy ARN (if existing policy) | `string` |  | no |  |

#### block_device_mappings

- `ebs_encrypted` must be set to true when `ebs_kms_key_id` is set.
- `ebs_iops` must be set with a `ebs_volume_type` of "io1/io2".
- Either one of `ebs_encrypted` as `true` and `ebs_snapshot_id` can be used

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | The name of the device to mount. | `string` |  | yes |  |
| <a name="no_device"></a> [name](#input\_no\_device) | Suppresses the specified device included in the AMI's block device mapping. | `number` |  | no |  |
| <a name="virtual_name"></a> [virtual_name](#input\_virtual\_name) | The Instance Store Device Name | `string` |  | no |  |
| <a name="ebs_delete_on_termination"></a> [ebs_delete_on_termination](#input\_ebs\_delete\_on\_termination) | Whether the volume should be destroyed on instance termination. | `bool` | `false` | no |  |
| <a name="ebs_encrypted"></a> [ebs_encrypted](#input\_ebs\_encrypted) | Enables EBS encryption on the volume | `bool` | `false` | no |  |
| <a name="ebs_kms_key_id"></a> [ebs_kms_key_id](#input\_ebs\_kms\_key\_id) | The ARN of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume. | `string` |  | no |  |
| <a name="ebs_snapshot_id"></a> [ebs_snapshot_id](#input\_ebs\_snapshot\_id) | The Snapshot ID to mount. | `string` |  | no |  |
| <a name="ebs_volume_size"></a> [ebs_volume_size](#input\_ebs\_volume\_size) | The size of the volume in gigabytes. | `number` |  | no |  |
| <a name="ebs_volume_type"></a> [ebs_volume_type](#input\_ebs\_volume\_type) | The volume type | `string` | `gp2` | no |  |
| <a name="ebs_iops"></a> [ebs_iops](#input\_ebs\_iops) | The amount of provisioned IOPS | `number` |  | no |  |
| <a name="ebs_throughput"></a> [ebs_throughput](#input\_ebs\_throughput) | The throughput to provision for a gp3 volume in MiB/s (specified as an integer, e.g., 500), with a maximum of 1,000 MiB/s. | `number` |  | no |  |

#### cpu_options

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="core_count"></a> [core_count](#input\_core\_count) | The number of CPU cores for the instance. | `number` | `1` | no |  |
| <a name="threads_per_core"></a> [threads_per_core](#input\_threads\_per\_core) | The number of threads per CPU core. | `number` | `2` | no |  |


## Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="arn"></a> [arn](#output\_arn) |  `string` | ARN of Auto Scaling Group |
| <a name="instance_profile_role_arn"></a> [instance_profile_role_arn](#output\_instance\_profile\_role\_arn) | `string` | ARN of IAM role provisioned for Instance Profile |
| <a name="instance_profile_arn"></a> [instance_profile_arn](#output\_instance\_profile\_arn) | `string` | ARN of IAM Instance Profile |
| <a name="launch_template"></a> [launch_template](#output\_launch\_template) | `map(string)` | Launch Template Details (`ID` and `ARN`) |

## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-iam/graphs/contributors).

