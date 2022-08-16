local status, dracula = pcall(require, 'dracula')
if (not status) then return end

vim.cmd [[colorscheme dracula]]
