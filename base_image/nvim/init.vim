""""""" vimrc の基礎メモ {{{
"
"    # vim script 基礎
"    - https://mattn.kaoriya.net/software/vim/20111202085236.htm
"
"
"    # map/noremap の違い
"    - https://cocopon.me/blog/2013/10/vim-map-noremap/
"    - 基本は noremap (remap しない) でよい
"
"
"    # <Plug>, <SID>
"    - https://www.reddit.com/r/vim/comments/78izt4/please_help_understand_how_to_use_plug_mapping/
"    plugin 側では
"        nnoremap <Plug>(HelloWorld) :echo "Hello world!"<CR>
"    としておいて
"    ユーザ側で
"        nmap s <Plug>(HelloWorld)
"    とすることで で :echo "Hello world!"<CR> がよびだせる
"    Plugin が利用する Keymap の Interface 的なものである
"    なので ユーザ側では noremap ではなく nmap などで再マップさせる必要がある
"
"    # <silent>
"    実行するコマンドがコマンドラインに表示されないようにするには、マップコマンドの
"    引数に "<silent>" を指定します。例: map <silent> ,h /Header<CR>
"
"
""" }}}


""""""" set config {{{
syntax enable
syntax on
syntax sync minlines=200

set t_Co=256                " 256色
set title                   " vim を使ってくれてありがとう
set nocompatible            " Be iMproved
set number                  " 行数を表示
set encoding=utf-8          " 内部の文字コード
" set fileencoding=utf-8    " 書き込み時の文字コード, 指定しなければ encoding
                            " と同じになる
set fileencodings=utf-8,sjis  " 読み込み時の文字コード, 左から順に評価する
set tabstop=2               " 何個分のスペースで 1 つのタブとしてカウントするか
set expandtab               " softtabstop で指定した値分スペースが入力されても <TAB> に変換しない
set softtabstop=2           " <Tab> を押した時, 何個分のスペースを挿入するかを設定するオプションです
set shiftwidth=2            " デフォルトのインデントのスペースの数
set autoindent
set noequalalways           " window サイズの自動調整を無効化
set incsearch               " インクリメンタルサーチ有効
set noswapfile              " スワップファイルをつくらない
set nobackup
set noundofile              " undofile は作らない http://www.kaoriya.net/blog/2014/03/30/
set hidden                  " 編集中でも、保存しないで他のファイルを開けるようにする
set confirm                 " ファイルを保存していない場合に、ファイルの保存を確認するダイアログを出す
set cmdheight=1             " 画面下部に表示されるコマンドラインの高さの設定
set showcmd                 " 入力したコマンドをステータスライン上に表示  例えばdを入力したらdと表示される
set scrolloff=5             " カーソルの上または下に表示される最小限の行数  5に設定してあるので、下に5行は必ず表示される
set visualbell              " ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set vb t_vb=                " ビープを鳴らさない
set mouse=a                 " 全モードでマウスの操作を有効
set laststatus=2            " ステータスラインを常に表示する
set ruler                   " ルーラを表示
set cursorline              " カーソル行ハイライト
set showmatch               " カッコの対応をハイライト
set wrapscan                " 最後まで検索したら先頭に戻る
set ignorecase              " 大文字小文字を無視する
set smartcase               " 検索文字列に大文字が含まれている場合は区別して検索する
set hlsearch                " 検索語を強調表示
set lazyredraw
set foldmethod=indent
set foldlevel=1
set foldcolumn=0
set colorcolumn=80
set norelativenumber
set showtabline=2
set completeopt-=preview
set modeline
set modelines=4
set viminfo=!,\'100,\"5000,s50,h,n~/.config/nvim/viminfo
set sh=bash

"" neovim だと以下設定だとおかしくなる
" set shellcmdflag=-ic
set clipboard+=unnamedplus
set ambiwidth=double

" mapleaderに設定してあるものが <Leader> に置き換わる
" map 時の <Leader> は評価時の値がそのまま利用されるので vimrc の先頭のほうで書いておく
let mapleader = "\<Space>"
"}}}


""""""" color scheme {{{
augroup color_scheme
  autocmd!
  """ カラースキーム適用時に実行される
  autocmd ColorScheme * highlight Visual term=reverse cterm=reverse
augroup end

let g:molokai_original=1
colorscheme molokai

" Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif
"}}}

" filetype の判定と typeによる plugin, indent を一旦 off
" ファイル終端で ON にしている
filetype off


""""""" plugins (vim-plug) {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'LeafCage/foldCC.vim'
Plug 'Lokaltog/vim-easymotion'
" Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-submode'
Plug 'majutsushi/tagbar'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tyru/caw.vim'
Plug 'kana/vim-fakeclip'
Plug 'junegunn/gv.vim'
Plug 'kassio/neoterm'
" Plug 'ryanoasis/vim-devicons' " 見た目はよくなるがフォントインストールされてない環境でも使いたいので off

