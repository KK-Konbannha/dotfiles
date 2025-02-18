if vim.g.neovide then
	vim.g.neovide_transparency = 0.5
	vim.g.neovide_refresh_rate = 60
	vim.opt.linespace = 0
	vim.g.neovide_text_gamma = 0.0
	vim.g.neovide_text_contrast = 0.5
	vim.g.neovide_cursor_vfx_mode = "torpedo"

	vim.g.neovide_padding_top = 10
	vim.g.neovide_padding_bottom = 10
	vim.g.neovide_padding_right = 5
	vim.g.neovide_padding_left = 5

	vim.opt.winblend = 30
	vim.opt.pumblend = 30

	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	require("telescope").setup({
		defaults = {
			winblend = 70,
		},
	})
end
