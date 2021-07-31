"""""""" Vim configs {{{

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
set colorcolumn=120
set norelativenumber
set showtabline=2
" ref: completion-nvim
" set completeopt-=preview
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set scl=auto:5
set updatetime=250

set modeline
set modelines=4
set inccommand=nosplit
set viminfo=!,\'100,\"5000,s50,h,n~/.config/nvim/viminfo
set sh=bash

"" neovim だと以下設定だとおかしくなる
" set shellcmdflag=-ic
set clipboard+=unnamedplus
" set ambiwidth=double

" mapleaderに設定してあるものが <Leader> に置き換わる
" map 時の <Leader> は評価時の値がそのまま利用されるので vimrc の先頭のほうで書いておく
let mapleader = "\<Space>"

" The g:vimsyn_embed option allows users to select what, if any, types of
" embedded script highlighting they wish to have. >
"
"    g:vimsyn_embed == 0      : disable (don't embed any scripts)
"    g:vimsyn_embed == 'lPr'  : support embedded lua, python and ruby
let g:vimsyn_embed='lPr'

"""""""" }}}

filetype off

"""""""" Plugins (vim-plug) {{{

call plug#begin('~/.config/nvim/plugged')

" Color scheme
Plug 'sainnhe/sonokai'

" Lua library
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'RishabhRD/popfix'

" Make vim to IDE
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'kassio/neoterm'
Plug 'glepnir/lspsaga.nvim'
Plug 'ray-x/lsp_signature.nvim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-fugitive'

" Motion/Cursor
Plug 'Lokaltog/vim-easymotion'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'cohama/lexima.vim'
Plug 'justinmk/vim-sneak'

" Appearance
Plug 'LeafCage/foldCC.vim'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
Plug 'RRethy/vim-illuminate'

" Tools
Plug 'mattn/webapi-vim' | Plug 'mattn/gist-vim'

" Enhancement
Plug 'kana/vim-submode'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tyru/caw.vim'
Plug 'kana/vim-fakeclip'

" Utils
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
Plug 'thinca/vim-quickrun', { 'on': 'QuickRun' }
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'mileszs/ack.vim', {'on': 'Ack' }
Plug 'RishabhRD/nvim-cheat.sh'
Plug 'brooth/far.vim'

" Prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" HTML
Plug 'mattn/emmet-vim', { 'for': ['html','eruby'] }

" Markdown
Plug 'tpope/vim-markdown'

" TypeScript
Plug 'leafgarland/typescript-vim'  " syntax highlight ができなかったので

" Other
Plug 'elzr/vim-json'

call plug#end()

"""""""" }}}

