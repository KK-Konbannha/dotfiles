local status, noice = pcall(require, "noice")
if not status then
	return
end

noice.setup({
	lsp = {
		hover = {
			enabled = false,
			silent = true,
		},
		signature = {
			enabled = false,
		},
	},
	presets = {
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = false,
	},
})
