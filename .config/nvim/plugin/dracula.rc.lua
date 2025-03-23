local status, dracula = pcall(require, "dracula")
if not status then
	return
end

dracula.setup({
	transparent_bg = vim.g.neovide and false or true,
	colors = {
		comment = "#8888ff",
	},
	overrides = function(colors)
		return {
			CursorLine = {},
			TelescopeNormal = {},
			TelescopeSelection = {},
		}
	end,
})

vim.cmd([[colorscheme dracula]])
