if not vim.g.vscode then
	vim.g.mapleader = " "

	vim.keymap.set("i", "jj", "<ESC>")

	vim.keymap.set("n", "te", ":tabedit")

	vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
	vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

	vim.keymap.set("n", "<leader>nm", function()
		vim.lsp.buf.format({ async = true })
	end)

	-- neorg
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "norg",
		callback = function()
			vim.keymap.set("i", "<Tab>", "<Plug>(neorg.promo.promote.nested)", { buffer = true })
			vim.keymap.set("i", "<S-Tab>", "<Plug>(neorg.promo.demote.nested)", { buffer = true })
		end,
	})
end
