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

set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
au BufNewFile,BufRead *.fish set filetype=fish

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

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
" map <Leader>i gg=<S-g><C-o><C-o>zz

" ESCを二回押すことでハイライトを消す
nmap <silent> <esc><esc> :nohlsearch<cr>

" spaceを二回押すことでハイライトを消す
nmap <Leader><Leader> :nohlsearch<cr>

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

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline

"}}}

" Plugins "{{{
" ---------------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

Plug 'vim-denops/denops.vim' " deno
Plug 'vim-skk/denops-skkeleton.vim' " skk

Plug 'thinca/vim-quickrun' " quickrun

Plug 'nvie/vim-flake8' " flake8(python)
Plug 'psf/black' " black(python)
Plug 'mattn/emmet-vim' " emmet(html, cssなど)

Plug 'kat0h/bufpreview.vim' " preview markdown
Plug 'machakann/vim-sandwich' " sandwich

if has("nvim")
    Plug 'hoob3rt/lualine.nvim' " ステータスバー
    Plug 'windwp/nvim-autopairs' " auto close
    Plug 'windwp/nvim-ts-autotag' " auto close
    Plug 'kyazdani42/nvim-web-devicons' " icon
    Plug 'nvim-treesitter/nvim-treesitter' " high light
    Plug 'nvim-treesitter/playground' " nvim treesitter config tool
    Plug 'p00f/nvim-ts-rainbow' " parentheses high light
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc nvim
endif


call plug#end()

"}}}

" PluginsConfig "{{{
" ---------------------------------------------------------------------

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

" SeiyaConfig(opacity) "{{{
" ---------------------------------------------------------------------
" let g:seiya_auto_enable=1

"}}}

" Skkeleton "{{{
" ---------------------------------------------------------------------
call skkeleton#config({ 'globalJisyo': '~/.skk/SKK-JISYO.L', 'userJisyo': '~/.skk/mine' })
call skkeleton#register_kanatable('rom', {
      \ 'jj': 'escape',
      \ })

"}}}

"}}}

" Looks "{{{
" ---------------------------------------------------------------------
" フォント
set guifont=HackGenNerd\ Console\ 12
" デフォルトエンコード
set encoding=UTF-8

" カラースキーム
set termguicolors
runtime ./colors/Konbannha.vim
colorscheme Konbannha
" 色の設定
set t_Co=256


"}}}

" LooksFunc "{{{
" ---------------------------------------------------------------------
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

"}}}

" vim: set foldmethod=marker foldlevel=0:
