resource "aws_iam_role" "task_execution_role" {
  name = var.ecs_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = var.actions

    principals {
      type        = var.principals_type
      identifiers = var.identifiers
    }
  }
}

resource "aws_iam_role_policy_attachment" "my_aws_iam_policy_attachment" {
  role      = aws_iam_role.task_execution_role.name
  policy_arn = var.policy_arn
}
