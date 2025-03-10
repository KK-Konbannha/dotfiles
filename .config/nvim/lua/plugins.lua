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

	"nvim-tree/nvim-tree.lua",

	"nvimtools/none-ls.nvim",
	"neovim/nvim-lspconfig",

	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"hrsh7th/nvim-cmp",

	"onsails/lspkind.nvim",
	"nvimdev/lspsaga.nvim",

	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",

	"github/copilot.vim",

	"vim-denops/denops.vim",
	"vim-skk/skkeleton",
	"delphinus/skkeleton_indicator.nvim",
	{
		"ramilito/winbar.nvim",
		event = "VimEnter", -- Alternatively, BufReadPre if we don't care about the empty file when starting with 'nvim'
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
	},
	{
		"akinsho/org-bullets.nvim",
		event = "VeryLazy",
		ft = { "org" },
	},

	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
	},
})
