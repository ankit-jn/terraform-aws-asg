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
| <a name="min_size"></a> [min_size](#input\_min\_size) | Minimum size of the Auto Scaling Group | `number` |  | yes |  |
| <a name="max_size"></a> [max_size](#input\_max\_size) | Maximum size of the Auto Scaling Group | `number` |  | yes |  |
| <a name="desired_capacity"></a> [desired_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in ASG | `number` |  | no |  |
| <a name="capacity_rebalance"></a> [capacity_rebalance](#input\_capacity\_rebalance) | Whether capacity rebalance is enabled | `bool` | `false` | no |  |
| <a name="vpc_zone_identifier"></a> [vpc_zone_identifier](#input\_vpc\_zone\_identifier) | List of subnet IDs to launch resources in | `list(string)` |  | yes | <pre>[<br>   "subnet-xxxxx......",<br>   "subnet-xxxx4747cv..."<br>] |
| <a name="placement_group"></a> [placement_group](#input\_placement\_group) | The name of the placement group into which instances will be launched | `string` |  | no |  |
| <a name="service_linked_role_arn"></a> [service_linked_role_arn](#input\_service\_linked\_role\_arn) | ARN of the service-linked IAM role that the ASG will use to invoke other AWS services | `string` |  | no |  |
| <a name="suspended_processes"></a> [suspended_processes](#input\_suspended\_processes) | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. | `list(string)` | `[]` | no |  |
| <a name="termination_policies"></a> [termination_policies](#input\_termination\_policies) | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. The Possible Values are: <br>`OldestInstance`<br>`NewestInstance`<br>`OldestLaunchConfiguration`<br>`ClosestToNextInstanceHour`<br>`OldestLaunchTemplate`<br>`AllocationStrategy`<br>`Default` | `list(string)` | `[]` | no |  |
| <a name="force_delete"></a> [force_delete](#input\_force\_delete) | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. | `bool` | `false` | no |  |
| <a name="default_cooldown"></a> [default_cooldown](#input\_default\_cooldown) | Amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` |  | no |  |
| <a name="default_instance_warmup"></a> [default_instance_warmup](#input\_default\_instance\_warmup) | Amount of time, in seconds, until a newly launched instance can contribute to the Amazon CloudWatch metrics | `number` |  | no |  |
| <a name="protect_from_scale_in"></a> [protect_from_scale_in](#input\_protect\_from\_scale\_in) | Whether newly launched instances are automatically protected from termination by Amazon EC2 Auto Scaling when scaling in | `bool` | `false` | no |  |
| <a name="max_instance_lifetime"></a> [max_instance_lifetime](#input\_max\_instance\_lifetime) | Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. | `number` |  | no |  |
| <a name="target_group_arns"></a> [target_group_arns](#input\_target\_group\_arns) | Set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing | `[]` | no |  |
| <a name="health_check_type"></a> [health_check_type](#input\_health\_check\_type) | `EC2` or `ELB`. Controls how health checking is done | `string` |  | no |  |
| <a name="health_check_grace_period"></a> [health_check_grace_period](#input\_health\_check\_grace\_period) | `EC2` or `ELB`. Controls how health checking is done | `number` | `300` | no |  |
| <a name="min_elb_capacity"></a> [min_elb_capacity](#input\_min\_elb\_capacity) | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` |  | no |  |
| <a name="wait_for_elb_capacity"></a> [wait_for_elb_capacity](#input\_wait\_for\_elb\_capacity) | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior. | `number` |  | no |  |
| <a name="wait_for_capacity_timeout"></a> [wait_for_capacity_timeout](#input\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `number` |  | no |  |
| <a name="enabled_metrics"></a> [enabled_metrics](#input\_enabled\_metrics) | List of metrics to collect. The possible Values are:<br>`GroupDesiredCapacity`<br>`GroupInServiceCapacity`<br>`GroupPendingCapacity`<br>`GroupMinSize`<br>`GroupMaxSize`<br>`GroupInServiceInstances`<br>`GroupPendingInstances`<br>`GroupStandbyInstances`<br>`GroupStandbyCapacity`<br>`GroupTerminatingCapacity`<br>`GroupTerminatingInstances`<br>`GroupTotalCapacity`<br>`GroupTotalInstances`<br> | `list(string)` | `[]`  | no |  |
| <a name="metrics_granularity"></a> [metrics_granularity](#input\_metrics\_granularity) | Granularity to associate with the metrics to collect. The only valid value is `1Minute` | `string` | `1Minute` | no |  |
| <a name="use_mixed_instances_policy"></a> [use_mixed_instances_policy](#input\_use\_mixed\_instances\_policy) | Flag to decide if multiple launch targets should be selected by ASG | `bool` | `false` | no |  |
| <a name="mixed_instances_policy"></a> [mixed_instances_policy](#mixed_instances_policy) | Configurations to define launch targets for Auto Scaling groups. | `map(any)` | `{}` | no |  |

#### Launch Template Specific Properties

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="launch_template_name"></a> [launch_template_name](#input\_launch\_template\_name) | The name of the launch template | `string` | `<ASG Name>-template` | no |  |
| <a name="launch_template_description"></a> [launch_template_description](#input\_launch\_template\_description) | Description of the launch template | `string` |  | no |  |
| <a name="instance_type"></a> [instance_type](#input\_instance\_type) | The type of the instance | `string` |  | yes |  |
| <a name="image_id"></a> [image_id](#input\_image\_id) | The AMI from which to launch the instance | `string` |  | yes |  |
| <a name="block_device_mappings"></a> [block_device_mappings](#block\_device\_mappings) | List of Volumes to attach to the instance besides the volumes specified by the AMI | `list(any)` | `[]` | no |  |
| <a name="cpu_options"></a> [cpu_options](#cpu\_options) | The CPU options Map for the instance | `map(number)` | `{}` | no |  |
| <a name="credit_specifcation"></a> [credit_specifcation](#credit_specifcation) | Instance Credit specification | `map(string)` | `{}` | no |  |
| <a name="default_version"></a> [default_version](#input\_default\_version) | Default Version of the launch template. | `string` |  | no |  |
| <a name="disable_api_stop"></a> [disable_api_stop](#input\_disable\_api\_stop) | If true, enables EC2 Instance Stop Protection. | `bool` | `false` | no |  |
| <a name="disable_api_termination"></a> [disable_api_termination](#input\_disable\_api\_termination) | If true, enables EC2 Instance Termination Protection | `bool` | `false` | no |  |
| <a name="ebs_optimized"></a> [ebs_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |  |
| <a name="elastic_gpu_specifications"></a> [elastic_gpu_specifications](#elastic\_gpu\_specifications) | The Elastic GPU Specification Map | `map(string)` | `{}` | no |  |
| <a name="enable_monitoring"></a> [enable_monitoring](#input\_enable\_monitoring) | Flag to decide if launched EC2 instance will have detailed monitoring enabled? | `bool` | `false` | no |  |
| <a name="instance_initiated_shutdown_behavior"></a> [instance_initiated_shutdown_behavior](#input\_instance\_initiated\_shutdown\_behavior) | Shutdown behavior for the instance. Possible Values: `stop` or `terminate`. | `string` | `"stop"` | no |  |
| <a name="ram_disk_id"></a> [ram_disk_id](#input\_ram\_disk\_id) | The ID of the RAM disk | `string` |  | no |  |
| <a name="user_data"></a> [user_data](#input\_user\_data) | The Base64-encoded user data to provide when launching the instance | `string` |  | no |  |
| <a name="vpc_security_group_ids"></a> [vpc_security_group_ids](#input\_vpc\_security\_group\_ids) | A list of security group IDs to associate with. | `list(string)` | `[]` | no |  |

#### Instance Profile Specific Properties

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="create_instance_profile"></a> [create_instance_profile](#input\_create_instance_profile) | Flag to decide is an IAM instance profile is created | `bool` | `false` | no |  |
| <a name="instance_profile_name"></a> [instance_profile_name](#input\_instance_profile_name) | The name of the instance profile | `string` | `<ASG Name>-instance-profile` | no |  |
| <a name="instance_profile_path"></a> [instance_profile_path](#input\_instance_profile_path) | Path to the instance profile | `string` | `"/"` | no |  |
| <a name="create_instance_profile_role"></a> [create_instance_profile_role](#input\_create_instance_profile_role) | Flag to decide if new role for Instance Profile is required or to use existing IAM Role | `bool` | `true` | no |  |
| <a name="instance_profile_role_name"></a> [instance_profile_role_name](#input\_instance_profile_role_arn) | Name of the IAM role if `create_instance_profile_role` is false | `string` | `<ASG Name>-instance-profile-role` | no |  |
| <a name="instance_profile_policies"></a> [instance_profile_policies](#instance_profile_policy) | List of Policies (to be provisioned) to be attached to Instance profile | `list` |  | no | <pre>[<br>   {<br>     "name" = "arjstack-custom-policy"<br>     "policy_file" = "arjstack-custom-policy.json"<br>   },<br>   {<br>     "name"  = "AWSCloudTrail_ReadOnlyAccess"<br>     "arn"   = "arn:aws:iam::aws:policy/AWSCloudTrail_ReadOnlyAccess"<br>   }<br>]<br> |

#### Tags Specific Properties

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="default_tags"></a> [default_tags](#input\_default\_tags) | A map of tags to assign to all the resource. | `map(string)` | `{}` | no |  |
| <a name="asg_tags"></a> [asg_tags](#input\_asg\_tags) | A map of tags to assign to Auto Scaling Group. | `map(string)` | `{}` | no |  |
| <a name="instance_profile_tags"></a> [instance_profile_tags](#input\_instance\_profile\_tags) | A map of tags to assign to Instance profile and Role. | `map(string)` | `{}` | no |  |
| <a name="launch_template_tags"></a> [launch_template_tags](#input\_launch\_template\_tags) | A map of tags to assign to Laucnh Template. | `map(string)` | `{}` | no |  |
| <a name="as_resource_tags"></a> [as_resource_tags](#input\_as\_resource\_tags) | A map of tags to assign to the resources during launch. | `map(string)` | `{}` | no |  |


## Nested Configuration Maps:  

#### instance_profile_policy

Policy content to be add to the new policy (i.e. the policy for which arn is not defined) will be read from the JSON document.<br>
&nbsp;&nbsp;&nbsp;- JSON document must be placed in the directory `policies` under root directory.<br>
&nbsp;&nbsp;&nbsp;- The naming format of the file: <Value set in `name` property>.json

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="name"></a> [name](#input\_name) | Policy Name | `string` |  | yes |  |
| <a name="arn"></a> [arn](#input\_arn) | Policy ARN (if existing policy) | `string` |  | no |  |

#### mixed_instances_policy

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="override"></a> [override](#override\_block) | List of nested arguments provides the ability to specify multiple instance types. | `list(any)` |  | no |  |
| <a name="instances_distribution"></a> [instances_distribution](#instances\_distribution\_block) | Nested argument containing settings on how to mix on-demand and Spot instances in the Auto Scaling group | `map(any)` |  | no |  |

#### override_block

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="instance_type"></a> [instance_type](#input\_instance\_type) | Override the instance type in the Launch Template. | `string` |  | yes |  |
| <a name="weighted_capacity"></a> [weighted_capacity](#input\_weighted\_capacity) | Number of capacity units, which gives the instance type a proportional weight to other instance types. | `number` |  | no |  |

#### instances_distribution_block

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="on_demand_allocation_strategy"></a> [on_demand_allocation_strategy](#input\_on\_demand\_allocation\_strategy) | Strategy to use when launching on-demand instances. | `string` | `prioritized` | no |  |
| <a name="on_demand_base_capacity"></a> [on_demand_base_capacity](#input\_on\_demand\_base\_capacity) | Absolute minimum amount of desired capacity that must be fulfilled by on-demand instances. | `number` | `0` | no |  |
| <a name="on_demand_percentage_above_base_capacity"></a> [on_demand_percentage_above_base_capacity](#input\_on\_demand\_percentage\_above\_base\_capacity) | Percentage split between on-demand and Spot instances above the base on-demand capacity. | `number` | `100` | no |  |
| <a name="spot_allocation_strategy"></a> [spot_allocation_strategy](#input\_spot\_allocation\_strategy) | How to allocate capacity across the Spot pools. | `string` | `lowest-price` | no |  |
| <a name="spot_instance_pools"></a> [spot_instance_pools](#input\_spot\_instance\_pools) | Number of Spot pools per availability zone to allocate capacity. | `number` | `0` | no |  |
| <a name="spot_max_price"></a> [spot_max_price](#input\_spot\_max\_price) | Maximum price per unit hour that the user is willing to pay for the Spot instances. | `string` | `""` | no |  |

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

#### credit_specifcation

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="cpu_credits"></a> [cpu_credits](#input\_cpu\_credits) | The credit option for CPU usage. CPU Credits can be `standard` or `unlimited`. | `string` |  | yes |  |

#### elastic_gpu_specifications

| Name | Description | Type | Default | Required | Example|
|:------|:------|:------|:------|:------:|:------|
| <a name="gpu_type"></a> [gpu_type](#input\_gpu\_type) | The Elastic GPU Type | `string` |  | yes |  |

## Outputs

| Name | Type | Description |
|:------|:------|:------|
| <a name="arn"></a> [arn](#output\_arn) |  `string` | ARN of Auto Scaling Group |
| <a name="instance_profile_role_arn"></a> [instance_profile_role_arn](#output\_instance\_profile\_role\_arn) | `string` | ARN of IAM role provisioned for Instance Profile |
| <a name="instance_profile_arn"></a> [instance_profile_arn](#output\_instance\_profile\_arn) | `string` | ARN of IAM Instance Profile |
| <a name="launch_template"></a> [launch_template](#output\_launch\_template) | `map(string)` | Launch Template Details (`ID` and `ARN`) |

## Authors

Module is maintained by [Ankit Jain](https://github.com/ankit-jn) with help from [these professional](https://github.com/arjstack/terraform-aws-iam/graphs/contributors).

