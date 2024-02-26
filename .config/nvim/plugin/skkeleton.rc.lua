vim.api.nvim_create_autocmd("User", {
	pattern = "skkeleton-initialize-pre",
	callback = function()
		vim.fn["skkeleton#config"]({
			globalDictionaries = { "~/.skk/SKK-JISYO.L" },
			userDictionary = "~/.skk/mine",
		})
		vim.fn["skkeleton#register_kanatable"]("rom", {
			jj = "escape",
		})
	end,
})
