CommandCheetSheet
==============================

awkの例集 {{{
-------------------

```
標準入力をそのまま標準出力に出力する。
$ cat foo.txt | awk '{print $0}'
標準入力をそのまま標準出力に出力する。
$ cat foo.txt | awk '1'
空行を削除する。
$ awk '/./' foo.txt
空行を削除する。
$ awk 'NF' foo.txt
最初の 10 行を表示する。
$ awk 'NF >= 10' foo.txt
一行ごとに改行を追加する。
$ awk '1;{print ""}' foo.txt
一行ごとに改行を追加する。
awk 'BEGIN{ORS="\n\n"};1' foo.txt
ファイルに行番号を付ける。
$ awk '$0 = NR OFS $0' foo.txt
ファイルに行番号を付ける。
$ awk '{print NR "\t" $0}' foo.txt
ファイル毎に行番号を付ける。
$ awk '{prin FNR "\t" $0}' foo*.txt
行番号を 4 桁で表示させる。
$ awk '{printf("%4d : %s\n", NR, $0)}' foo.txt
最も長い行の長さを表示する。
$ awk '{if (length($0) > max) max = length($0)} END {print max}' foo.txt
80 文字を越える行を表示する。
$ awk 'length($0) > 80' foo.txt
0 から 100 までの間の乱数を 5 つ表示する。
$ awk 'BEGIN {for (i = 1; i <= 7; i++) print int(101 * rand())}'
ファイルの行数を数える。
$ awk 'END {print NR}' foo.txt
奇数行を表示する。
$ awk 'NR % 2 == 1' foo.txt
偶数行を表示する。
$ awk 'NR % 2 == 0' foo.txt
最初の 1 行を表示する。
$ awk 'NR == 1' foo.txt
最初の 1 行を表示する。
$ awk '{print; exit}' foo.txt
最後の 1 行を表示する。
$ awk 'END {print}' foo.txt
最後の 1 行を表示する。
$ awk '{last = $0} END {print last}' foo.txt
同一行の削除を行う。(uniq)
$ awk 'a !~ $0; {a = $0}' foo.txt
同一行の削除を行う。(uniq)
$ awk '{if ($0 != line || NR == 1) print; line = $0}' foo.txt
行のソートを行う。(gawk 以上)
$ gawk '{line[NR] = $0} END {asort(line); for (i = 1; i <= length(line); i++) print line[i]}' foo.txt
10 行目から 20 行目までを表示する。
$ awk 'NR == 10, NR == 20 {print $0}' foo.txt
1 から 10 までの数字を生成する。
$ awk 'BEGIN {for (i == 1; i <= 10; i++) print i}'
'#' で始まるコメントを削除する。
$ awk '{sub(/#.*/, "", $0)}1' foo.txt
さいころを作る。
$ awk 'BEGIN {srand();print int(rand() * 6 + 1)}'
ワード数をカウントする。
$ awk '{n += NF} END {print n}' foo.txt
文字数をカウントする。
$ awk '{n += length($0)} END {print n}' foo.txt
Load Average を表示する。(Linux のみ)
$ awk '{print $1}' /proc/loadavg
yes コマンドを作る。(延々と 'y' を返す)
$ awk 'BEGIN {for (;;) print "y"}'
yes コマンドを作る。(延々と 'y' を返す)
$ awk 'BEGIN {while (awk != "Perl") print "y"}'
Apache のログにある IP アドレスからホスト名をリアルタイムで引く。(root のみ)
# tail -f /var/log/httpd/access_log | gawk '{system ("dig -x" $1 " +short")}'
Apache のログからリンク元をリアルタイムで表示する。(root のみ)
# tail -f /var/log/httpd/access_log | gawk -F\" '$4!~/gauc/&&$4!="-"{fflush();print $4}'
CSV (カンマ区切り) から TSV (タブ区切り) への変換を行う。
$ awk -v FS=',' -v OFS='\t' '$1=$1' foo.txt
TSV (タブ区切り) から CSV (カンマ区切り) への変換を行う。
$ awk -v OFS=',' -v FS='\t' '$1=$1' foo.txt
各フィールドの和を求める。
$ awk '{for (i = 1; i <= NF; i++) s += $i} $0=s' foo.txt
各行のフィールド数を表示する。
$ awk '{print NF ":" $0}' foo.txt
最後の行のフィールド数を表示する。
$ awk '{s = NF} END {print NF}' foo.txt
フィールドが 5 以上の行を表示する。
$ awk 'NF >= 5' foo.txt
改行 CR/LF を LF に変換する。
$ awk 'sub(/\r$/,"")' foo.txt
改行 LF を CR/LF に変換する。
$ awk 'sub(/$/,"\r")' foo.txt
行頭の空白とタブを削除する。
$ awk '{sub(/^[ \t ]+/, "")}1' foo.txt
行末の空白とタブを削除する。
$ awk '{sub(/[ \t ]+$/, "")}1' foo.txt
行頭と行末の空白とタブを削除する。
$ awk '{gsub(/^[ \t ]+|[ \t ]+$/, "")}1' foo.txt
行頭と行末の空白とタブを削除する。(フィールドも再構成される)
$ awk '$1 = $1' foo.txt
最後の行から表示する。(tac)
$ '{a[i++] = $0} END {for (j = i - 1; j >= 0;) print a[j--]}' foo.txt
正規表現 abc の行を表示する。(grep)
$ awk '/abc/' foo.txt
正規表現 abc にマッチしない行を表示する。(grep -v)
$ awk '! /abc/' foo.txt
Pattern にマッチした前の行を表示する。
$ awk '/Pattern/ {print a} {a=$0}' foo.txt
Pattern にマッチした前の行を表示する。
$ awk '{D[NR] = $0} /match/ {print D[NR-1]}' foo.txt
ファイルサイズが 0 byte のものを表示する。
$ ls -al | awk '$5==0 {print $8}'
Subversion の svn status で '?' の付くファイルを全て svn add する。
$ svn status | gawk '/^?/{print $2}' | xargs svn add
```

}}}

