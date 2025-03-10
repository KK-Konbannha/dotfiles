local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
		disable = {},
	},
	indent = {
		enable = true,
		disable = {},
	},
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"java",
		"lua",
		"python",
		"html",
		"css",
		"scss",
		"javascript",
		"typescript",
		"tsx",
		"json",
		"toml",
		"yaml",
		"markdown",
		"markdown_inline",
		"gitignore",
		"dockerfile",
		"go",
		"rust",
		"norg",
	},
	autotag = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,

			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},

			include_surrounding_whitespace = true,
		},
	},
})
