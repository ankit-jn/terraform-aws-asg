resource aws_autoscaling_group "this" {

    name = var.name
    min_size = var.min_size
    max_size = var.max_size
    vpc_zone_identifier = var.vpc_zone_identifier
    capacity_rebalance = var.capacity_rebalance
    protect_from_scale_in = var.protect_from_scale_in

    launch_template {
        name    = aws_launch_template.this.name
        version = aws_launch_template.this.latest_version
    }

    health_check_type = var.health_check_type
}


resource aws_launch_template "this" {
    name        = local.instance_template_name
    description = var.launch_template_description
    image_id    = var.image_id

    instance_type = var.instance_type
    user_data   = var.user_data

    
    dynamic "iam_instance_profile" {
        for_each = var.create_instance_profile ? [1] : []
        content {
            arn     = aws_iam_instance_profile.this[0].arn
        }
  }
}

# Instance profile - IAm Role
module "instance_profile_role" {
    source = "git::https://github.com/arjstack/terraform-aws-iam.git"
    
    count = var.create_instance_profile_role ? 1 : 0

    policies                = local.instance_profile_policies_to_create

    service_linked_roles    = local.instance_profile_roles

    role_default_tags       = merge(var.default_tags, var.instance_profile_tags)
    policy_default_tags     = merge(var.default_tags, var.instance_profile_tags)
}

resource aws_iam_instance_profile "this" {

  count = var.create_instance_profile ? 1 : 0

  role = var.create_instance_profile_role ? var.instance_profile_role_arn : module.instance_profile_role[0].service_linked_roles[var.instance_profile_name].arn

  name        = local.instance_profile_name
  path        = var.instance_profile_path

  tags = merge(var.default_tags, var.instance_profile_tags)
}
