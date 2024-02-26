local status, toggleterm = pcall(require, "toggleterm")
if not status then
	return
end

toggleterm.setup({
	open_mapping = [[<c-@>]],
	direction = "float",
	float_opts = {
		width = math.floor(vim.o.columns * 0.8),
		height = math.floor(vim.o.lines * 0.7),
	},
})

-- cpp

function _G.compile_and_run_cpp()
	local file_path = vim.fn.expand("%:p") -- 現在のファイルのフルパスを取得
	local file_name = vim.fn.expand("%:t:r") -- 拡張子なしのファイル名を取得
	local compile_command = "g++ " .. file_path .. " -o " .. file_name
	local run_command = "./" .. file_name

	-- コンパイルコマンドを実行し、結果を取得
	local compile_output = vim.fn.system(compile_command)

	-- コンパイルが成功したかどうかを確認
	if vim.v.shell_error == 0 then
		print("Compilation successful.")
		-- コンパイル成功時に実行ファイルをtoggletermで実行
		toggleterm.exec(run_command)
	else
		-- コンパイル失敗のメッセージを表示
		print("Compilation failed.\n" .. compile_output)
	end
end

-- キーバインドの設定
vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>lua compile_and_run_cpp()<CR>", { noremap = true, silent = true })
