local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

lspconfig.tsserver.setup({})
lspconfig.eslint.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			bufnr = bufnr,
			command = "EslintFixAll",
		})
	end,
})
lspconfig.jdtls.setup({})
lspconfig.pyright.setup({
	settings = {
		pyright = {
			disableOrganizeImports = true,
		},
		python = {
			analysis = {
				ignore = { "*" },
			},
		},
	},
})
--
lspconfig.ruff_lsp.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.hoverProvider = false
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
	settings = {
		args = {},
	},
})
lspconfig.clangd.setup({
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})

lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
				},
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
})
