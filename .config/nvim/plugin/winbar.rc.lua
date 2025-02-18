local status, winbar = pcall(require, "winbar")
if not status then
	return
end

if not vim.g.neovide then
	return
end

winbar.setup({
	-- your configuration comes here, for example:
	icons = true,
	diagnostics = true,
	buf_modified = true,
	buf_modified_symbol = "M",
	-- or use an icon
	-- buf_modified_symbol = "●"
	dim_inactive = {
		enabled = false,
		highlight = "WinbarNC",
		icons = true, -- whether to dim the icons
		name = true, -- whether to dim the name
	},
})
