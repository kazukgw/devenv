# vimrc の基礎メモ

## 便利機能メモ

* GitMessenger
* MergetoolXXX
* Rename
* Tmpl
* Cheat
* Current
* QuickRun
  * ``:'<,'>QuickRun python`` で 選択箇所を python として実行できる

* ``:'<,'>GitGutterStageHunk``

## regexp

* very magic: `\v` をつける


## vim script 基礎
- https://mattn.kaoriya.net/software/vim/20111202085236.htm


## map/noremap の違い
- https://cocopon.me/blog/2013/10/vim-map-noremap/
- 基本は noremap (remap しない) でよい


## <Plug>, <SID>
- https://www.reddit.com/r/vim/comments/78izt4/please_help_understand_how_to_use_plug_mapping/
plugin 側では
    nnoremap <Plug>(HelloWorld) :echo "Hello world!"<CR>
としておいて
ユーザ側で
    nmap s <Plug>(HelloWorld)
とすることで で :echo "Hello world!"<CR> がよびだせる
Plugin が利用する Keymap の Interface 的なものである
なので ユーザ側では noremap ではなく nmap などで再マップさせる必要がある

## <silent>
実行するコマンドがコマンドラインに表示されないようにするには、マップコマンドの
引数に "<silent>" を指定します。例: map <silent> ,h /Header<CR>

