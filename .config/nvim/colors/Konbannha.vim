" Colorscheme initialization "{{{
" ---------------------------------------------------------------------
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="Konbannha"

"}}}

" Colorscheme "{{{
" ---------------------------------------------------------------------
hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#000000
hi iCursor         guifg=#000000
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd         guifg=#8F8F8F            
hi DiffChange      guifg=#89807D
hi DiffDelete      guifg=#960050
hi DiffText                                    gui=italic,bold

hi Directory       guifg=#7BEE7F               gui=bold
hi Error           guifg=#E6DB74
" hi ErrorMsg        guifg=#F92672               gui=bold
hi ErrorMsg        guifg=#000000               gui=bold
hi Exception       guifg=#7BEE7F               gui=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#7BEE7F
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#7BEE7F               gui=bold
hi PreProc         guifg=#7BEE7F
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#000000 guibg=#FFE792
" marks
hi SignColumn      guifg=#7BEE7F guibg=#232526
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#7E8E91               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#F92672               gui=bold
hi StatusLine      guifg=#455354 guibg=none
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#7BEAEE
hi Type            guifg=#7BEAEE               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#363862
hi Visual                        guibg=#363862
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E
hi TabLine         guifg=#808080 guibg=#1B1D1E gui=none

hi Normal          guifg=#F8F8F2 guibg=none
hi Comment         guifg=#75715E
hi CursorLine                    guibg=#292A44
hi CursorLineNr    guifg=#FD971F guibg=#626483 gui=none
" hi CursorLineNr    guifg=#F92672 guibg=#626483 gui=none
hi CursorColumn                  guibg=#626483
hi ColorColumn                   guibg=#626483
hi LineNr          guifg=#BCBCBC guibg=#212136
hi NonText         guifg=#75715E
hi SpecialKey      guifg=#75715E

"}}}
set background=dark
" vim: set foldmethod=marker foldlevel=0:
