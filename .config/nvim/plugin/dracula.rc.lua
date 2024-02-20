local status, dracula = pcall(require, 'dracula')
if (not status) then return end

dracula.setup {
    transparent_bg = true,
    overrides = function (colors)
     return {
        CursorLine = {},
        BufferLineFill = {},
        BufferLineBufferSelected = {},
        TelescopeNormal = {},
    }
    end,
}

vim.cmd [[colorscheme dracula]]

