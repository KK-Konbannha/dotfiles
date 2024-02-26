vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<ESC>")

vim.keymap.set("n", "te", ":tabedit")

vim.keymap.set("n", "ss", ":split<Return><C-w>w")
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")

vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

-- github copilot
vim.keymap.set("n", "<leader>ge", ":Copilot enable<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gd", ":Copilot disable<CR>", { noremap = true, silent = true })

-- skkeleton
vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-enable)")
