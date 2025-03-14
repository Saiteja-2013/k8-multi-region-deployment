output "us_west_2_cluster_endpoint" {
  value = aws_eks_cluster.us_west_2_cluster.endpoint
}

output "us_west_2_cluster_name" {
  value = aws_eks_cluster.us_west_2_cluster.name
}

output "us_east_1_cluster_endpoint" {
  value = aws_eks_cluster.us_east_1_cluster.endpoint
}

output "us_east_1_cluster_name" {
  value = aws_eks_cluster.us_east_1_cluster.name
}
