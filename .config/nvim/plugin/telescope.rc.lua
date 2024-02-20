local status, telescope = pcall(require, "telescope")
if not status then
	return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
			hidden = true,
			mappings = {
				["i"] = {},
				["n"] = {},
			},
		},
		media_files = {
			filetypes = { "png", "jpg", "jpeg", "webp" },
			find_cmd = "rg",
		},
	},
})

telescope.load_extension("file_browser")
telescope.load_extension("media_files")

vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({
		no_ignore = false,
		hidden = true,
	})
end)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.keymap.set("n", "<c-k>", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		respect_gitignore = false,
		hidden = true,
	})
end)
