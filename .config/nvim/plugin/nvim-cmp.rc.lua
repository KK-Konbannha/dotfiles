local status, cmp = pcall(require, "cmp")
if not status then
	return
end
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
	}, {
		{ name = "nvim_lsp_signature_help" },
	}, {
		{ name = "orgmode" },
	}),
	formatting = {
		format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
	},
	window = {
		documentation = cmp.config.window.bordered(),
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
		}),
	},
})

vim.o.completeopt = "menu,menuone,noselect"
