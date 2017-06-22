""""""" set config {{{
syntax enable
syntax on
syntax sync minlines=200

set t_Co=256                " 256色
set title
set nocompatible            " Be iMproved
set gfn=Ricty:h12
set number                  " 行数を表示
set fileencodings=utf-8,sjis
" set encoding=utf-8
set tabstop=2               " tab はだいたい`soft` の `2`
set expandtab               " softtab 有効
set softtabstop=2
set shiftwidth=2
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
"" neovim だと以下設定だとおかしくなる
" set shellcmdflag=-ic
" set clipboard+=unnamedplus
set ambiwidth=double

""" color scheme
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


""""""""""""""""""""""""""""""
" filetype の判定と typeによる plugin, indent を一旦 off
" ファイル終端で ON にしている
filetype off


""""""" plugins {{{
call plug#begin('~/.config/nvim/plugged')

Plug 'LeafCage/foldCC.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'kana/vim-submode'
Plug 'majutsushi/tagbar'
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/syntastic'
Plug 'neomake/neomake'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tyru/caw.vim'
Plug 'kana/vim-fakeclip'

" ruby
Plug 'tpope/vim-haml', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'tpope/vim-endwise', { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

" JS
Plug 'marijnh/tern_for_vim', { 'for': 'javascript' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'mtscout6/syntastic-local-eslint.vim', { 'for': 'javascript' }

" JSX
Plug 'pangloss/vim-javascript', { 'for': 'jsx' }
Plug 'mxw/vim-jsx', { 'for': 'jsx' }

" HTML
Plug 'mattn/emmet-vim', { 'for': ['html','eruby'] }

" go
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'zchee/deoplete-go', { 'do': 'make'}

" python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'tell-k/vim-autopep8', { 'for': 'python' }

" on command
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'rking/ag.vim', { 'on': 'Ag' }
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }
Plug 'vim-scripts/Align', { 'on': 'Align' }

call plug#end()
""" }}}


""""""" deoplete {{{

" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

" Path to python interpreter for neovim
" let g:python3_host_prog  = '/usr/local/bin/python3'
" Skip the check of neovim module
" let g:python3_host_skip_check = 1

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1

" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'
""" }}}


""""""" NERDTree {{{
noremap nt :NERDTreeToggle <CR>
let NERDTreeShowHidden = 1
""" }}}


""""""" Lightline {{{
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
  return &ft !~? 'help\|vimfiler\|gundo' && &ro ? '⭤' : ''
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
      return strlen(_) ? '⭠ '._ : ''
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


""""""" tern_for_vim {{{
let g:tern#is_show_argument_hints_enabled = 0
" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

""" }}}


""""""" vim-gitgutter {{{
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '✘'
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_async = 0
""" }}}


""""""" NERDCommenter {{{
nmap ,, <Plug>(caw:i:toggle)
vmap ,, <Plug>(caw:i:toggle)
""" }}}


""""""" vim-submode {{{
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


""""""" Gitv {{{
let g:Gitv_OpenPreviewOnLaunch = 0
""" }}}


""""""" tagbar {{{
nnoremap <C-]> g<C-]>
noremap tb :TagbarToggle <CR>
let g:tagbar_ctags_bin='/usr/bin/ctags'

let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }


" for golang
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

" for markdown
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


""""""" syntastic **(replaced with neomake)** {{{
" let g:syntastic_enable_signs = 1
" let g:syntastic_check_on_open = 1
"
" let g:syntastic_mode_map = { 'mode': 'passive',
"             \ 'active_filetypes': ['javascript', 'python', 'go'] }
" let g:syntastic_javascript_checkers = ["eslint"]
" let g:syntastic_python_checkers = ["python"]
" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
""" }}}


""""""" neomake {{{
autocmd! BufWritePost * Neomake

"\ 'args': ['--ignore=E221,E241,E272,E251,W702,E203,E201,E202',  '--format=default'],
    "
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_python_flake8_maker = {
    \ 'args': ['--format=default'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }
let g:neomake_python_enabled_makers = ['flake8']

let g:neomake_go_golint_maker = {
    \ 'exe': 'golint',
    \ 'args': ['-min_confidence 0.9'],
    \ 'errorformat':
        \ '%W%f:%l:%c: %m,' .
        \ '%-G%.%#'
    \ }
let g:neomake_go_enabled_makers = ['go', 'golint', 'govet']

""" }}}


""""""" autopep8 {{{
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
   " Save the last search.
   let search = @/
   " Save the current cursor position.
   let cursor_position = getpos('.')
   " Save the current window position.
   normal! H
   let window_position = getpos('.')
   call setpos('.', cursor_position)
   " Execute the command.
   execute a:command
   " Restore the last search.
   let @/ = search
   " Restore the previous window position.
   call setpos('.', window_position)
   normal! zt
   " Restore the previous cursor position.
   call setpos('.', cursor_position)
endfunction

function! Autopep8()
   call Preserve(':silent %!autopep8 -')
endfunction

autocmd! BufWritePre *.py Autopep8
let g:autopep8_disable_show_diff=1
""" }}}


""""""" quickrun {{{
let g:quickrun_config = {}
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


""""""" vim-json {{{
let g:vim_json_syntax_conceal = 0
au BufNewFile,BufReadPost *.json set conceallevel=0
""" }}}


