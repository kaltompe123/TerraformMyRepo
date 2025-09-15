resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = "my-lambda-code-bucket-123453ff" # must be globally unique
}

resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_code_bucket.bucket
  key    = "lambda_function.zip"
  source = "lambda_function.zip"
  etag   = filemd5("lambda_function.zip")
}
#filemd5("lambda_function.zip") computes the MD5 checksum of the ZIP file.
#If the ZIP changes, the checksum changes → Terraform will detect drift and re-upload to S3.
#Without etag, Terraform may not notice when you update the file.



resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
    
  role = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "MyCustom_lamda_terraform" {
  function_name = "MyCustom_lamda_terraform"
  runtime = "python3.13"
  handler = "lambda_function.lambda_handler"
  role = aws_iam_role.lambda_role.arn
  timeout = 900
  memory_size = 128
  s3_bucket = aws_s3_bucket.lambda_code_bucket.bucket
  s3_key = aws_s3_object.lambda_code.key
  #filename = "lambda_function.zip"
  #source_code_hash = filebase64sha256("lambda_function.zip")

  #Without source_code_hash, Terraform might not detect when the code in the ZIP file has changed — meaning your Lambda might not update even after uploading a new ZIP.
  #This hash is a checksum that triggers a deployment.
}



