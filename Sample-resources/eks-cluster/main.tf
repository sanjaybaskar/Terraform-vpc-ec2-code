# EKS Cluster setup

module "EKS" {
  source = "terraform-aws-modules/eks/aws"
    version = "17.24.0"

    cluster_name = "sample_cluster"
    cluster_version = "1.27"
    subnets = ["subnets-123","subnets-1234"]
    vpc_id = "vpc-123"
}