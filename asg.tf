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
    
    launch_template {
        name    = aws_launch_template.this.name
        version = aws_launch_template.this.latest_version
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