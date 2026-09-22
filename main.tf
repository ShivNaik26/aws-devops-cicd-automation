data "aws_vpc" "our_vpc" {
  id = "vpc-0064246ceed4e78bb"
}

data "aws_subnets" "our_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.our_vpc.id]
  }

  filter {
    name   = "subnet-id"
    values = [
      "subnet-0ce545a00b871d0f6",
      "subnet-02385d62800e2e7b0"
    ]
  }
}

resource "aws_eks_cluster" "main" {
  name     = "aws-devops-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.our_public_subnets.ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller
  ]
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "aws-devops-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = data.aws_subnets.our_public_subnets.ids

  instance_types = ["t3.micro"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ec2_container_registry_read_only
  ]
}
