" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8

set number " 行番号
syntax enable
set fileencodings=utf-8,sjis
set encoding=utf-8
set title
set autoindent
set nobackup
set hlsearch " 検索結果をハイライト
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=5
set ignorecase
set smartcase
set history=1000

set shell=zsh
set backupskip=/tmp/*

set et " タブ→スペースの変換
set smarttab

" インデント
filetype plugin indent on
set shiftwidth=4
set tabstop=4
set ai " Auto indent
set si " Smart indent
set nowrap " 折り返さない

" ファイル検索時サブフォルダまで探す
set path+=**
set wildignore+=*/node_modules/*

set modifiable
set write

" マウスの設定
set mouse=n

"}}}

" KeyMaps "{{{
" ---------------------------------------------------------------------
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" leaderをspacdにする
let mapleader = "\<Space>"

" Save with root permission
command! W w !sudo tee > /dev/null %

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

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

imap <C-j> <Plug>(skkeleton-enable)
cmap <C-j> <Plug>(skkeleton-enable)

"}}}

" Plugins "{{{
" ---------------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-denops/denops.vim' " deno
Plug 'vim-skk/denops-skkeleton.vim', { 'globalJisyo': '~/.skk/SKK-JISYO.L' } " skk

Plug 'tomasr/molokai' " color scheme
Plug 'itchyny/lightline.vim' " ステータスバー

Plug 'scrooloose/nerdtree' " nerdtree
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'nvie/vim-flake8' " flake8(python)
Plug 'psf/black' " black(python)
Plug 'mattn/emmet-vim' " emmet(html, cssなど)

Plug 'kat0h/bufpreview.vim' " preview markdown
Plug 'machakann/vim-sandwich' " sandwich

if has("nvim")
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'nvim-treesitter/nvim-treesitter' " high light
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc nvim
endif


call plug#end()

"}}}

" PluginsConfig "{{{
" ---------------------------------------------------------------------

" NerdConfig "{{{
" ---------------------------------------------------------------------
let NERDTreeShowHidden=1
let g:NERDTreeLimitedSyntax = 1

" nerdtreeにアイコンを表示する
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:webdevicons_enable_nerdtree = 1

"}}}

" python "{{{
" ---------------------------------------------------------------------
autocmd bufwritepre *.py execute ':Black'
let g:black_linelength = 79

"" pythonにてflake8をvim上及び保存時に使用
autocmd BufWritePost *.py call Flake8() " 保存時自動でflask8実行
let g:flake8_quickfix_location="topleft" " Quickfixの位置
let g:flake8_quickfix_height=7 " Quickfixの高さ
let g:flake8_show_in_gutter=1  " 左端にシンボルを表示
let g:flake8_show_in_file=1  " ファイル内にマークを表示

"}}}

" EmmetConfig "{{{
" ---------------------------------------------------------------------
let g:user_emmet_leader_key='<c-y>'

"}}}

" TreesitterConfig "{{{
" ---------------------------------------------------------------------
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

"}}}

" Coc "{{{
" ---------------------------------------------------------------------
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

"}}}

"}}}

" Looks "{{{
" ---------------------------------------------------------------------
" フォント
set guifont=HackGenNerd\ Console\ 12
" デフォルトエンコード
set encoding=UTF-8

" カラースキーム
colorscheme molokai
let g:molokai_original = 1
" 色の設定
set t_Co=256

"}}}

" vim: set foldmethod=marker foldlevel=0:
