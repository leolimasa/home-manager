local M = {}

function M.setup()
	vim.api.nvim_create_autocmd(
		{ "WinEnter" }, {
			callback = function(ev)
				local height = vim.api.nvim_win_get_height(0)
				local width = vim.api.nvim_win_get_width(0)
				local zindex = vim.api.nvim_win_get_config(0).zindex
				-- zindex avoids applying logic to floating windows
				if (height <= 1 or width <= 1) and (not zindex) then
					vim.api.nvim_input('<c-w>=')
				end
			end
		})
end

return M