/etc/fstab とは {{{
--------------
- 自動でディスクをマウントする設定ファイル

以下のような記述がされていたりする

```
/dev/hda4               /                  ext3    defaults        1 1

/dev/hda1               /boot              ext3    defaults        1 2

/dev/cdrom              /mnt/cdrom         iso9660 noauto,owner,ro 0 0

/dev/fd0                /mnt/floppy        auto    noauto,owner    0 0

/dev/hda2               /var               ext3    defaults        1 3

/dev/hda3               swap               swap    defaults        0 0
```


- 1列目・・・デバイス名
- 2列目・・・マウントポイント
- 3列目・・・ファイルシステム
- 4列目・・・マウント時のオプション
- 5列目・・・ファイルシステムをdumpする必要があるか否かの指定

「0」または無記述の場合はdump不要のファイルシステム
であると見なされる。

- 6列目・・・システム起動時にfsckチェックを行うか否かの指定

「0」の場合はチェックを行わない。ルートファイルシステム
でチェックを行う場合は「1」を指定する。
ルートファイルシステム以外でチェックを行う場合は「2」
を指定する。

}}}

awkで重複行の削除 {{{
------------
```
awk '!a[$0]++' FILE
```

- a は連想配列の変数で名前は何でもいいです
- $0 には行全体が格納されています
- つまり各行をキーとする連想配列を作成し、同じ行が現れるたびに値をインクリメントします
- ! により値が 0 のとき、つまり最初にその行が現れたときだけ条件が真になります
- アクション部分は省略されているので行全体が表示されます
}}}

OSX 起動中のアプリ一覧 {{{
------------
```
ps aux | grep -v grep | grep Applications | grep -o -e 'MacOS\/.*' | awk '{print $1}' | sed -e 's/MacOS\///'
```
}}}

findをつかってのファイル削除 {{{
------------

```
find . -name .svn -exec rm -rf {} \;
```
}}}

xargsを使う {{{
------------
```
find. -name "*~" | xargs rm
```
}}}

.txt の拡張子のファイルを .csv に変更する {{{
------------

```
for f in *.txt; do
mv $f ${f/.txt/.csv}
done
```
}}}

拡張子一括変更その2 {{{
------------

```
# . 区切りかつ . がひとつしかない場合のみつかえる
ls targetDir | awk -F "." '{print $1}' | xargs -I% mv %.txt %.csv
```
awk の print $NF は最後のフィールドを表示

}}}

画像サイズの一括変更 {{{
------------
image magick をつかっている
```
for f in *.jpg; do
convert -resize 33% $f ${f/.jpg/-33per.jpg}
done
```
}}}

各ディレクトリの利用容量を一覧表示する {{{
------------

```
sudo find /home -mindepth 1 -maxdepth 1 -type d -exec du -hs {} \;
```

}}}

文字列を一括置換 {{{
------------

```
sed -e "s/\(charset=\)EUC=JP/\1UTF-8/i" -i *.html
```
}}}

ユーザのログイン状態を表示する {{{
------------

```
w
```
}}}

デバイスを利用している ユーザ or プロセスをしらべる {{{
------------

```
lsof
```
}}}

telnet {{{
------------

ホストとポート指定で 対話的に通信できる

```
telnet <host> <port>
```
}}}

yum repo を追加する {{{
------------

### centos 6 の場合

```
$ wget http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
$ rpm -ivh epel-release-6-8.noarch.rpm
```
}}}

