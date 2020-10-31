# git stash
``
$ git stash save
$ git checkout <branch-name>
$ git stash pop
``
# git rebase -i
``````
3つ前の場合は

$ git rebase -i HEAD~3
これでエディタが起動してどのコミットを変更するかの選択になるので、対象の行頭のpickをeditに変更して:wqする。
この状態で

$ git commit --amend
を実行すると、edit対象のコミットログに対しての再コミットとなるので、コミットログを修正する。
修正したら

$ git rebase --continue
対象が複数ある場合は次のコミットログをgit commit --amendしてgit rebase --continueを件数分繰り返し。

最後のrebase --continueを実行すると完了する。
``````

# git reset

## 直前のコミットを取り消したい (コミットだけ消したい)
```
$ git reset --soft HEAD^
```

##  直前のコミットを取り消したい（マルっと消したい）

``````
$ git reset --hard HEAD^
``````

##  コミット後の変更を全部消したい

``````
$ git reset --hard HEAD
``````

##  すごい昔の状態で動作を確認したい
``````
$ git reset --hard <commit-hash>
# もとにもどる
$ git reset --hard ORIG_HEAD
``````
- git reset --hard ORIG_HEAD：直前のresetをなかったことにするおまじない！
- git resetは未来の状態にも行ける。
- git reset --hard 最新のコミットのハッシュ値でも良い。
- git rebase origin/masterでも良い。
- rebaseで何か問題が起きたら下記参照。
- http://qiita.com/shuntaro_tamura/items/c505b76c1021a35ca9ff
- reset --hardやrebaseする時は、こまめにソースツリーの状態を確認しておくといいと思います。
``````
