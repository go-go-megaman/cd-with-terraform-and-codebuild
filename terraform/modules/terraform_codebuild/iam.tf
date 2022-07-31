data "aws_iam_policy_document" "code_build" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role" "code_build" {
  assume_role_policy = data.aws_iam_policy_document.code_build.json
}

data "aws_iam_policy_document" "iam_editor" {
  statement {
    actions = [
      "iam:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "iam_editor" {
  policy = data.aws_iam_policy_document.iam_editor.json
}

resource "aws_iam_role_policy_attachment" "attaching_iam_editor_to_code_build" {
  policy_arn = aws_iam_policy.iam_editor.arn
  role       = aws_iam_role.code_build.id
}

resource "aws_iam_role_policy_attachment" "attaching_power_user_to_code_build" {
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
  role       = aws_iam_role.code_build.id
}
