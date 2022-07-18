# cd-with-terraform-and-codebuild

## 前提条件

- terraform
  - 1.2.5
- AWS CLI
  - 2.7.16以上

### Windows環境の場合

- WSL
  - ディストリービューションは`Ubuntu`を使用すること

## 初回構築

- ワークスペース名の設定を行う。
- デフォルトではユーザー名がワークスペース名として扱われる。

```shell
export TERRAFORM_WORKSPACE={TYPE_YOUR_OWN_WORKSPACE_NAME}
```

- Terraformのバックエンドに必要なリソースの作成と初期化処理を行う。

```shell
./terraform/bin/entrypoint.sh init
```

- `plan`にて作成されるリソースを確認した後、`apply`を実行する。

```shell
cd terraform
terraform plan
terraform apply
```

## CodeBuildプロジェクトの起動

- コンソール、もしくはAWS CLIから作成したCodeBuildプロジェクトを起動することができる。

```shell
# terraform planを実行するCodeBuildプロジェクト
aws codebuild start-build --project-name planning-terraform-on-{TYPE_YOUR_OWN_WORKSPACE_NAME}

# terraform applyを実行するCodeBuildプロジェクト
aws codebuild start-build --project-name applying-terraform-on-{TYPE_YOUR_OWN_WORKSPACE_NAME}
```