"""""""" Color scheme {{{

augroup color_scheme
  autocmd!
  """ カラースキーム適用時に実行される
  autocmd ColorScheme * highlight Visual term=reverse cterm=reverse gui=reverse
augroup end

" Important!!
if has('termguicolors')
  set termguicolors
endif

" The configuration options should be placed before `colorscheme sonokai`.
" let g:sonokai_style = 'maia'
" let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
let g:sonokai_diagnostic_line_highlight = 1

colorscheme sonokai

""""""""}}}

"""""""" LSP {{{

lua << EOF
local on_attach = function (client, bufnr)
  local function keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opt = {noremap=true, silent=true}

  keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opt)
  keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
  keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opt)
  keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
  keymap('n', 'gR', "<cmd>lua require('lspsaga.rename').rename()<CR>", opt)
  keymap('n', 'gk', "<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>", opt)
  keymap('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opt)
  keymap('n', 'gs', "<cmd>lua require('telescope.builtin').treesitter()<CR>", opt)
  keymap('n', 'ga', "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opt)
  keymap('n', 'ga', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opt)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup auto_lsp_document_formatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
      augroup END
    ]], false)
  end

  require('completion').on_attach(client)
  require('illuminate').on_attach(client)
  require('lsp_signature').on_attach()
end

local disable_formatting_on_init = function(client, initialize_result)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
end

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {
  on_attach = on_attach ,
  on_init = disable_formatting_on_init,
}
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = disable_formatting_on_init,
}
lspconfig.html.setup {
  on_attach = on_attach,
  on_init = disable_formatting_on_init,
}
lspconfig.cssls.setup {
  on_attach = on_attach,
  on_init = disable_formatting_on_init,
}
lspconfig.vimls.setup { on_attach = on_attach }
lspconfig.gopls.setup { on_attach = on_attach }
lspconfig.terraformls.setup {
  filetypes = {"terraform", "tf", "hcl"},
  on_attach = on_attach
}
lspconfig.yamlls.setup { on_attach = on_attach }
lspconfig.bashls.setup { on_attach = on_attach }

local on_attach_efm = function(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup auto_lsp_document_formatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
      augroup END
    ]], false)
  end
end

-- ref: https://github.com/elianiva/dotfiles/blob/235c54445268f5838ac4a03669fde4d0a4738fea/nvim/.config/nvim/lua/modules/lsp/init.lua#L89-L108
lspconfig.efm.setup {
  on_attach = on_attach_efm,
  init_options = {documentFormatting = true},
  filetypes = {"python", "javascript", "typescript", "html", "css"},
  settings = {
    rootMarkers = {"package.json", ".git/"},
    languages = {
      javascript = {
        {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
      },
      typescript = {
        {formatCommand = "prettier --stdin-filepath ${INPUT}", formatStdin = true}
      },
      html = {
        {formatCommand = "prettier --parser html --stdin-filepath ${INPUT}", formatStdin = true}
      },
      css = {
        {formatCommand = "prettier --parser css --stdin-filepath ${INPUT}", formatStdin = true}
      },
      python = {
        {formatCommand = "black -", formatStdin = true}
      },
    }
  }
}

--
-- disable diagnostics with virtual text
--
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

EOF

"""""""" }}}

"""""""" Plugin Settings {{{

"""" nvim-treesitter {{{

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF

" }}}
"""" NERDTree {{{

let NERDTreeShowHidden = 1

""" }}}
"""" Lightline {{{

" https://github.com/itchyny/lightline.vim
" 以下は https://qiita.com/yuyuchu3333/items/20a0acfe7e0d0e167ccc を参考とした

let g:lightline = {
  \ 'separator': { 'left': '', 'right': ''  },
  \ 'subseparator': { 'left': '', 'right': ''  },
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['fugitive', 'gitversion', 'gitgutter', 'filename'],
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
  \   'gitversion': 'MyGitversion',
  \   'mode': 'MyMode',
  \   'charcode': 'MyCharCode',
  \   'gitgutter': 'MyGitGutter',
  \ }
\ }

let g:lightline.colorscheme = 'sonokai'

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

" https://github.com/itchyny/lightline.vim/issues/172
function! MyGitversion()
  let fullname = expand('%')
  let gitversion = ''
  if fullname =~? 'fugitive://.*/\.git//0/.*'
      let gitversion = 'git index'
  elseif fullname =~? 'fugitive://.*/\.git//2/.*'
      let gitversion = 'git target'
  elseif fullname =~? 'fugitive://.*/\.git//3/.*'
      let gitversion = 'git merge'
  elseif &diff == 1
      let gitversion = 'working copy'
  endif
  return gitversion
endfunction

""" }}}
"""" EasyMotion {{{

let g:EasyMotion_do_mapping = 0 "Disable default mappings

""" }}}
"""" sneak-vim {{{

let g:sneak#s_next = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F

"""" }}}
"""" IndentLine {{{

let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#505050'
let g:indentLine_char = '¦'

""" }}}
"""" vim-gitgutter {{{

let g:gitgutter_enabled = 1
let g:gitgutter_sign_added = '▐'
let g:gitgutter_sign_modified = '▐'
let g:gitgutter_sign_removed = '▐'
let g:gitgutter_async = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=237
highlight GitGutterAdd    guifg=#5fa4b3 ctermfg=110
highlight GitGutterChange guifg=#bbbb00 ctermfg=179
highlight GitGutterDelete guifg=#ff2222 ctermfg=203
let g:gitgutter_set_sign_backgrounds = 1

" highlight GitGutterAdd    ctermfg=2
" " ctermbg=237
" highlight GitGutterChange ctermfg=3
" " ctermbg=237
" highlight GitGutterDelete ctermfg=1
" " ctermbg=237

command! GGQuickFix :GitGutterQuickFix | cw
command! GGSHunk :GitGutterStageHunk
command! GGUHunk :GitGutterUndoHunk

" function! GGGetLocation()
"   let cmd = g:gitgutter_git_executable.' '.g:gitgutter_git_args.' rev-parse --show-cdup'
"   let path_to_repo = get(systemlist(cmd), 0, '')
"   if !empty(path_to_repo) && path_to_repo[-1:] != '/'
"     let path_to_repo .= '/'
"   endif
"
"   let locations = []
"   let cmd = g:gitgutter_git_executable.' '.g:gitgutter_git_args.' --no-pager'.
"         \ ' diff --no-ext-diff --no-color -U0'.
"         \ ' --src-prefix=a/'.path_to_repo.' --dst-prefix=b/'.path_to_repo.' '.
"         \ g:gitgutter_diff_args. ' '. g:gitgutter_diff_base
"   let diff = systemlist(cmd)
"   let lnum = 0
"   for line in diff
"     if line =~ '^diff --git [^"]'
"       let paths = line[11:]
"       let mid = (len(paths) - 1) / 2
"       let [fnamel, fnamer] = [paths[:mid-1], paths[mid+1:]]
"       let fname = fnamel ==# fnamer ? fnamel : fnamel[2:]
"     elseif line =~ '^diff --git "'
"       let [_, fnamel, _, fnamer] = split(line, '"')
"       let fname = fnamel ==# fnamer ? fnamel : fnamel[2:]
"     elseif line =~ '^@@'
"       let lnum = matchlist(line, '+\(\d\+\)')[1]
"     elseif lnum > 0
"       call add(locations, fname .':'. lnum .':'. line)
"       let lnum = 0
"     endif
"   endfor
"   return locations
" endfunction
"
" function! s:GGOpenFile(e)
"   let words = split(a:e, ':')
"   exec 'e +' . words[1] . ' ' .words[0]
" endfunction
"
" let s:GGHunksPreviewCommand = 'sh -lc "cat -n {1} | grep --color=always -B10 -A100 -E '.  "'^ *{2}.*'" . '"'
" command! GGHunks call fzf#run(fzf#wrap({
"      \ 'source': GGGetLocation(),
"      \ 'sink': function('<sid>GGOpenFile'),
"      \ 'options': ['--ansi', '-d:', '--preview', s:GGHunksPreviewCommand]
"      \ }))


""" }}}
"""" vim-submode {{{
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
"""" gist.vim {{{
" https://github.com/mattn/vim-gist
let g:gist_show_privates = 1
let g:gist_post_privates = 1
""" }}}
"""" quickrun {{{
" https://github.com/thinca/vim-quickrun
" https://github.com/thinca/vim-quickrun/blob/master/doc/quickrun.jax
" 設定はデフォルトを利用するので以下はコメントアウト
" let g:quickrun_config = {}
""" }}}
"""" 全角スペースのハイライト {{{
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
"""" FoldCC {{{
set foldtext=FoldCCtext()
set fillchars=vert:\|
""" }}}
"""" fzf {{{
" let g:fzf_files_options =
"   \ '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'
"
" nnoremap <C-p> :Files<CR>
"
" nnoremap <Leader>r :History<CR>
"
" nnoremap <Leader>b :Buffers<CR>
"
" nnoremap <Leader>S :Lines<CR>
"
" let g:fzf_colors = {
" \ 'border':  ['fg', 'Comment']
" \ }
"
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   "rg --column --line-number --hidden --no-heading --color=always --smart-case -g '!{node_modules,.git}' -- ".shellescape(<q-args>), 1,
"   \   fzf#vim#with_preview(), <bang>0)
"
" nnoremap <Leader>a :Rg<Space>
"
" function! s:pjopen(e)
"   exec 'e ' . $GOPATH. '/src/' .a:e
" endfunction
" command! Pj call fzf#run({
"      \ 'source': 'find $GOPATH/src -maxdepth 4 -type d | sed -E "s/.*\/src\///g"',
"      \ 'sink': function('<sid>pjopen'),
"      \ 'down': '40%' })
""" }}}
"""" ack.vim {{{
let g:ackprg = "rg --column --line-number --hidden --ignore-case --no-heading -g '!{node_modules,.git}'"
cnoreabbrev Ack Ack!
" nnoremap <Leader>a :Ack!<Space>
let g:ack_qhandler = "botright copen 30"
""" }}}
"""" git-messenger.vim {{{
let g:git_messenger_include_diff = "current"
let g:git_messenger_close_on_cursor_moved = v:false
let g:git_messenger_always_into_popup = v:true
""" }}}
"""" vim-illuminate {{{
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord ctermbg=237 guibg=Grey26
augroup END
""" }}}
"""" lspsaga {{{
lua << EOF
local lspsaga = require('lspsaga')
lspsaga.init_lsp_saga {
  -- use_saga_diagnostic_sign = true
  error_sign = 'E▸',
  warn_sign = 'W▸',
  hint_sign = 'H▸',
  infor_sign = 'I▸',
  dianostic_header_icon = ' ▸ ',
  code_action_icon = ' ',
  -- code_action_prompt = {
  --   enable = true,
  --   sign = true,
  --   sign_priority = 20,
  --   virtual_text = true,
  -- },
  finder_definition_icon = '▸  ',
  finder_reference_icon = '▸  ',
  -- max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
  -- finder_action_keys = {
  --   open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
  -- },
  -- code_action_keys = {
  --   quit = 'q',exec = '<CR>'
  -- },
  -- rename_action_keys = {
  --   quit = '<C-c>',exec = '<CR>'  -- quit can be a table
  -- },
  definition_preview_icon = '▸  '
  -- "single" "double" "round" "plus"
  -- border_style = "single"
  -- rename_prompt_prefix = '➤',
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = {metals = {'sbt', 'scala'}}
  -- server_filetype_map = {}
}
EOF
"""" }}}
"""" far.vim {{{
let g:far#source='rg'
let g:far#collapse_result=1
"""" }}}
"""" telescope.nvim {{{
lua << EOF
local picker_settings = { theme = "ivy", layout_config = {height = 30}  }

require('telescope').setup({
  pickers = {
    buffers = picker_settings,
    find_files = picker_settings,
    treesitter = picker_settings,
    lsp_references = picker_settings,
    current_buffer_fuzzy_find = picker_settings,
    live_grep = picker_settings,
    git_bcommits = picker_settings,
  },
})
EOF
"""" }}}

