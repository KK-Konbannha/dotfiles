local status, lspconfig = pcall(require, "lspconfig")
if not status then
	return
end

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.jdtls.setup({})
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
