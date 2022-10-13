locals {
    instance_template_name = coalesce(var.launch_template_name, format("%s-template", var.name))
    instance_profile_name = coalesce(var.instance_profile_name, format("%s-instance-profile", var.name))

    instance_policy_names = [for policy in var.instance_policies: policy.name]
    instance_roles = [
                        {
                            name = local.instance_profile_name
                            description = "IAM Role for ECS Container Agent running on EC2 instances with trusted Entity - EC2 Service"
                            service_names = [
                                "ec2.amazonaws.com"
                            ]  
                            policy_map = {
                                policy_arns = local.instance_policy_names
                            }                   
                        }
    ]
}