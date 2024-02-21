local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.setup({})

vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "gd", "<Cmd>Lspsaga finder<CR>")
vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>")
