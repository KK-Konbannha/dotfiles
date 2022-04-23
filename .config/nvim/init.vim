" カラースキーム、tmuxでの色対策
" colorscheme elflord

" 行番号ひょうじ　
set number

" クリップボードとの連携on
set clipboard=unnamed

" ハイライトon
set hlsearch

" コマンド履歴の保存数
set history=10000

" タブの半角スペースの個数
set tabstop=4

set shiftwidth=0

" タブの代わりにスペースを使用
set expandtab

set smarttab

set shiftround

" 大文字と小文字を無視する
set ignorecase

" 検索パターンが大文字を含んでいたら'ignorecase'を上書きする。('ignorecase'オンのときのみ使われる)
set smartcase

" leaderをspacdにする
let mapleader = "\<Space>"

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" <Space>v で1行選択(\n含まず)
noremap <Leader>v 0v$h

" <Space>y で改行なしで1行コピー（\n を含まずに yy）
noremap <Leader>y 0v$hy

" 最初にヤンクした文字列を繰り返しペースト
vnoremap <Leader>p "0p

" <Space>i でコードをインデント整形
map <Leader>i gg=<S-g><C-o><C-o>zz

" ESCを二回押すことでハイライトを消す
nmap <silent> <esc><esc> :nohlsearch<cr>

" spaceを二回押すことでハイライトを消す
nmap <Leader><Leader> :nohlsearch<cr>

" nerdtreeをC-eで起動できるように
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" grepのときにquickfix-windowで開く
autocmd QuickFixCmdPost *grep* cwindow

" nerdの設定
let NERDTreeShowHidden=1
let g:NERDTreeLimitedSyntax = 1

set modifiable
set write
"dein Scripts-----------------------------
if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/./repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state($HOME . '/.cache/dein/.')
    call dein#begin($HOME . '/.cache/dein/.')

    " Let dein manage dein
    " Required:
    call dein#add($HOME . '/.cache/dein/./repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here like this:
    "call dein#add('Shougo/unite.vim')
    "call dein#add('Shougo/neosnippet.vim')
    "call dein#add('Shougo/neosnippet-snippets')
    call dein#add('itchyny/lightline.vim')

    call dein#add('ryanoasis/vim-devicons')
    call dein#add('scrooloose/nerdtree')
    call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
    
    call dein#add('davidhalter/jedi-vim')
    call dein#add('nvie/vim-flake8')
    call dein#add('psf/black', { 'rev': 'ce14fa8b497bae2b50ec48b3bd7022573a59cdb1' })

    call dein#add('mattn/emmet-vim')

    call dein#add('skanehira/preview-markdown.vim')
    call dein#add('MichaelMure/mdr')

    call dein#add('rhysd/vim-clang-format')
    "call dein#add('kana/vim-operator-user')
    "call dein#add('justmao945/vim-clang')

    call dein#add('w0rp/ale')


    call dein#add('posva/vim-vue')

    call dein#add('tomasr/molokai')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

"End dein Scripts-------------------------

set laststatus=2

autocmd bufwritepre *.py execute ':Black'
let g:black_linelength = 79

" pythonにてflake8をvim上及び保存時に使用
autocmd BufWritePost *.py call Flake8() " 保存時自動でflask8実行
let g:flake8_quickfix_location="topleft" " Quickfixの位置
let g:flake8_quickfix_height=7 " Quickfixの高さ
let g:flake8_show_in_gutter=1  " 左端にシンボルを表示
let g:flake8_show_in_file=1  " ファイル内にマークを表示

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_nerdtree = 1

let g:user_emmet_leader_key='<c-y>'

let g:molokai_original = 1

"let g:neosnippet#snippets_directory='~/.vim/my_snippet'

autocmd FileType c,cpp ClangFormatAutoEnable

autocmd FileType vue syntax sync fromstart

"vueのコメントアウト用設定
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=UTF-8

colorscheme molokai
set t_Co=256
set mouse=n
