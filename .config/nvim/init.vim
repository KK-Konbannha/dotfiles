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

"// PLUGIN SETTINGS ---------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'
Plug 'psf/black', { 'rev': 'ce14fa8b497bae2b50ec48b3bd7022573a59cdb1' }

Plug 'mattn/emmet-vim'

Plug 'skanehira/preview-markdown.vim'
Plug 'MichaelMure/mdr'

Plug 'rhysd/vim-clang-format'

Plug 'w0rp/ale'


Plug 'posva/vim-vue'

Plug 'tomasr/molokai'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()
" ---------------------------------------------------------------------

set laststatus=2

autocmd bufwritepre *.py execute ':Black'
let g:black_linelength = 79

" pythonにてflake8をvim上及び保存時に使用
autocmd BufWritePost *.py call Flake8() " 保存時自動でflask8実行
let g:flake8_quickfix_location="topleft" " Quickfixの位置
let g:flake8_quickfix_height=7 " Quickfixの高さ
let g:flake8_show_in_gutter=1  " 左端にシンボルを表示
let g:flake8_show_in_file=1  " ファイル内にマークを表示

" nerdtreeにアイコンを表示する
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_nerdtree = 1

" emmetの設定
let g:user_emmet_leader_key='<c-y>'

" 見た目-----------------------------------------------------------------
" フォント
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
" デフォルトエンコード
set encoding=UTF-8

" カラースキーム
colorscheme molokai
let g:molokai_original = 1
" 色の設定
set t_Co=256

" マウスの設定
set mouse=n
