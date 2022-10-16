#!/usr/bin/env sh
set -eu

DEBUG=${DEBUG:-false}
TERRAFORM_WORKSPACE=${TERRAFORM_WORKSPACE:-$(whoami)}
TERRAFORM_SHOULD_APPLY=${TERRAFORM_SHOULD_APPLY:-false}

current_dir=$(cd "$(dirname "$0")";pwd)
terraform_dir="$(pwd)"

if "$DEBUG"; then
  set -x
fi

fetch_backend_bucket_name() {
  (
    aws_account_id=$(aws sts get-caller-identity --query "Account" --output text)
    echo "terraform-state-bucket-in-$aws_account_id"
  )
}

make_bucket() {
  (
    s3_bucket_name=$(fetch_backend_bucket_name)
    if aws s3api head-bucket --bucket "$s3_bucket_name" >/dev/null 2>&1; then
      echo "S3 Bucket '$s3_bucket_name' already exists."
      return
    fi

    echo "S3 Bucket '$s3_bucket_name' does not exist."
    aws s3 mb "s3://$s3_bucket_name"
    aws s3api put-public-access-block \
      --bucket "$s3_bucket_name" \
      --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true"
    aws s3api put-bucket-versioning \
      --bucket "$s3_bucket_name" \
      --versioning-configuration Status=Enabled
    aws s3api put-bucket-lifecycle-configuration \
      --bucket "$s3_bucket_name" \
      --lifecycle-configuration "file://$current_dir/archive_rule.json"
  )
}

create_table() {
  (
    table_name="terraform-state-locking"
    if aws dynamodb describe-table --table-name "$table_name" >/dev/null 2>&1; then
      echo "Dynamo DB table '$table_name' already exists."
      return
    fi

    echo "Dynamo DB table '$table_name' does not exist."
    aws dynamodb create-table --table-name "$table_name" \
      --attribute-definitions '[{"AttributeName":"LockID","AttributeType": "S"}]' \
      --key-schema '[{"AttributeName":"LockID","KeyType": "HASH"}]' \
      --billing-mode PAY_PER_REQUEST >/dev/null
  )
}

terraform_wrapper() {
  terraform -chdir="$terraform_dir" "$@" -no-color
}

fetch_tfvars_file_name() {
  if [ "$TERRAFORM_WORKSPACE" != "production" ] && [ "$TERRAFORM_WORKSPACE" != "staging" ]; then
    echo "sandbox.tfvars"
    return
  fi
  echo "$TERRAFORM_WORKSPACE.tfvars"
}

terraform_with_tfvars() {
  terraform_wrapper "$@" -var-file="$(fetch_tfvars_file_name)"
}

new_terraform_workspace() {
  if terraform_wrapper workspace list 2>&1 | grep "$TERRAFORM_WORKSPACE" >/dev/null; then
    echo "Terraform Workspace '$TERRAFORM_WORKSPACE' already exists."
    return
  fi
  echo "Terraform Workspace '$TERRAFORM_WORKSPACE' does not exist."
  terraform_wrapper workspace new "$TERRAFORM_WORKSPACE"
}

init() {
  make_bucket
  create_table

  rm -Rf "$terraform_dir"/.terraform
  terraform_wrapper init -backend-config="bucket=$(fetch_backend_bucket_name)"
  new_terraform_workspace
  terraform_wrapper workspace select "$TERRAFORM_WORKSPACE"
}

run() {
  init
  (
    lock_timeout_seconds="3600s"
    if $TERRAFORM_SHOULD_APPLY; then
      terraform_with_tfvars apply -lock-timeout=$lock_timeout_seconds -auto-approve
    fi
    terraform_with_tfvars plan -lock-timeout=$lock_timeout_seconds
  )
}

run_tflint() {
  (
    tflint --no-color --init
    tflint_temp_path="${terraform_dir}/temp.txt"

    find . -type f -name '*.tf' -not -path "./.terraform/*" -print0 |
      xargs -0 dirname |
      sort -u |
      while read -r dir
      do
        echo "==========================================================================================="
        echo "tflint is checking $dir"
        tflint --no-color --force "$dir" | tee -a "$tflint_temp_path"
      done

      rm "$tflint_temp_path"
      if [ -s "${tflint_temp_path}" ]; then
        exit 1
      fi
  )
}

main() {
  if [ "$#" = 0 ]; then
    echo "Please specify any command."
    exit 1
  elif [ "$1" = "init" ]; then
    init
  elif [ "$1" = "run" ]; then
    run
  elif [ "$1" = "check-format" ]; then
    terraform_wrapper fmt -check -recursive -diff
  elif [ "$1" = "validate" ]; then
    terraform_wrapper validate
  elif [ "$1" = "run-tflint" ]; then
    run_tflint
  else
    echo "Please specify correct command."
    exit 1
  fi
}

main "$@"
