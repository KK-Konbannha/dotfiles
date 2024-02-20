local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"Mofiqul/dracula.nvim",
		lazy = false,
	},
	"nvim-treesitter/nvim-treesitter",
	"norcalli/nvim-colorizer.lua",
	"m-demare/hlargs.nvim",
	"lewis6991/gitsigns.nvim",
	"nvim-tree/nvim-web-devicons",
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	"nvim-treesitter/nvim-treesitter-textobjects",
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
	},

	"windwp/nvim-ts-autotag",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
	},

	"easymotion/vim-easymotion",

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},

	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},

	"nvimtools/none-ls.nvim",
})