" coc.nvim
" " Use release branch (Recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" coc.nvim extensions  " CocIntall でいれるので 以下は コメントアウト
" Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-git', {'do': './install.sh'}
" Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile' }
" Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

" HTML
Plug 'mattn/emmet-vim', { 'for': ['html','eruby'] }

" TypeScript
Plug 'leafgarland/typescript-vim'  " syntax highlight ができなかったので

" on command
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'rking/ag.vim', { 'on': 'Ag' }
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }
Plug 'vim-scripts/Align', { 'on': 'Align' }

call plug#end()
""" }}}


""""""" NERDTree {{{
noremap nt :NERDTreeToggle <CR>
let NERDTreeShowHidden = 1
""" }}}


""""""" Lightline {{{
" https://github.com/itchyny/lightline.vim
" 以下は https://qiita.com/yuyuchu3333/items/20a0acfe7e0d0e167ccc を参考とした

let g:lightline = {
  \ 'separator': { 'left': '', 'right': ''  },
  \ 'subseparator': { 'left': '', 'right': ''  },
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['fugitive', 'gitgutter', 'filename'],
  \   ],
  \   'right': [
  \     ['percent'],
  \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
  \   ]
  \ },
  \ 'component_function': {
  \   'modified': 'MyModified',
  \   'readonly': 'MyReadonly',
  \   'fugitive': 'MyFugitive',
  \   'filename': 'MyFilename',
  \   'fileformat': 'MyFileformat',
  \   'filetype': 'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'mode': 'MyMode',
  \   'charcode': 'MyCharCode',
  \   'gitgutter': 'MyGitGutter',
  \ }
\ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? 'RO' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \  (&ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '* '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

""" }}}


""""""" EasyMotion {{{
let g:EasyMotion_do_mapping = 0 "Disable default mappings
nmap s <Plug>(easymotion-s2)
""" }}}


""""""" IndentLine {{{
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#505050'
let g:indentLine_char = '¦'
""" }}}


""""""" vim-gitgutter {{{
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '✘'
let g:gitgutter_async = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=237
highlight GitGutterAdd    ctermfg=2 ctermbg=237
highlight GitGutterChange ctermfg=3 ctermbg=237
highlight GitGutterDelete ctermfg=1 ctermbg=237
""" }}}


""""""" NERDCommenter {{{
nmap ,, <Plug>(caw:i:toggle)
vmap ,, <Plug>(caw:i:toggle)
""" }}}


""""""" vim-submode {{{
" https://github.com/kana/vim-submode
" 設定は下記を参考 https://thinca.hatenablog.com/entry/20130131/1359567419
" window のリサイズを自動でできるように
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
""" }}}


""""""" gist.vim {{{
" https://github.com/mattn/vim-gist
let g:gist_show_privates = 1
let g:gist_post_privates = 1
""" }}}


""""""" tagbar {{{
noremap tb :TagbarToggle <CR>
let g:tagbar_ctags_bin='/usr/bin/ctags'

" https://github.com/majutsushi/tagbar/wiki#typescript
"   npm install --global git+https://github.com/Perlence/tstags.git
" しておく必要がある
let g:tagbar_type_typescript = {
  \ 'ctagsbin' : 'tstags',
  \ 'ctagsargs' : '-f-',
  \ 'kinds': [
    \ 'e:enums:0:1',
    \ 'f:function:0:1',
    \ 't:typealias:0:1',
    \ 'M:Module:0:1',
    \ 'I:import:0:1',
    \ 'i:interface:0:1',
    \ 'C:class:0:1',
    \ 'm:method:0:1',
    \ 'p:property:0:1',
    \ 'v:variable:0:1',
    \ 'c:const:0:1',
  \ ],
  \ 'sort' : 0
\ }

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'ctagsbin' : '/Users/kazukgw/Dropbox/kazukgw/bin/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
      \ 's:sections',
      \ 'l:links',
      \ 'i:images'
    \ ],
    \ "sro" : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ "sort" : 0,
  \ }

let g:markdown_fenced_languages = [
\  'sql',
\  'css',
\  'java',
\  'cpp',
\  'c',
\  'erb=eruby',
\  'javascript',
\  'js=javascript',
\  'json=javascript',
\  'ruby',
\  'sass',
\  'xml',
\  'go',
\  'objc',
\  'python',
\]
""" }}}


""""""" quickrun {{{
" https://github.com/thinca/vim-quickrun
" https://github.com/thinca/vim-quickrun/blob/master/doc/quickrun.jax
" 設定はデフォルトを利用するので以下はコメントアウト
" let g:quickrun_config = {}
""" }}}


""""""" 全角スペースのハイライト {{{
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif
""" }}}


""""""" FoldCC {{{
set foldtext=FoldCCtext()
set fillchars=vert:\|
""" }}}


""""""" fzf {{{
let g:fzf_files_options =
  \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

nnoremap <C-p> :Files<CR>

nnoremap <Leader>r :History<CR>

nnoremap <Leader>b :Buffers<CR>

nnoremap <Leader>s :Lines<CR>

function! s:pjopen(e)
  exec 'e ' . $GOPATH. '/src/' .a:e
endfunction
command! Pj call fzf#run({
     \ 'source': 'find $GOPATH/src -maxdepth 4 -type d | sed -E "s/.*\/src\///g"',
     \ 'sink': function('<sid>pjopen'),
     \ 'down': '40%' })

""" }}}


