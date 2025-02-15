resource "aws_ecr_repository" "my_aws_ecr_respository" {
  name                 = "goals-repo"
  image_tag_mutability = "MUTABLE"
  force_delete = true
}