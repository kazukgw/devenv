# devenv

## Objectives

* CLIのツールやGoやPythonなどを利用した開発環境を Docker によって Containerize することによってポータビリティを向上
* Docker (あるいは Docker for Mac) の機能によってホスト側とファイルシステムをシェアすることで柔軟な作業環境を実現
* vscode の `Remote - Containers` Extension によって、リッチな UI によるコーディング環境を実現

## Overview

TODO

## Build base image

```
$ make build_base
# あるいは 当リポジトリの master に push すれば dockerhub で build される
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

# entrypoint ディレクトリ(後述) を作成
$ mkdir entrypoint
$ cp -r devenv/setup_tools/.devcontainer entrypoint/
$ vim entrypoint/.devcontainer/devcontainer.json

# その他の準備 1
$ mkdir src
$ mkdir pkg
$ mkdir bin
$ mkdir tmp
$ mkdir .vscode-server # 必要あれば
... # そのほか 自分の好みでカスタマイズ

# その他の準備 2
$ cp devenv/setup_tools/docker-config.json ~/
$ cp devenv/setup_tools/run_devenv.bash ~/ # devenv 環境を terminal で直接起動するためのスクリプト
```

## 使い方

vscode の `Remote - Contaienrs` で Open Folder in Contaienr で entrypoint フォルダを開く

## 補足

### entrypoint ディレクトリ

editor としては vscode のほうがリッチで良いが、複数のフォルダを自由に探索しながら作業するには terminal + vim のほうが向いている。

両方のいいとこ取りをしたいが vscode と terminal を使い分けるのは面倒なので、できれば terminal での作業と editor の行き来は vscode だけで行えるようにしたい。

これは macOS だけで実現するなら簡単そうだが、devenv(本リポジトリ) のような汎用開発環境と macOSの組み合わせで実現するには `Remote - Containers` を使う必要があるので、

と考えて、 `Remote - Containers` の `devcontainer.json` の設定として `workspace: devenv フォルダ` としてみたが、 vscode は Folder Open 時にフォルダ配下のファイルの解析を始めるので、あまりファイル数が多いディレクトリを指定することができない(大量のファイルの解析を始めてしまう)。

いろいろ試しているうちに、vscode の terminal 上(devenv container 内)で `code` コマンド(vscode の cli インターフェース) を用いて、 `code .` などすればそのディレクトリをホスト側の vscode で新たな window として開いてくれることがわかった。

これを利用して以下のような手順で作業するようにすれば、vscode だけで bash, editor 両方の作業を完結できる。

* devenv folder の直下に entrypoint というディレクトリを作成する
* このディレクトリに `.devcontainer/devcontainer.json` 用意しておき、devenv コンテナの docker-compose.yaml を利用するような設定をしておく
* 作業開始時にはまず entrypoint を workspace として devenv コンテナを起動する
* entrypoint を workspace としたディレクトリでは terminal の画面を最大化しておいて、基本的なな Terminal での作業はこの window で行う。
* Editorで作業したいディレクトリがあれば entrypoint Window の Terminal で `code <directory>` として新たに vscode の window を開く。
