-- local M = {}

function Expand_setup()
	vim.api.nvim_create_autocmd(
		{ "BufEnter", "BufWinEnter" }, {
			callback = function(ev)
				local height = vim.api.nvim_win_get_height(0)
				if height <= 1 then
					vim.api.nvim_cmd("<c-w>=")
				end
			end
		})
end

-- return M
