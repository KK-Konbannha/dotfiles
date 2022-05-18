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

" ステータスバー
Plug 'itchyny/lightline.vim'

" deno
Plug 'vim-denops/denops.vim'

" nerdtree関連
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" coc nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" python関連
Plug 'nvie/vim-flake8'
Plug 'psf/black'

" emmet(html, cssなど)
Plug 'mattn/emmet-vim'

" markdown
Plug 'kat0h/bufpreview.vim'

" c
" Plug 'rhysd/vim-clang-format'

" sandwich
Plug 'machakann/vim-sandwich'

" color scheme
Plug 'tomasr/molokai'

" high light
Plug 'nvim-treesitter/nvim-treesitter'

" わからん…
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()
" ---------------------------------------------------------------------

set laststatus=2

autocmd bufwritepre *.py execute ':Black'
let g:black_linelength = 79

"" pythonにてflake8をvim上及び保存時に使用
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

"" treesitter
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
  },
  highlight = {
    enable = true,
  },
}
EOF

" Coc------------------------------------------------------------------
" coc-extesions
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-tsserver',
            \ 'coc-prettier',
            \ 'coc-eslint',
            \ 'coc-jedi',
            \ ]

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" コード間の移動コマンド
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
    let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

" ---------------------------------------------------------------------


" 見た目---------------------------------------------------------------
" フォント
set guifont=HackGenNerd\ Console\ 12
" デフォルトエンコード
set encoding=UTF-8

" カラースキーム
colorscheme molokai
let g:molokai_original = 1
" 色の設定
set t_Co=256

" マウスの設定
set mouse=n
