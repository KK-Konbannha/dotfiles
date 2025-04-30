local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- lua
		null_ls.builtins.formatting.stylua,

		-- java
		null_ls.builtins.formatting.google_java_format,

		-- javascript
		null_ls.builtins.formatting.prettier,

		-- c++
		null_ls.builtins.formatting.clang_format,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})
