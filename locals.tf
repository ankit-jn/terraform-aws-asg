locals {
    instance_template_name = coalesce(var.launch_template_name, format("%s-template", var.name))
    instance_profile_name = coalesce(var.instance_profile_name, format("%s-instance-profile", var.name))

    instance_profile_policies_to_create = [for policy in var.instance_profile_policies: policy if (lookup(policy, "arn", "") == "")  ]
    
    instance_profile_roles = [
                        {
                            name = local.instance_profile_name
                            description = "IAM Role for ECS Container Agent running on EC2 instances with trusted Entity - EC2 Service"
                            service_names = [
                                "ec2.amazonaws.com"
                            ] 
                            policy_list = var.instance_profile_policies
                        }
    ]
}