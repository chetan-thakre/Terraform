# this is for creating an IAM user, IAM user policy and attach it to the the user created in this configuration file 


# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}

resource "aws_iam_user" "tarun" {
  name = "tarun"

  tags = {
    Name = "terraform"
  }
}


resource "aws_iam_policy" "allow-ec2" {
  name        = "allow-ec2"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Resource": "*",
            "Effect": "Allow",
            "Condition": {
                "StringEquals": {
                    "ec2:Region": "us-west-1"
                }
            }
        }
    ]
})
}


resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = "tarun"
  policy_arn = "arn:aws:iam::047437344617:policy/allow-ec2"
}
