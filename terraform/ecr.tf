resource "aws_ecr_repository" "products" {
  name = "${var.project}-products"
  image_scanning_configuration { scan_on_push = true }
  force_delete = true
}
resource "aws_ecr_repository" "orders" {
  name = "${var.project}-orders"
  image_scanning_configuration { scan_on_push = true }
  force_delete = true
}