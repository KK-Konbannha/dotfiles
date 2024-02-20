local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
    {
        'Mofiqul/dracula.nvim',
        lazy = false,
    },
    'nvim-treesitter/nvim-treesitter',
    'norcalli/nvim-colorizer.lua',
    'm-demare/hlargs.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    'nvim-treesitter/nvim-treesitter-textobjects',
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
    },

    'windwp/nvim-ts-autotag',
    {
    'windwp/nvim-autopairs',
        event = "InsertEnter",
    },

    'easymotion/vim-easymotion',

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true
    },
})