centos7 での 準備手順 {{{
------------------

### パッケージの更新

yum update


### ロケールとキーマップの変更

システムロケールの確認

```
$ localectl status
   System Locale: LANG=en_US.UTF-8
       VC Keymap: us
      X11 Layout: us
```


設定可能なロケールの確認

```
$ localectl list-locales
aa_DJ
aa_DJ.iso88591
aa_DJ.utf8
[...]
ja_JP.eucjp
ja_JP.ujis
ja_JP.utf8
[...]
```

ロケールの設定を変更します

```
$ sudo localectl set-locale LANG=ja_JP.utf8
```

設定可能なキーマップを確認

```
$ localectl list-keymaps
ANSI-dvorak
amiga-de
amiga-us
applkey
[...]
jp-dvorak
jp-kana86
jp106
[...]
```

キーマップの設定ファイルを変更します。ここではjp106に変更しました。

```
$ sudo localectl set-keymap jp106
```

### タイムゾーンの変更


タイムゾーンは、timedatectlコマンドで設定します。まず、現在設定されている値を確認します。

```
$ timedatectl status
      Local time: 水 2015-07-08 10:32:26 UTC
  Universal time: 水 2015-07-08 10:32:26 UTC
        Timezone: UTC (UTC, +0000)
     NTP enabled: yes
NTP synchronized: yes
 RTC in local TZ: no
      DST active: n/a
```

次に、設定可能なタイムゾーンを確認します。

```
$ timedatectl list-timezones
Africa/Abidjan
Africa/Accra
Africa/Addis_Ababa
[...]
Asia/Tokyo
[...]
```

設定を変更

```
$ sudo timedatectl set-timezone Asia/Tokyo
```

設定を確認

```
$ timedatectl status
      Local time: 水 2015-07-08 19:34:23 JST
  Universal time: 水 2015-07-08 10:34:23 UTC
        Timezone: Asia/Tokyo (JST, +0900)
     NTP enabled: yes
NTP synchronized: yes
 RTC in local TZ: no
      DST active: n/a
```


### 不要なサービスの停止

設定を確認

```
$ systemctl list-unit-files --type service | grep enabled
auditd.service                         enabled
chronyd.service                        enabled
cloud-config.service                   enabled
[...]
```

postfix を停止するとして、 postfixの設定を確認

```
$ systemctl status postfix.service
postfix.service - Postfix Mail Transport Agent
   Loaded: loaded (/usr/lib/systemd/system/postfix.service; enabled)
   Active: active (running) since 水 2015-07-08 15:31:08 JST; 4h 7min ago
 Main PID: 924 (master)
   CGroup: /system.slice/postfix.service
           ├─  924 /usr/libexec/postfix/master -w
           ├─  926 qmgr -l -t unix -u
           └─19126 pickup -l -t unix -u
```

対象のサービスを停止し、起動設定を無効化する。

```
$ sudo systemctl stop postfix.service
$ sudo systemctl disable postfix.service
rm '/etc/systemd/system/multi-user.target.wants/postfix.service'
```

最後に設定を確認

```
$ systemctl status postfix.servicepostfix.service - Postfix Mail Transport Agent
   Loaded: loaded (/usr/lib/systemd/system/postfix.service; disabled)
   Active: inactive (dead)
```


### OSのファイアウォールの設定

iptables ではなくて、 firewalld になっている。

現在の設定の確認

```
$ firewall-cmd --list-all
public (default)
  interfaces:
  sources:
  services: dhcpv6-client ssh
  ports:
  masquerade: no
  forward-ports:
  icmp-blocks:
  rich rules:
```

80番ポートを開くように変更
かつ永続化されるように `--permanent` オプションをつける。

```
$ sudo firewall-cmd --permanent --add-service=http --zone=public
success
```
}}}

defuct process とは {{{
-----------------
ps aux とかで defunct って なってるプロセスは
ゾンビ化してて、親が init になってるので、
これはもうkillできない。
}}}

find 検索例 {{{
---------

/var/log 以下を検索

```
find /var/log -name "*log" -mtime -3 -type f

find -E `pwd` -regex '.*min.*' -type f
```

}}}

for の使い方例 {{{
---------

for文はリストを渡してそのリストを順番に処理することができます。

```
for 変数 in リスト
```

でつかうことができるリストはスペース区切りもしくは
改行区切りで渡すことができます

}}}