"""""""" }}}

"""""""" Language Settings {{{

"""" vim-markdown {{{
let g:markdown_syntax_conceal = 0
let g:markdown_folding = 1
""" }}}
"""" vim-json {{{
let g:vim_json_syntax_conceal = 0
augroup VimJson
  autocmd!
  autocmd BufNewFile,BufReadPost *.json set conceallevel=0
augroup END
""" }}}
"""" javascript {{{
augroup MyJavascript
  autocmd!
  autocmd BufNewFile,BufRead *.es6 set filetype=javascript
augroup END
"""}}}
"""" go {{{
command! PlayGo :set ft=go | :0r ~/.templates/quickrun_go.go
"""}}}
"""" python {{{
" pyenv
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
let g:python_host_prog = $PYENV_ROOT . '/shims/python'
"""}}}

"""""""" }}}

"""""""" Command {{{

command! Vimrc :e ~/.config/nvim/init.vim
command! Reload :source ~/.config/nvim/init.vim
" current buffer を vimgrep
command! -nargs=1 S exec 'vimgrep '. string(<q-args>). ' %'

" 編集中のファイルをrename
command! -nargs=+ -bang -complete=file Rename let pbnr=fnamemodify(bufname('%'), ':p')|exec 'f '.escape(<q-args>, ' ')|w<bang>|call delete(pbnr)

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

command! Keymaps :lua require('telescope.builtin').keymaps{}

command! Ls :lua require('telescope.builtin').buffers()

command! BufHist :lua require('telescope.builtin').git_bcommits()

"""""""" }}}

