# devenv

## Objectives

* CLIのツールやGoやPythonなどを利用した開発環境を Docker によって Containerize することによってポータビリティを向上
* Docker (あるいは Docker for Mac) の機能によってホスト側とファイルシステムをシェアすることで柔軟な作業環境を実現

## Overview

TODO

## Build base image

```
$ make
```

## Setup devenv

```
# devenv を git clone
$ mkdir devenv # (もしくは任意の名前) で devenv 環境 (ホスト側と共有するディレクトリ) を作成
$ cd devenv
$ git clone git@github.com:kazukgw/devenv.git

# コンテナの作成
$ cp devenv/setup_tools/Dockerfile ./
$ vim Dockerfile # 必要があればカスタマイズ
$ vim .dockerignore  # 必要があれば作成
$ docker pull kazukgw/devenv # devenv コンテナのベースイメージを pull
$ vim build_devenv_container.bash # build-arg の値を設定
...
$ bash build_devenv_container.bash # devenv コンテナを作成

# docker-compose.yaml に環境変数や Port の設定などを記述
$ cp devenv/setup_tools/docker-compose.yaml ./
$ vim docker-compose.yaml # 各種パラメータを設定

# その他の準備 1
$ mkdir src
$ mkdir pkg
$ mkdir bin
$ mkdir tmp

# その他の準備 2
$ cp devenv/setup_tools/docker-config.json ~/
$ cp devenv/setup_tools/run_devenv.bash ~/ # devenv 環境を terminal で直接起動するためのスクリプト
```
