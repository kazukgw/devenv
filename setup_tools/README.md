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
* `.devcontainer`: entrypoint ディレクトリに配置


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
