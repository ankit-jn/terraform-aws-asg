## Instance profile - IA<M Role
module "instance_profile_role" {
    source = "git::https://github.com/arjstack/terraform-aws-iam.git"
    
    count = var.create_instance_profile_role ? 1 : 0

    policies                = local.instance_profile_policies_to_create

    service_linked_roles    = local.instance_profile_roles

    role_default_tags       = merge(var.default_tags, var.instance_profile_tags)
    policy_default_tags     = merge(var.default_tags, var.instance_profile_tags)
}

## Instance profile
resource aws_iam_instance_profile "this" {

  count = var.create_instance_profile ? 1 : 0

  role = var.create_instance_profile_role ? format("%s-role", local.instance_profile_name) : var.instance_profile_role_name

  name        = local.instance_profile_name
  path        = var.instance_profile_path

  tags = merge(var.default_tags, var.instance_profile_tags)

  depends_on = [
    module.instance_profile_role
  ]
}