swap領域を増やす {{{
-----------------

### centos7

### 現在の設定を調べる

```shell
swapon -s
```

若しくは以下

```shell
$ free -m
             total       used       free     shared    buffers     cached
Mem:          3953        315       3637          8         11        107
-/+ buffers/cache:        196       3756
Swap:            0          0       4095
```


### ディスクの利用状況

```
$ df -h

Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        59G  1.5G   55G   3% /
devtmpfs        2.0G     0  2.0G   0% /dev
tmpfs           2.0G     0  2.0G   0% /dev/shm
tmpfs           2.0G  8.3M  2.0G   1% /run
tmpfs           2.0G     0  2.0G   0% /sys/fs/cgroup
```

### swapfile を作成する

```shell
sudo fallocate -l 4G /swapfile
```

```
ls -lh /swapfile
-rw-r--r-- 1 root root 4.0G Oct 30 11:00 /swapfile
```


### swapfile を有効にする

``````
$ sudo chmod 600 /swapfile

$ sudo mkswap /swapfile

Setting up swapspace version 1, size = 4194300 KiB
no label, UUID=b99230bb-21af-47bc-8c37-de41129c39bf

sudo swapon /swapfile
```

### 確認

```
swapon -s
Filename                Type        Size    Used    Priority
/swapfile               file        4194300 0     -1
```

```
free -m
             total       used       free     shared    buffers     cached
Mem:          3953        315       3637          8         11        107
-/+ buffers/cache:        196       3756
Swap:         4095          0       4095
```

### 永続化

上記だけだと再起動でswap領域が消えるので

```
sudo vim /etc/fstab
```

以下を書き加える

```
/swapfile   swap    swap    sw  0   0
```



ubuntu
---

参考: https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04

### swap が現在いどうなったるかしらべる

```
$ sudo swapon -s

Filename                Type        Size    Used    Priority
```
上のように header だけしか表示されない場合は
swap領域が 0 になっているので作成する必要がある。

### root に swapfile を作成する

- さっさとやる方法

```

$ sudo fallocate -l 4G /swapfile

$ ls -lh /swapfile
-rw-r--r-- 1 root root 4.0G Apr 28 17:19 /swapfile

$ sudo chmod 600 /swapfile

$ sudo mkswap /swapfile
Setting up swapspace version 1, size = 4194300 KiB
no label, UUID=e2f1e9cf-c0a9-4ed4-b8ab-714b8a7d6944

$ sudo swapon /swapfile

$ sudo swapon -s
Filename                Type        Size    Used    Priority
/swapfile               file        4194300 0       -1
```

### 再起動しても同じように設定されるようにする

```
$ sudo vim /etc/fstab

# これを最終行に追加する
# /swapfile   none    swap    sw    0   0
```

}}}

ps コマンドまとめ {{{
-----------------

通常はもう

```
$ ps aux
```

でいいと思う

オプションは以下のようになっている

> UNIX オプション。まとめることが可能で、前にはダッシュを置かなければならない。
> BSD オプション。まとめることが可能で、ダッシュを使ってはならない。
> GNU ロングオプション。前に二つのダッシュを置く。

ので `ps aux` と `ps -aux` はまったくの別物であることに注意!

### a

すべての プロセスを表示

### u

ユーザ名 と 開始時刻を表示

### x

デーモンも表示

### f

tree 形式で表示

}}}

rubyでrenameする {{{
---------------

```
ls | ruby -ne '$_[/(.+)\.txt/]; puts %1' | xargs -I% mv %.txt %.md

# カレントにある .txt なファイルを .md に rename する
# ruby は -ne で while して $_ にいれてくれる
# [unix]
```
}}}

rsync の使いかた {{{
-----------------

ここも参考: http://qiita.com/nagais/items/7403411b4aa193d0fa0d

### ssh 経由で リモートと同期

```
rsync -rvauz --delete -e 'ssh' ./ any_remote_server:~/public
```

- r : 再帰
- v : 転送状況を表示
- u : update のみ, 上書き禁止
- a : アーカイブモード
- delete: コピー元にないファイルは削除
- e : rsh の代替コマンドを指定


### 基本

```
rsync [option] [src] [dest]
```

### 権限、所有権, timestamp 等をすべて引き継ぎ & recursive

`-a` オプションをつける

```
rsync -a /path/to/src /path/to/dest
```

個別の引き継ギ

- 所有者 `-o`
- グループ `-g`
- 権限 `-p`
- タイムスタンプ `-t`
- 再帰 `-r`
- シンボリックリンク `-l`


### syncの内容を表示

`-v` オプションを使う

### ssh経由でリモートホストと同期

リモート to ローカル

```
rsync <user>@<host>:/path/to/remote_src  /path/to/local_dest
```

ローカル to リモート

```
rsync /path/to/local_dest <user>@<host>:/path/to/remote_src
```

通信を圧縮する

`-z` オプションを使う



### 差分のみのバックアップ

`-u` オプションをつかう

更新のあるファイルのみをバックアップすることができる


- srcで削除したやつはremoteも削除

`--delete` オプションをつかう


- よくやるパターン

```
rsync -auv --delete /path/to/src kazukgw@remotehost:~/dest/
```


### dry-run

`-n`オプションを使う


### 統計情報を出力

```
$ rsync -auv /path/to/src /path/to/dest --stats

kazukgw/watchable/scss/_radar_chart.scss
...
...
kazukgw/watchable/scss/_normalize.scss
kazukgw/watchable/scss/_sidebar.scss
kazukgw/watchable/scss/style.scss

Number of files: 21721
Number of files transferred: 16929
Total file size: 155882695 bytes
Total transferred file size: 155882605 bytes
Literal data: 155882605 bytes
Matched data: 0 bytes
File list size: 479700
File list generation time: 0.423 seconds
File list transfer time: 0.000 seconds
Total bytes sent: 157183755
Total bytes received: 401210

sent 157183755 bytes  received 401210 bytes  15008091.90 bytes/sec
total size is 155882695  speedup is 0.99
```

### オプション一覧

```
 -v, --verbose               転送情報を詳しく表示
 -q, --quiet                 転送情報を表示しない
 -c, --checksum              常にチェックサムを行う
 -a, --archive               アーカイブモード(-rlptgoD オプションと同義)
 -r, --recursive             ディレクトリで再帰的に実行する
 -R, --relative              相対パス名を使う
 -b, --backup                バックアップを作成する (デフォルトで ~ が付く)
     --suffix=SUFFIX         バックアップのサフィックスを変更
 -u, --update                アップデートのみ許可 (上書き禁止)
 -l, --links                 ソフトリンクを維持する
 -L, --copy-links            ファイルのようにソフトリンクを扱う
     --copy-unsafe-links     送信側ツリー外のリンクをコピー
     --safe-links            受信側ツリー外のリンクを無視
 -H, --hard-links            ハードリンクを維持する
 -p, --perms                 パーミッションを維持する
 -o, --owner                 オーナーを維持する (root のみ)
 -g, --group                 グループを維持する
 -D, --devices               デバイスを維持する (root のみ)
 -t, --times                 タイムスタンプを維持する
 -S, --sparse                密度の低いファイルを効率的に扱う
 -n, --dry-run               実行時の動作だけを表示
 -W, --whole-file            rsync アルゴリズムを使わない
 -x, --one-file-system       再帰的に実行された時にファイルシステムの境界を横断しない
 -B, --block-size=SIZE       rsync アルゴリズムのチェックサムブロックサイズの制御(default 700)
 -e, --rsh=COMMAND           rsh の代替を指定
     --rsync-path=PATH       リモートのマシーンで rsync のコピーへのパスを指定
 -C, --cvs-exclude           システム間で転送したくない広範囲のファイルを除外(CVSの方法と同じ)
     --delete                送信側にないファイルを削除
     --delete-excluded       受信側にある exclud ファイルも削除
     --partial               転送途中のファイルを保存します
     --force                 ディレクトリが空でなくても削除
     --numeric-ids           ユーザとグループの id 番号を転送して、転送後にマッピング
     --timeout=TIME          IO タイムアウトを設定(秒)
 -I, --ignore-times          タイムスタンプとファイルサイズのチェックをしない
     --size-only             タイムスタンプのチェックをしないで、ファイルサイズのチェックだけをする
 -T  --temp-dir=DIR          tmp ファイルのディレクトリを指定
     --compare-dest=DIR      受信側のファイルと比較するための追加ディレクトリ
 -z, --compress              受信ファイルを圧縮compress file data
     --exclude=PATTERN       パターン一致するファイルを除外
     --exclude-from=FILE     ファイルに記述されたパターンと一致するファイルを除外
     --include=PATTERN       パターン一致するファイルを除外しない
     --include-from=FILE     ファイルに記述されたパターンと一致するファイルを除外しない
     --version               rsync のバージョンを表示する
     --daemon                rsync をデーモンとして走らせる
     --config=FILE           別の rsyncd.conf ファイルを指定
     --port=PORT             別の rsync ポート番号を指定
     --stats                 rsync アルゴリズムの転送効率を表示
     --progress              転送中の情報を表示
     --log-format=FORMAT     ログフォーマットを指定
     --password-file=FILE    ファイルからパスワードを得る
 -h, --help                  このヘルプを表示する
```
}}}

awk で3列目をすべて足し合わせる {{{
---------
```
awk '{ x += $3 } END { print x }' myfile
```
}}}

split でファイル分割 {{{
---------
```
$ split -l 1000 hoge.log hoge.log.
```

とかすると 1000行ごとに分割して

```
hoge.log.a
hoge.log.b
hoge.log.c
...

```

といった具合にファイルを分割してくれる
}}}

ssh の dirの権限 {{{
-------------
- .ssh は 700
- authorized_kays は 600
}}}

sshのポートフォワード {{{
-------
```
# ローカルの 10080  を 10.0.11.11 を
# ssh 経由で 10.0.11.12 の 80 と つなぐ
$ ssh 10.0.11.11 -L 10080:10.0.11.12:80 -N

# リモート(10.0.11.11) の 9090 と
# リモート(10.0.10.11) の 8080 をssh 経由でつなぐ
# ssh 経由で 10.0.11.12 の 80 と つなぐ
$ ssh 10.0.11.11 -R 9090:10.0.10.12:8080 -N
```

}}}

オレオレ証明書を openssl で作成する {{{
-------

お急ぎの方は、以下3つだけやれば良い。これで10年間(3650日)有効なオレオレ証明書ができあがる。

```
$ openssl genrsa 2048 > server.key
$ openssl req -new -key server.key > server.csr
$ openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt
```

できあがったserver.crtとserver.keyを、例えば/etc/httpd/conf/ 配下のssl.crt/ と ssl.key/ ディレクトリに設置し、以下のようにApacheのssl.confに記述する。

```
SSLCertificateFile /etc/httpd/conf/ssl.crt/server.crt
SSLCertificateKeyFile /etc/httpd/conf/ssl.key/server.key
```

なお途中に作ったserver.csrは不要なので消してしまって良い。

}}}

supervisor まとめ {{{
----------

apt-get でも yum でいれれて 自動起動script もついてくるので
管理楽そう

### on ubuntu

```
$ sudo apt-get install supervisor
```

すると /etc/supervisor が作成される

```
$ ls /etc/supervisor/
conf.d  supervisord.conf
```

```
[program:docker]
command=/usr/bin/docker -d
autorestart=true
```

を /etc/supervisor/conf.d/docker.conf

としてサーバを再起動してみる

見事自動で docker が起動した

さらに [program:fig] 追加してみる

```
[progmra:fig]
command=/usr/local/bin/fig /path/to/fig.yml start
autorestart=true
priority=1000
```

priority=1000 は
priority の値が低いものから起動されるからである。


### default config

```
$ cat  /etc/supervisor/supervisord.conf

; supervisor config file

[unix_http_server]
file=/var/run/supervisor.sock   ; (the path to the socket file)
chmod=0700                       ; sockef file mode (default 0700)

[supervisord]
logfile=/var/log/supervisor/supervisord.log ; (main log file;default $CWD/supervisord.log)
pidfile=/var/run/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
childlogdir=/var/log/supervisor            ; ('AUTO' child log dir, default $TEMP)

; the below section must remain in the config file for RPC
; (supervisorctl/web interface) to work, additional interfaces may be
; added by defining them in separate rpcinterface: sections
[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock ; use a unix:// URL  for a unix socket

; The [include] section can just contain the "files" setting.  This
; setting can list multiple files (separated by whitespace or
; newlines).  It can also contain wildcards.  The filenames are
; interpreted as relative to this file.  Included files *cannot*
; include files themselves.

[include]
files = /etc/supervisor/conf.d/*.conf
```

### [program:x] example

設定ファイルはいろいろ項目があるが普通に任意のプロセスを
デーモン起動したい場合は、 `[program:x]` の書式を用いる

以下 例

```
[program:cat]
command=/bin/cat
process_name=%(program_name)s
numprocs=1
directory=/tmp
umask=022
priority=999
autostart=true
autorestart=true
startsecs=10
startretries=3
exitcodes=0,2
stopsignal=TERM
stopwaitsecs=10
user=chrism
redirect_stderr=false
stdout_logfile=/a/path
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stdout_capture_maxbytes=1MB
stderr_logfile=/a/path
stderr_logfile_maxbytes=1MB
stderr_logfile_backups=10
stderr_capture_maxbytes=1MB
environment=A="1",B="2"
serverurl=AUTO
```

### 起動順

[program:x]
のなかで priority を使うといけそう。

### `/etc/supervisor/conf.d/*.conf`

に該当するファイルは自動でよみこんでくれる

### 実行時のユーザとPATH

```
user=hoge
```

を設定してもPATH はとおらないっぽいな。

}}}

tar {{{
--------------

### 必須のオプション

- -c : `C`reate
- -x : e`X`tract
- -t : lis`T`

### 次のオプション

- z : gZip 圧縮・解凍に gzip を使う（もちろん gzip 形式の場合のみ）
- v : Verbose 作成・抽出時にファイルのリストを画面出力する
- f : File 作成・抽出するファイルを指定する（tar は本来テープメディアのためのコマンド (Tape ARchive) のため、これを指定しないとデフォルトで /dev/rmt0 になってしまう）

### 例

```
tar (c|x|t)zvf [hoge.tar.gz] file1 file2
```

}}}

tcpdump まとめ {{{
-------------------

http://qiita.com/tossh/items/4cd33693965ef231bd2a

に詳しい

### オプション

- `-i` インターフェースを指定。 eth0 とかそういう

- `-w [filename]` キャプチャ結果を filename に保存

- `-r [filename]` filename からキャプチャを読み込む

- `-A` 結果を ASCII で表示

- `-p` 自ホスト宛以外のデータはキャプチャしない


### フィルタ

- host を指定

```
tcpdump host [ip_or_host]
```


- 送信元 host を指定

```
tcpdump src host [ip_or_host]
```


- 送信先 host を指定

```
tcpdump dst host [ip_or_host]
```

- どちらも別で指定

```
tcpdump src host [ip_or_host] dst host [ip_or_host]
```


- port を指定

上記のフィルタの記述にhost に加え `port` を加える

```
tcpdump src host [ip_or_host] port 80
```

とか。

}}}

awkで環境変数をつかったテンプレート {{{
-----------------
環境変数 を {{}} で囲んだ ものを placeholder として その環境変数の値で置き換える
```
echo "sed $(env | sed -e 's/\//\\\//g' | awk -F= '{print "-e \"s/\{\{" $1 "\}\}/" $2 "/g\" "}' | sed -e 's/\([\/"]\)/\\\1/g' | xargs echo) $1 > $2" | sh
```
}}}

umask とは {{{
---------

ふぁイルのパーミッションは、普通 644 (rw-r--r--) となるはずである。
これはもっともな話で、新しいファイルを作るたびにパーミッションが 666 (rw-rw-rw-)
や 777 (rwxrwxrwx) になっていては誰でも書き込めてしまい、
いちいち chmod しなくてはならず不便である。
このように、新規作成したファイル・ディレクトリのパーミッションを決めるのが、
umask である。

umask は、新しくファイルを作成する際に、
許可**しない**ビットを示すものである。
普通、ファイルの新規作成時はファイルの実行ビット (eXecute) は立てないので、
umask が 022 ということは、666 から 022 を引いた 644 というパーミッションで
新規ファイルが作られることになる。
umask が 002 なら 664 、 umask が 000 なら 666 となる。

umask を設定するには、

```
% umask 022
```
などとする。作成したファイルを誰にも見せたくなかったら、

```
% umask 066
```

とすればいいし、誰にでも読み書きしてほしかったら

```
% umask 000
```

とすればいい(もちろんお勧めはしない)。
引数を省略すると、現在の umask の値を表示する。
}}}

cat で heredocを使う {{{
----------
```
$ cat >> path/to/file.txt << "EOF"
export PATH=$PATH:hoge
export RAILS_ENV=production
EOF
```
}}}

opensslを使ってファイルを簡単暗号化 {{{
-------------------

### パスワードを標準入力から取得する場合

```
$ openssl aes-256-cbc -e -in rowtext.txt -out encrypted.txt
enter aes-256-cbc encryption password: # パスワード入力
Verifying - enter aes-256-cbc encryption password: # もう一度

- 復号
$ openssl aes-256-cbc -d -in encrypted.txt -out decrypted.txt
enter aes-256-cbc decryption password: # パスワードを入力

```


### パスワードをファイルから読み込む場合

```
$ openssl aes-256-cbc -e -in rowtext.txt -out encrypted.txt -pass file:./password.txt

- 復号
$ openssl aes-256-cbc -d -in encrypted.txt -out decrypted.txt -pass file:./password.txt
```

}}}

いろんなversionを確認する {{{
----------
### カーネルのバージョン確認

```
$ cat /proc/version

Linux version 2.6.25.3-2.fc9.i686.xen (mockbuild@) (gcc version 4.3.0 20080428 (Red Hat 4.3.0-8) (GCC) ) #1 SMP Thu May 29 12:48:20 EDT 2008
```

あと、

```
$ uname -a
```

でもOK。


### Debian GNU/Linux

```
$ cat /etc/debian_version
4.0
```

### Ubuntu

```
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=8.04
DISTRIB_CODENAME=hardy
DISTRIB_DESCRIPTION="Ubuntu 8.04.1"
```

### CentOS / RedHat Enterprise Linux

```
$ cat /etc/redhat-release
CentOS release 5.2 (Final)
```

### Fedora

```
$ cat /etc/fedora-release
Fedora release 9 (Sulphur)
```

### SUSE Linux

```
$ cat /etc/SuSE-release
SUSE Linux Enterprise Server 10 (x86_64)
VERSION=10
PATCHLEVEL=1
```

}}}

bashのwhile {{{
------------
基本は

```
while [条件]; do
  # 処理
done
```

となる。

### 例

readででかいサイズのファイルを読む

```
while read x; do
  echo $x
done
```

}}}

nc(netcat) {{{
--------------------------

これを参考にした https://docs.oracle.com/cd/E56342_01/html/E54074/netcat-1.html
solarisやけど、、、
まぁだいたいいっしょでしょ

### 基本は
任意のTCP, UDPの接続,待機を行う

> nc は、TCP 接続を開き、UDP パケットを送信し、
> 任意の TCP および UDP ポートで待機し、ポートスキャンを実行し、
> IPv4 と IPv6 の両方に対応します。telnet(1) とは異なり、
> nc は簡単にスクリプト化でき、エラーメッセージを
> 標準出力に送信するのではなく標準エラーに分割します。

たとえばファイルをやり取りする
---------

最初に、nc を使用して特定のポートで待機し、出力をファイルに取り込みます。

```
$ nc -l 1234 > filename.out
```

2 つ目のマシンを使用して、待機中の nc プロセスに接続し、転送するファイルを入力します。

```
$ nc host.example.com 1234 < filename.in
```

単純にGETを送る
------------

```
$ echo -n "GET / HTTP/1.0\r\n\r\n" | nc host.example.com 80
```


メールを送ってみる
-------------

```
$ nc localhost 25 << EOF
HELO host.example.com
MAIL FROM: <user@host.example.com
RCTP TO: <user2@host.example.com
DATA
Body of email.
.
QUIT
EOF
```

ポートをスキャンしてみる
---------

```
$ nc -z host.example.com 20-30
Connection to host.example.com 22 port [tcp/ssh] succeeded!
Connection to host.example.com 25 port [tcp/smtp] succeeded!
```

sshをリダイレクト
---------------

```
$ nc -R host.example.com/22 -l 4545
```
これにより、ssh(1) クライアントを実行し、上記のコマンドを実行している host redir.example.com を使用して host.example.com に接続できるようになります。

```
$ ssh -oStrictHostKeyChecking=no -p 4545 redir.example.com
```

}}}

lsof {{{
--------------------

- 参考: https://yakst.com/ja/posts/4217

###  開かれているファイル全てを表示

    lsof

lsof を引数なしで実行すると、各プロセスが開いているファイル全てを一覧表示します。

### どのプロセスがファイルを使用しているか確認

    lsof /path/to/file

ファイルのパスを引数に渡すと、 lsof はファイルを使っている全プロセスを一覧表示します。
また、複数のファイルを指定すると、それらのファイルを使っている全プロセスを表示します。

    lsof /path/to/file1 /path/to/file2

### ディレクトリを再帰的にたどって開かれているファイルを表示

    lsof +D /usr/lib

+D 引数を渡すと、 lsof は指定したディレクトリとそのサブディレクトリ全ての中から開かれているファイルを一覧表示します。


### ユーザーごとに開かれているファイルを一覧表示

    lsof -u pkrumins

-u オプション(userの頭文字)は、ユーザー pkrumins によって開かれているファイルだけを出力するよう制限します。

複数のユーザーをコンマ区切りのリストにして渡すこともできます。

    lsof -u rms,root

これは、ユーザー rms と root によって開かれているファイルを一覧表示します。

あるいは、 -u を2回付けても同じことができます。

    lsof -u rms -u root

### プログラム名ごとに開かれているファイルを探す

    lsof -c apache
-c オプションで、名前が apache から始まるプロセスの開いているファイルを選べます。

つまり、以下のように書いたのと同じです。

    lsof | grep foo
これは以下のように短くできます。

    lsof -c foo
実際には、探しているプロセスの最初の部分だけを指定すればよいでしょう。

    lsof -c apa

これで、 apa から始まるプロセスが開いているファイル全てを一覧表示できます。

また、複数の -c オプションを付けて複数のプロセスが開いているファイルを出力することもできます。

    lsof -c apache -c python

これは、 apache と python が開いているファイルを一覧表示します。

### あるユーザーまたはプロセスが開いているすべてのファイルを一覧表示

    lsof -u pkrumins -c apache

lsof のオプションは組み合わせて使えます。デフォルトでは複数のオプションがORになります。つまり -u pkrumins と -c apache の組み合わせは、 pkrumins が開いているすべてのファイルと、 apache が開いているすべてのファイルを合わせた一覧を返します。

### あるユーザーの特定プロセスが開いているすべてのファイルを一覧表示

    lsof -a -u pkrumins -c bash

-a オプションに注意してください。これがオプションをANDでつなぎます。出力は、 pkrumins ユーザーのもとで動いている bash で開かれているファイルの一覧になります。

### root以外のすべてのユーザーが開いているファイルを一覧表示

    lsof -u ^root

rootユーザー名の前の^に注意してください。パターンに一致しないものを抽出するので、 lsof はrootでない全ユーザーが開いている全ファイルを出力します。

### PID指定でプロセスが開いているすべてのファイルを一覧表示

    lsof -p 1

-p オプション(PIDから来たもの)が、PIDで出力のファイル一覧をフィルターします。

PIDのコンマ区切り指定、あるいは複数回 -p を引数に渡すことで複数のPIDを指定できます。

    lsof -p 450,980,333

これは、PIDが450、980、333のプロセスが開いているすべてのファイルを一覧表示します。

    lsof -p ^1

ここでも否定を表す ^ が使われています。PID 1のプロセスが開いているファイルを含まないリストが表示されます。

### すべてのネットワーク接続を一覧表示

    lsof -i

-i オプションを付けた lsof は、開いているインターネットソケット(TCPとUDP)と一緒に全プロセスの一覧を表示します。

### すべてのTCPネットワーク接続を一覧表示

    lsof -i tcp

-i 引数はいくつかのオプションを取れますが、その中のひとつが tcp です。 tcp オプションはTCPソケットを開いているプロセスだけを一覧表示します。

### すべてのUDPネットワーク接続を一覧表示

    lsof -i udp

udp オプションは、 lsof にUDPソケットを使っているプロセスだけを表示させます。

### 誰がポートを使っているか調べる

    lsof -i :25

-i に :25 オプションを追加すると、 lsof はTCPあるいはUDPの25万ポートを使っているプロセスを見つけ出します。

また、サービスポート名(/etc/servicesに書かれています)をポート名の代わりに書くこともできます。

    lsof -i :smtp

### 誰が特定のUDPポートを使っているか調べる

    lsof -i udp:53

同じく誰がTCPポートを使っているかを調べるには、

    lsof -i tcp:80

### 特定のユーザーによるすべてのネットワーク通信を調べる

    lsof -a -u hacker -i

ユーザーhackerが使用しているネットワークファイルすべての一覧を生成するのに、-a オプションが -u と -i を結合します。

}}}

Todo
==================

- nohop
- disown
- netstat
- trap
- here doc
- dstat
- jq
- csvkit
- s3cmd
- cut,paste,join
- tee
- diff と patch
- git diff と git patch
- xdelta3
- tar gz
- curl と wget
- vmstat
- traceroute と mtr
- du -sh と ncdu
- iftop と nethogs
- ab (appache bench)
- ngrep
- wireshark
- strace や ltrace
- /proc 以下にはなにがあるか
- sar

-------------------------------------------------------

vim: foldmethod=marker foldlevel=0
