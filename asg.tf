resource aws_autoscaling_group "this" {

    name = var.name

    min_size = var.min_size
    max_size = var.max_size
    desired_capacity = var.desired_capacity
    capacity_rebalance = var.capacity_rebalance
    
    vpc_zone_identifier = var.vpc_zone_identifier
    placement_group = var.placement_group
    
    service_linked_role_arn = var.service_linked_role_arn
    
    suspended_processes   = var.suspended_processes
    termination_policies  = var.termination_policies
    force_delete = var.force_delete

    default_cooldown =  var.default_cooldown
    default_instance_warmup = var.default_instance_warmup
    protect_from_scale_in = var.protect_from_scale_in
    max_instance_lifetime = var.max_instance_lifetime
    
    target_group_arns         = var.target_group_arns
    health_check_type         = var.health_check_type
    health_check_grace_period = var.health_check_grace_period
    min_elb_capacity          = var.min_elb_capacity
    wait_for_elb_capacity     = var.wait_for_elb_capacity
    wait_for_capacity_timeout = var.wait_for_capacity_timeout

    enabled_metrics         = var.enabled_metrics
    metrics_granularity     = var.metrics_granularity
    
    dynamic "launch_template" {
        for_each = var.use_mixed_instances_policy ? [] : [1]

        content {
            name    = aws_launch_template.this.name
            version = aws_launch_template.this.latest_version
        }
    }

     dynamic "mixed_instances_policy" {
        for_each = var.use_mixed_instances_policy ? [1] : [0]

        content {

            launch_template {
                
                launch_template_specification {
                    launch_template_name    = aws_launch_template.this.name
                    version = aws_launch_template.this.latest_version
                }
                
                dynamic "override" {
                    for_each = lookup(var.mixed_instances_policy, "override", [])

                    content {
                        instance_type     = try(override.value.instance_type, null)
                        weighted_capacity = try(override.value.weighted_capacity, null)
                    }

                }
            }

            dynamic "instances_distribution" {
                for_each = length(keys(lookup(var.mixed_instances_policy, "instances_distribution", {}))) > 0 ? [1] : []

                content {
                    on_demand_allocation_strategy            = lookup(var.mixed_instances_policy.instances_distribution, "on_demand_allocation_strategy", "prioritized")
                    on_demand_base_capacity                  = lookup(var.mixed_instances_policy.instances_distribution, "on_demand_base_capacity", 0)
                    on_demand_percentage_above_base_capacity = lookup(var.mixed_instances_policy.instances_distribution, "on_demand_percentage_above_base_capacity", 100)
                    spot_allocation_strategy                 = lookup(var.mixed_instances_policy.instances_distribution, "spot_allocation_strategy", "lowest-price")
                    spot_instance_pools                      = lookup(var.mixed_instances_policy.instances_distribution, "spot_instance_pools", 0)
                    spot_max_price                           = lookup(var.mixed_instances_policy.instances_distribution, "spot_max_price", "")
                }
            }

        }
     }

    dynamic "tag" {
        for_each = merge(var.default_tags, var.asg_tags)

        content {
            key                 = tag.key
            value               = tag.value
            propagate_at_launch = true
        }
    }

}