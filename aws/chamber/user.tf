# Chamber user for CI/CD systems that cannot leverage IAM instance profiles
# https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-access.html
module "chamber_user" {
  source        = "git::https://github.com/cloudposse/terraform-aws-iam-chamber-user.git?ref=tags/0.1.4"
  namespace     = "${var.namespace}"
  stage         = "${var.stage}"
  name          = "chamber"
  attributes    = ["codefresh"]
  kms_key_arn   = "${module.chamber_kms_key.key_arn}"
  ssm_resources = ["${format("arn:aws:ssm:%s:%s:parameter/kops/*", var.region, var.account_id)}"]
}

output "chamber_user_name" {
  value       = "${module.chamber_user.user_name}"
  description = "Normalized IAM user name"
}

output "chamber_user_arn" {
  value       = "${module.chamber_user.user_arn}"
  description = "The ARN assigned by AWS for the user"
}

output "chamber_user_unique_id" {
  value       = "${module.chamber_user.user_unique_id}"
  description = "The user unique ID assigned by AWS"
}

output "chamber_access_key_id" {
  value       = "${module.chamber_user.access_key_id}"
  description = "The access key ID"
}

output "chamber_secret_access_key" {
  value       = "${module.chamber_user.secret_access_key}"
  description = "The secret access key. This will be written to the state file in plain-text"
}
