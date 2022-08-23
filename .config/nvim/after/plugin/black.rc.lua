vim.g.black_linelength = 79

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.py" },
  callback = function()
    vim.api.nvim_command("Black")
  end,
})
