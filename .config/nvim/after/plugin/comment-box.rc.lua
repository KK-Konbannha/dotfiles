local status, cb = pcall(require, "comment-box")
if (not status) then return end

local keymap = vim.keymap.set

-- left aligned fixed size box with left aligned text
keymap({ "n", "v" }, "<Leader>bb", cb.cbox, {})
-- centered adapted box with centered text
keymap({ "n", "v" }, "<Leader>bc", cb.accbox, {})
-- left aligned adapted box with centered text
keymap({ "n", "v" }, "<Leader>cc", cb.acbox, {})