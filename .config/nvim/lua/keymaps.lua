vim.g.mapleader = ' '

vim.keymap.set('i', 'jj', '<ESC>')

vim.keymap.set('n', 'te', ':tabedit')

vim.keymap.set('n', 'ss', ':split<Return><C-w>w')
vim.keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
