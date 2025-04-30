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
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",

	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
	},

	{
		"Mofiqul/dracula.nvim",
		lazy = false,
		cond = not vim.g.vscode,
	},
	{
		"norcalli/nvim-colorizer.lua",
		cond = not vim.g.vscode,
	},
	{
		"m-demare/hlargs.nvim",
		cond = not vim.g.vscode,
	},
	{
		"lewis6991/gitsigns.nvim",
		cond = not vim.g.vscode,
	},
	{
		"nvim-tree/nvim-web-devicons",
		cond = not vim.g.vscode,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		cond = not vim.g.vscode,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cond = not vim.g.vscode,
	},

	{
		"windwp/nvim-ts-autotag",
		cond = not vim.g.vscode,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		cond = not vim.g.vscode,
	},

	{
		"easymotion/vim-easymotion",
		cond = not vim.g.vscode,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		cond = not vim.g.vscode,
	},

	{
		"nvim-lua/popup.nvim",
		cond = not vim.g.vscode,
	},
	{
		"nvim-lua/plenary.nvim",
		cond = not vim.g.vscode,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		cond = not vim.g.vscode,
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		dependencies = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		cond = not vim.g.vscode,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		cond = not vim.g.vscode,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		cond = not vim.g.vscode,
	},

	{ "stevearc/conform.nvim", cond = not vim.g.vscode },
	{ "neovim/nvim-lspconfig", cond = not vim.g.vscode },

	{ "hrsh7th/cmp-nvim-lsp", cond = not vim.g.vscode },
	{ "hrsh7th/cmp-buffer", cond = not vim.g.vscode },
	{ "hrsh7th/cmp-path", cond = not vim.g.vscode },
	{ "hrsh7th/cmp-cmdline", cond = not vim.g.vscode },
	{ "hrsh7th/cmp-nvim-lsp-signature-help", cond = not vim.g.vscode },
	{ "hrsh7th/nvim-cmp", cond = not vim.g.vscode },

	{ "onsails/lspkind.nvim", cond = not vim.g.vscode },
	{ "nvimdev/lspsaga.nvim", cond = not vim.g.vscode },

	{ "L3MON4D3/LuaSnip", cond = not vim.g.vscode },
	{ "saadparwaiz1/cmp_luasnip", cond = not vim.g.vscode },

	{ "github/copilot.vim", cond = not vim.g.vscode },

	{ "vim-denops/denops.vim", cond = not vim.g.vscode },
	{
		"ramilito/winbar.nvim",
		event = "VimEnter", -- Alternatively, BufReadPre if we don't care about the empty file when starting with 'nvim'
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cond = not vim.g.vscode,
	},

	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		cond = not vim.g.vscode,
	},
})
