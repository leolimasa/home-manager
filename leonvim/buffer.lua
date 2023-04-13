local m = {}

Bufclip = nil

function m.zoom()
	local bufname = vim.api.nvim_buf_get_name(0)
	local cur = vim.api.nvim_win_get_cursor(0) -- row, col
	vim.api.nvim_command(":tabnew " .. bufname)
	vim.api.nvim_win_set_cursor(0, cur)
end

function yank()
	Bufclip = {
		name = vim.api.nvim_buf_get_name(0),
		cursor = vim.api.nvim_win_get_cursor(0) -- row, col
	}
end

