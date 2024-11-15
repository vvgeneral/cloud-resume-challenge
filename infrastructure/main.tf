data "aws_caller_identity" "current" {}

resource "aws_lambda_function" "vclambdaterraform" {
  filename         = data.archive_file.zip_the_python_code.output_path
  source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
  function_name    = "vclambdaterraform"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "func.lambda_handler"
  runtime          = "python3.10"
  environment {
    variables = {
      DYNAMODB_TABLE_NAME = aws_dynamodb_table.vcdbterraform.name
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_website" {
  name        = "aws_iam_policy_for_website"
  path        = "/"
  description = "AWS IAM Policy for Lambda"
    policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:*",
          "Effect" : "Allow"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:PutItem",
            "dynamodb:GetItem"
          ],
          "Resource" : "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/vcdbterraform"
        }
      ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.iam_policy_for_website.arn
  
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_file = "${path.module}/lambda/func.py"
  output_path = "${path.module}/lambda/func.zip"
}

resource "aws_apigatewayv2_api" "vcapiterraform" {
  name = "vcapiterraform"
  protocol_type = "HTTP"
  cors_configuration {
    allow_headers     = ["Content-Type"]
    allow_methods     = ["GET"]
    allow_origins     = ["*"] 
  }
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                = aws_apigatewayv2_api.vcapiterraform.id
  integration_type      = "AWS_PROXY"
  integration_uri       = aws_lambda_function.vclambdaterraform.invoke_arn
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "visitorcount_route" {
  api_id    = aws_apigatewayv2_api.vcapiterraform.id
  route_key = "GET /visitorcount"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.vcapiterraform.id
  name        = "$default"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_gateway_invoke_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.vclambdaterraform.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.vcapiterraform.execution_arn}/*/*/visitorcount"
}

resource "aws_dynamodb_table" "vcdbterraform" {
  name           = "vcdbterraform"
  billing_mode   = "PAY_PER_REQUEST" 
  hash_key       = "id"     

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "initial_item" {
  table_name = aws_dynamodb_table.vcdbterraform.name

  hash_key = "id"

  item = jsonencode({
    id    = { "S": "1" }
    views = { "N": "0" }
  })
}
