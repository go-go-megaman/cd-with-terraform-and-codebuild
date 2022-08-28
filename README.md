# cd-with-terraform-and-codebuild

## 前提条件

- terraform
    - 1.2.5
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
./terraform/bin/entrypoint.sh init
```