"""""""" Auto Command {{{

"""" Auto QuickFix {{{
" grep したら QuickFixを自動で開く
augroup MyGrepOpen
  autocmd!
  autocmd QuickFixCmdPost vimgrep cw
augroup END
"""" }}}

"""" {{{
" 保存時に行末の空白を除去する
augroup MyOthers
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//ge
augroup END
"""" }}}

"""""""" }}}

"""""""" Keymaps {{{

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

""" gj(k) と j(k) を入れかえ
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk K

""" NERTTree
noremap nt :NERDTreeToggle <CR>

""" keymap
nmap s <Plug>(easymotion-s2)

""" NERDCommenter
nmap ,, <Plug>(caw:hatpos:toggle)
vmap ,, <Plug>(caw:hatpos:toggle)

""" Telescope
nnoremap <C-p> <cmd>Telescope find_files<CR>
nnoremap <Leader>S <cmd>lua require('telescope.builtin').live_grep()<CR>
nnoremap <Leader>s <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>

"""""""" }}}

"""""""" Highlight {{{

hi ColorColumn guibg=Grey25
hi CursorLine guibg=Grey25

" hi DiffAdd ctermfg=235 ctermbg=110 guifg=#2c2e34 guibg=#76cce0
" hi DiffChange ctermfg=235 ctermbg=179 guifg=#2c2e34 guibg=#e7c664
" hi DiffDelete ctermfg=235 ctermbg=203 guifg=#fc5d7c guibg=#fc5d7c
hi DiffAdd ctermfg=235 ctermbg=110 guifg=#2c2e34 guibg=#5fa4b3
hi DiffChange ctermfg=235 ctermbg=179 guifg=#2c2e34 guibg=#ccaf58
hi DiffDelete ctermfg=235 ctermbg=203 guifg=#fc5d7c guibg=#cc4b66
hi DiffText cterm=bold,underline gui=bold,underline ctermfg=235 ctermbg=250 guifg=#2c2e34 guibg=#e2e2e3

" 上記特殊文字の文字色
highlight SpecialKey term=underline ctermfg=darkgray guifg=darkgray

"""""""" }}}

"""""""" MySettings {{{

""" Terminal {{{
augroup MyTerminal
  autocmd!
  autocmd BufWinEnter,WinEnter term://* startinsert
augroup END
tnoremap <ESC> <C-\><C-n>
"}}}

""" MyTemplate {{{
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
"}}}

""" MyCheatsheet {{{
function! CheatSheetFile(A, L, P)
  let filelist = expand($HOME."/.cheatsheets/".a:A."*")
  if filelist =~ '\*'
    return []
  endif
  let splitted = split(filelist, "\n")
  let splitted_and_gsubed = map(splitted, "substitute(v:val, '.*\/\.cheatsheets\/', '', 'g')")
  return splitted_and_gsubed
endfunction

command! -nargs=1 -complete=customlist,CheatSheetFile CheatSheet :e ~/.cheatsheets/<args>
"}}}

""" Yankhook {{{
augroup yankhook
  autocmd!
  autocmd TextYankPost * :wv
  autocmd WinEnter,TabEnter * :rv!
augroup end
" }}}

""" Other settings {{{
" backupskip は backup を作らないファイルを指定するが
" mac で crontab -e でvimを使う場合はこの設定が必要ぽい ??
set backupskip=/tmp/*,/private/tmp/*

""" カーソル
" カーソル形状がすぐに元に戻らないのでタイムアウト時間を調整
set ttimeoutlen=10

""" tab文字等可視化
" タブ文字を CTRL-I で表示し、行末に $ で表示する。（有効:list/無効:nolist）
set list
" Listモード (訳注: オプション 'list' がオンのとき) に使われる文字を設定する。
set listchars=tab:\▸\       " tab

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

"}}}

"""""""" }}}

"""""""" vimrc_extra {{{

if filereadable(expand($VIMRC_EXTRA))
  source $VIMRC_EXTRA
endif

"""""""" }}}

filetype plugin indent on

" vim: foldmethod=marker foldlevel=0
