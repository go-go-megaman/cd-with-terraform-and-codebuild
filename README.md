# cd-with-terraform-and-codebuild

## 前提条件

- terraform
    - バージョンは[terraformディレクトリ配下のREADME.md](./terraform/README.md)を参照すること
- tflint
    - 0.41.0
- tfsec
    - 1.28.1
- AWS CLI
    - 2.7.16以上

### Windows環境の場合

- WSL
    - ディストリービューションは`Ubuntu`を使用すること

## Sandboxの初回構築

- ワークスペース名の設定を行う。
- デフォルトではユーザー名がワークスペース名として扱われる。

```shell
export TERRAFORM_WORKSPACE={TYPE_YOUR_OWN_WORKSPACE_NAME}
```

- Terraformのバックエンドに必要なリソースの作成と初期化処理を行う。

```shell
cd terraform
../runner/entrypoint.sh prepare-backend
../runner/entrypoint.sh prepare-workspace
../runner/entrypoint.sh init
```

- `plan`にて作成されるリソースを確認した後、`apply`を実行する。

```shell
terraform plan -var-file=sandbox.tfvars
terraform apply -var-file=sandbox.tfvars
```

## Production、もしくはStagingの初回構築

- Sandboxの作成と実行するコマンドは変わらない。
- プレースホルダーへ`production`、もしくは`staging`を入力した後、コマンドを実行する。

```shell
export TERRAFORM_WORKSPACE={TYPE_WORKSPACE_NAME}
cd terraform
../runner/entrypoint.sh prepare-backend
../runner/entrypoint.sh prepare-workspace
../runner/entrypoint.sh init
terraform plan -var-file={TYPE_WORKSPACE_NAME}.tfvars
terraform apply -var-file={TYPE_WORKSPACE_NAME}.tfvars
```

## CodeBuildプロジェクト

### Webhookによる起動

- 対応するGitブランチがリモートリポジトリへPushされることにより、CodeBuildプロジェクトが起動する。

| ブランチ    | 環境                   | 実行されるコマンド       |
|---------|----------------------|-----------------|
| develop | Staging              | terraform apply |
| feature | Staging              | terraform plan  |
| main    | Production           | terraform apply |
| release | Production / Staging | terraform plan  |
| hotfix  | Production / Staging | terraform plan  |

### AWS CLIによる起動方法

- コンソール、もしくはAWS CLIから作成したCodeBuildプロジェクトを起動することができる。

```shell
# terraform planを実行するCodeBuildプロジェクト
aws codebuild start-build --project-name planning-terraform-on-{TYPE_YOUR_OWN_WORKSPACE_NAME}

# terraform applyを実行するCodeBuildプロジェクト
aws codebuild start-build --project-name applying-terraform-on-{TYPE_YOUR_OWN_WORKSPACE_NAME}
```

## 静的コード解析の実行

- terraformディレクトリにて次のコマンドを実行する。

```shell
cd terraform
../runner/entrypoint.sh init
```

- リポジトリのルートへ移動した後、静的コード解析を行うコマンドを実行する。

```shell
cd ..
make run-all-checks
```
