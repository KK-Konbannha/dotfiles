local status, dracula = pcall(require, "dracula")
if (not status) then return end
dracula.setup {
  transparent_bg = true
}

vim.cmd [[colorscheme dracula]]

vim.api.nvim_command("highlight TelescopeNormal guifg=#F8F8F2 guibg=NONE gui=NONE gui=NONE")
