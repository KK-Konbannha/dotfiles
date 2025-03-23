local status, neorg = pcall(require, "neorg")
if not status then
	return
end

neorg.setup({
	load = {
		["core.defaults"] = {},
		["core.concealer"] = {},
		["core.export"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
				default_workspace = "notes",
			},
		},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
	},
})