"""""" coc.nvim {{{

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Using CocList
" Show all diagnostics
nnoremap <silent> <Leader>d  :<C-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent> <Leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <Leader>o  :<C-u>CocList outline<cr>
" Search workLeader symbols
nnoremap <silent> <Leader>s  :<C-u>CocList -I symbols<cr>

" }}}


""""""" vim-json {{{
let g:vim_json_syntax_conceal = 0
augroup VimJson
  autocmd!
  autocmd BufNewFile,BufReadPost *.json set conceallevel=0
augroup END
""" }}}


""""""" javascript {{{
augroup MyJavascript
  autocmd!
  autocmd BufNewFile,BufRead *.es6 set filetype=javascript
augroup END
"""}}}


""""""" go {{{
command! PlayGo :set ft=go | :0r ~/.templates/quickrun_go.go
"""}}}


""""""" python {{{
" pyenv
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
let g:python_host_prog = $PYENV_ROOT . '/shims/python'
"""}}}


""""""" MySettings {{{
command! Vimrc :e ~/.config/nvim/init.vim
command! Reload :source ~/.config/nvim/init.vim

""" terminal
augroup MyTerminal
  autocmd!
  autocmd BufWinEnter,WinEnter term://* startinsert
augroup END
tnoremap <ESC> <C-\><C-n>
command! -nargs=* Ts :below 10sp term://$SHELL


" backupskip は backup を作らないファイルを指定するが
" mac で crontab -e でvimを使う場合はこの設定が必要ぽい ??
set backupskip=/tmp/*,/private/tmp/*

""" カーソル
" カーソル形状がすぐに元に戻らないのでタイムアウト時間を調整
set ttimeoutlen=10
" 挿入モードを抜けた時にカーソルが見えなくなる現象対策(なぜかこれで治る)
inoremap <ESC> <ESC>
" insert mode でemacs風な動き
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-f> <C-o>w
inoremap <C-b> <C-o>b
inoremap <C-d> <C-o>x

""" tab
nnoremap tt :tabnew<CR>
nnoremap tq :tabclose<CR>
nnoremap tn gt
nnoremap tp gT

""" 連続でインデントを操作
vnoremap < <gv
vnoremap > >gv

""" grep したら QuickFixを自動で開く
augroup MyGrepOpen
  autocmd!
  autocmd QuickFixCmdPost vimgrep cw
augroup END

""" current buffer を vimgrep
command! -nargs=1 S exec 'vimgrep '. string(<q-args>). ' %'

""" gj(k) と j(k) を入れかえ
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk K

""" tab文字等可視化
" タブ文字を CTRL-I で表示し、行末に $ で表示する。（有効:list/無効:nolist）
set list
" Listモード (訳注: オプション 'list' がオンのとき) に使われる文字を設定する。
set listchars=tab:\▸\       " tab
" 上記特殊文字の文字色
highlight SpecialKey term=underline ctermfg=darkgray guifg=darkgray

""" 編集中のファイルをrename
command! -nargs=+ -bang -complete=file Rename let pbnr=fnamemodify(bufname('%'), ':p')|exec 'f '.escape(<q-args>, ' ')|w<bang>|call delete(pbnr)

" 保存時に行末の空白を除去する
augroup MyOthers
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END

""" template
function! TemplateListFile(A, L, P)
  let filelist = expand($HOME."/.templates/".a:A."*")
  if filelist =~ '\*'
    return []
  endif
  let splitted = split(filelist, "\n")
  let splitted_and_gsubed = map(splitted, "substitute(v:val, '.*\/\.templates\/', '', 'g')")
  return splitted_and_gsubed
endfunction

command! -nargs=1 -complete=customlist,TemplateListFile Tmpl :r ~/.templates/<args>

function! StripEscSeq(str)
  return substitute(a:str, '\v\e\[\?\d+[mhK]', '', 'g')
endfunction

""" 現在のbufferのpath
command! Current echo @%

""" https://gist.github.com/pinzolo/8168337
""" 指定のデータをレジスタに登録する
function! s:Clip(data)
  let @"=a:data
  echo "clipped: " . a:data
endfunction

" 現在開いているファイルのパスをレジスタへ
command! -nargs=0 ClipPath call s:Clip(expand('%:p'))
" 現在開いているファイルのファイル名をレジスタへ
command! -nargs=0 ClipFile call s:Clip(expand('%:t'))
" 現在開いているファイルのディレクトリパスをレジスタへ
command! -nargs=0 ClipDir  call s:Clip(expand('%:p:h'))

" 最後に保存した状態とのDiff
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
 \ | diffthis | wincmd p | diffthis

augroup yankhook
  autocmd!
  autocmd TextYankPost * :wv
  autocmd WinEnter,TabEnter * :rv!
augroup end

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<CR>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" fakeclip経由で tmuxにcopy
map <Leader>y "&y

""" }}}


""""""""""""""""""""""""""""""
filetype plugin indent on

" vim: foldmethod=marker foldlevel=0