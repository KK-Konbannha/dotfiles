vim.api.nvim_command("call skkeleton#config({ 'globalJisyo': '~/.skk/SKK-JISYO.L', 'userJisyo': '~/.skk/mine' })")
vim.api.nvim_command("call skkeleton#register_kanatable('rom', { 'jj': 'escape', }) ")

vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-enable)')
vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-enable)')