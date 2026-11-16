output "cluster_name" { value = aws_eks_cluster.main.name }
output "region" { value = var.region }
output "ecr_products" { value = aws_ecr_repository.products.repository_url }
output "ecr_orders" { value = aws_ecr_repository.orders.repository_url }
output "vpc_id" { value = aws_vpc.main.id }