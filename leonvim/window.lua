local m = {}

-- Clipboard containing the handle of the clipped window
Window_clip = nil

local function get_window(window_handle)
	return {
		handle = window_handle,
		buffer_handle = vim.api.nvim_win_get_buf(window_handle),
		-- handle = vim.api.nvim_get_current_win(),
		cursor = vim.api.nvim_win_get_cursor(window_handle) -- row, col
	}
end

local function set_window_contents(window_handle, buffer_handle, cursor)
	vim.api.nvim_win_set_buf(window_handle, buffer_handle)
	vim.api.nvim_win_set_cursor(window_handle, cursor)
end

local function current_window()
	return get_window(vim.api.nvim_get_current_win())
end

function m.yank()
	Window_clip = vim.api.nvim_get_current_win()
end


function m.paste()
	if not Window_clip then
		return
	end
	local cur_window = current_window()
	local clip_window = get_window(Window_clip)
	set_window_contents(
		cur_window.handle,
		clip_window.buffer_handle,
		clip_window.cursor)
end

function m.swap()
	if not Window_clip then
		return
	end
	local cur_window = current_window()
	local clip_window = get_window(Window_clip)
	set_window_contents(
		Window_clip,
		cur_window.buffer_handle,
		cur_window.cursor)
	set_window_contents(
		cur_window.handle,
		clip_window.buffer_handle,
		clip_window.cursor)
end

function m.zoom()
	local orig_window = current_window()
	vim.api.nvim_command(":tabnew")
	set_window_contents(0, orig_window.buffer_handle, orig_window.cursor)
end

return m
