vim.cmd("autocmd!")

if not vim.g.vscode then
	vim.scriptencoding = "utf-8"
	vim.opt.encoding = "utf-8"
	vim.opt.fileencoding = "utf-8"

	vim.wo.number = true
	vim.wo.relativenumber = true

	vim.opt.title = true
	vim.opt.autoindent = true
	vim.opt.smartindent = true
	vim.opt.hlsearch = true
	vim.opt.backup = false
	vim.opt.showcmd = true
	vim.opt.cmdheight = 1
	vim.opt.laststatus = 3
	vim.opt.expandtab = true
	vim.opt.scrolloff = 10
	vim.opt.shell = "zsh"
	vim.opt.inccommand = "split"
	vim.opt.ignorecase = true
	vim.opt.smarttab = true
	vim.opt.breakindent = true
	vim.opt.shiftwidth = 2
	vim.opt.tabstop = 2
	vim.opt.wrap = true
	vim.opt.backspace = { "start", "eol", "indent" }
	vim.opt.path:append({ "*" })
	vim.opt.wildignore:append({
		"*/node_modules/*",
		"*/.git/*",
		"*/.DS_Store",
		"*/.vscode/*",
		"*/__pycache__/*",
		"*.pyc",
	})

	vim.cmd([[let &t_Cs = '\e[4:3m']])
	vim.cmd([[let &t_Ce = '\e[4:0m']])

	vim.opt.cursorline = true
	vim.opt.termguicolors = true
	vim.opt.winblend = 0
	vim.opt.wildoptions = "pum"
	vim.opt.pumblend = 0
	vim.opt.background = "dark"

	vim.opt.conceallevel = 3
end

vim.opt.clipboard:append("unnamedplus")
