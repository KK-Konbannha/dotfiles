local status, toggleterm = pcall(require, 'toggleterm')
if (not status) then return end


toggleterm.setup({
    open_mapping = [[<c-@>]],
    direction = 'float',
    float_opts = {
        width = math.floor(vim.o.columns * 0.8),
        height = math.floor(vim.o.lines * 0.7),
    }
})
