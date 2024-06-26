local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		indicator = {
			style = "underline",
		},
	},
	highlights = {
		fill = {
			bg = "NONE",
		},
		background = {
			bg = "NONE",
		},
		tab = {
			bg = "NONE",
		},
		tab_selected = {
			bg = "NONE",
		},
		tab_separator = {
			bg = "NONE",
		},
		tab_separator_selected = {
			bg = "NONE",
		},
		tab_close = { bg = "NONE" },
		close_button = { bg = "NONE" },
		close_button_visible = { bg = "NONE" },
		close_button_selected = { bg = "NONE" },
		buffer_visible = { bg = "NONE" },
		buffer_selected = { bg = "NONE" },
		numbers = { bg = "NONE" },
		numbers_visible = { bg = "NONE" },
		numbers_selected = { bg = "NONE" },
		diagnostic = { bg = "NONE" },
		diagnostic_visible = { bg = "NONE" },
		diagnostic_selected = { bg = "NONE" },
		hint = { bg = "NONE" },
		hint_visible = { bg = "NONE" },
		hint_selected = { bg = "NONE" },
		hint_diagnostic = { bg = "NONE" },
		hint_diagnostic_visible = { bg = "NONE" },
		hint_diagnostic_selected = {
			bg = "NONE",
		},
		info = { bg = "NONE" },
		info_visible = { bg = "NONE" },
		info_selected = { bg = "NONE" },
		info_diagnostic = { bg = "NONE" },
		info_diagnostic_visible = { bg = "NONE" },
		info_diagnostic_selected = {
			bg = "NONE",
		},
		warning = { bg = "NONE" },
		warning_visible = { bg = "NONE" },
		warning_selected = { bg = "NONE" },
		warning_diagnostic = { bg = "NONE" },
		warning_diagnostic_visible = { bg = "NONE" },
		warning_diagnostic_selected = {
			bg = "NONE",
		},
		error = { bg = "NONE" },
		error_visible = { bg = "NONE" },
		error_selected = { bg = "NONE" },
		error_diagnostic = { bg = "NONE" },
		error_diagnostic_visible = { bg = "NONE" },
		error_diagnostic_selected = {
			bg = "NONE",
		},
		modified = { bg = "NONE" },
		modified_visible = { bg = "NONE" },
		modified_selected = { bg = "NONE" },
		duplicate_selected = { bg = "NONE" },
		duplicate_visible = { bg = "NONE" },
		duplicate = { bg = "NONE" },
		separator_selected = { bg = "NONE" },
		separator_visible = { bg = "NONE" },
		separator = { bg = "NONE" },
		indicator_visible = { bg = "NONE" },
		indicator_selected = { bg = "NONE" },
		pick_selected = { bg = "NONE" },
		pick_visible = { bg = "NONE" },
		pick = { bg = "NONE" },
		offset_separator = { bg = "NONE" },
		trunc_marker = { bg = "NONE" },
	},
})
