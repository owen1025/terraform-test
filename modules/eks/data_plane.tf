
data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = var.worker_ami_name_filter
  }

  most_recent = true
  owners      = var.worker_ami_owners
}

resource "aws_launch_configuration" "eks_worker" {
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.eks_worker.name
  image_id                    = data.aws_ami.eks_worker.id
  instance_type               = var.instance_type
  name_prefix                 = "${local.worker_name}-"
  security_groups             = [module.eks_worker_sg.this_security_group_id]
  user_data_base64            = base64encode(local.worker_userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_worker" {
  desired_capacity     = var.desired_capacity
  launch_configuration = aws_launch_configuration.eks_worker.id
  max_size             = var.worker_max_size
  min_size             = var.worker_min_size
  name                 = var.cluster_name
  vpc_zone_identifier  = var.private_subnets

  tag {
    key                 = "Name"
    value               = local.worker_name
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  # Cluster autoscaler required tag
  tag {
    key                 = "k8s.io/cluster-autoscaler/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }

  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = true
    propagate_at_launch = true
  }
}
