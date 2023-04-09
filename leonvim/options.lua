local m = {}

function m.setup()
	vim.o.timeout = true
	vim.o.timeoutlen = 300
	vim.o.cmdheight = 0
	vim.g.mapleader = " "
	vim.g.localmapleader = " "
	vim.wo.number = true
	vim.wo.relativenumber = true

	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1

    	vim.opt.termguicolors = true
end

return m
