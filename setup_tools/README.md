# Setup Tools

ホスト側はこのディレクトリにあるファイルを利用して devenv の環境を構築します。

## 手順

### 1. コンテナの作成

```
$ docker pull kazukgw/devenv # devenv コンテナのベースイメージを pull
$ vim build_devenv_container.bash # build-arg の値を設定
...
$ bash build_devenv_container.bash # devenv コンテナを作成
```

### 2. ホスト側の準備

```
$ mkdir devenv # devenv 環境 (ホスト側と共有するディレクトリ) を作成

```
* build_devev_container.bash


