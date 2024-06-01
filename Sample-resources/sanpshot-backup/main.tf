# Automated snapshot management

# Automate the process of creating snapshots for EC2 volumes in AWS to ensure data durability and quick recovery incase of failure

/*
#Created resources

aws_ebs_volume
aws_ebs_snapshot
aws_lambda_function
aws_cloudwatch_event_rule
aws_cloudwatch_event_target
*/

resource "aws_ebs_volume" "example_ebs" {
  availability_zone = "us-east-1"
  size              = 50
  tags = {
    Name = "MyVolume"
  }
}

resource "aws_ebs_snapshot" "sample_snapshot" {
  volume_id = aws_ebs_volume.example_ebs.id

  tags = {
    Name = "MySnapshot"
  }
}

resource "aws_lambda_function" "snapshot_scheduler" {
  filename         = "snapshot_scheduler.zip"
  function_name    = "snapshotScheduler"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "exports.handler"
  source_code_hash = filebase64sha256("snapshot_scheduler.zip")
  runtime          = "nodejs12.x"

  environment {
    variables = {
      VOLUME_ID = aws_ebs_volume.example_ebs.id
    }
  }
}

resource "aws_cloudwatch_event_rule" "snapshot_rule" {
  schedule_expression = "cron(0 20 * * ? *)"
}

resource "aws_cloudwatch_event_target" "snapshot_target" {
  rule      = aws_cloudwatch_event_rule.snapshot_rule.name
  target_id = "SnapshotLambda"
  arn       = aws_lambda_function.snapshot_scheduler.arn
}