""""""" FoldCC {{{
set foldtext=FoldCCtext()
set fillchars=vert:\|
hi Folded gui=bold term=standout ctermbg=236 ctermfg=DarkBlue guibg=Grey30 guifg=Grey80
hi FoldColumn gui=bold term=standout ctermbg=236 ctermfg=DarkBlue guibg=Grey guifg=DarkBlue
""" }}}


""""""" vim-go {{{
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" let g:gocomplete#system_function = 'vimproc#system2'
let g:go_autodetect_gopath = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
""" }}}


""""""" cursor {{{
" Cursor support for terminals
" ============================
"
" Defaulting vertical line for insert mode and block for other modes.

" TODO: Support for gnome-terminal and xterm

" for neovim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" GUI environments don't require any action.
if has("gui_running")
  finish
endif

" Environments are additive so we store the current escape sequences in temp
" vars.
let s:si=''
let s:ei=''

" iTerm
" -----

" iTerm escape sequence for cursor shape is:
"
"   \<Esc>]50;CursorShape={N}\x7
"
" Where {N} is:
"  - 0 for block
"  - 1 for vertical bar
"  - 2 for underline
"
" Reference:
"   https://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes#Set_cursor_shape
if exists('$ITERM_PROFILE')
  let s:si="\<Esc>]50;CursorShape=1\x7"
  let s:ei="\<Esc>]50;CursorShape=0\x7"
endif

" OS X Terminal
" -------------
"
" Inspired by: http://www.damtp.cam.ac.uk/user/rbw/vim-osx-cursor.html
"
" Simulate cursor shapes by highlighting the current character in normal mode.
" Terminal cursor must be set to 'Vertical line'.
"
" FIXME:
"  - Cursor in empty lines are not highlighted
"  - Match parenthesis have precedence over cursor highlight
if $TERM_PROGRAM == 'Apple_Terminal'
  " Turn 'cursorline' on to update cursor regularly
  " set cursorline

  " Enable Cursor highlight for term
  highlight Cursor cterm=reverse

  " Un-highlight cursor for unfocused buffers and insert mode
  autocmd WinLeave,InsertEnter * match none /\%#/

  " Highlight cursor position in other modes only for focused windows
  autocmd BufEnter,WinEnter,InsertLeave * match Cursor /\%#/
endif

" tmux
" ----
"
" tmux captures escape sequences sent from vim, so we need to forward them to
" the emulator.
if exists('$TMUX') && s:si != '' && s:ei != ''
  let s:si="\<Esc>Ptmux;\<Esc>".s:si."\<Esc>\\"
  let s:ei="\<Esc>Ptmux;\<Esc>".s:ei."\<Esc>\\"
endif

" Use escape sequencess if they where declared.
if s:si != '' && s:ei != ''
  let &t_SI=s:si
  let &t_EI=s:ei
endif
""" }}}


""""""" MySettings {{{
let mapleader = "\<Space>"
command! Vimrc :e ~/.config/nvim/init.vim
command! -nargs=1 -complete=file NSS NeoSnippetSource <args>
command! Cpc CtrlPClearAllCaches
command! Neotags NeoCompleteTagMakeCache

noremap <Space>git :Gitv --all<CR>
noremap <Space>gitf :Gitv! --all<CR>

command! Reload :source ~/.config/nvim/init.vim

" backupskip は backup を作らないファイルを指定するが
" mac で crontab -e でvimを使う場合はこの設定が必要ぽい
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
augroup grepopen
  autocmd!
  autocmd QuickFixCmdPost vimgrep cw
augroup END

""" current buffer を vimgrep
command! -nargs=1 S exec 'vimgrep '. string(<q-args>). ' %'

""" current buffer の /// or ### でコメントしている部分を vimgrep
command! M exec 'vimgrep "\(\/\/\/\|###\)" %'

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
autocmd BufWritePre * :%s/\s\+$//ge

""" es6
au BufNewFile,BufRead *.es6 set filetype=javascript

""" go
command! PlayGo :set ft=go | :0r ~/.templates/quickrun_go.go

""" fzf

nnoremap <C-p> :FZF<CR>

function! PjCD(e)
  exec 'cd ' . $GOPATH . '/src/' . a:e
endfunction

function! PjCDedit_(e)
  exec 'e ' . $GOPATH. '/src/' .a:e
endfunction

function! PjCDedit(e)
  let dirpath = $GOPATH . '/src/' . a:e
  call fzf#run({
        \ 'source': 'find '. dirpath. ' -maxdepth 10 -type f | sed -E "s/.*\/src\///g"',
        \ 'sink': function('PjCDedit_')
        \})
endfunction

command! Pj call fzf#run({
      \ 'source': 'find $GOPATH/src -maxdepth 3 -type d | sed -E "s/.*\/src\///g"',
      \ 'sink': function('PjCD')
      \ })
command! Pje call fzf#run({
      \ 'source': 'find $GOPATH/src -maxdepth 3 -type d | sed -E "s/.*\/src\///g"',
      \ 'sink': function('PjCDedit')
      \})

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


""""""" custom lib path for jedi-vim {{{
function LoadCurrentPathAsLibPath()
python << EOF
import os
import sys
import vim
cwd = vim.eval('getcwd()')
path = os.path.expanduser(os.path.join(cwd, 'site-packages'))
if not path in sys.path:
  sys.path.insert(1, path)

path = os.path.expanduser(os.path.join(cwd, 'libs', 'site-packages'))
if not path in sys.path:
  sys.path.insert(1, path)
EOF
endfunction

command! JediLoadLib call LoadCurrentPathAsLibPath()
""" }}}


""""""""""""""""""""""""""""""
filetype plugin indent on

