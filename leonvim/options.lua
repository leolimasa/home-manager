local m = {}

function m.setup()
    	vim.opt.termguicolors = true

	-- Line numbers, with relative numbering
	vim.wo.number = true
	vim.wo.relativenumber = true

	-- Faster timeout
	vim.o.timeout = true
	vim.o.timeoutlen = 250 

	-- Only show command bar when active
	vim.o.cmdheight = 0

	-- Indent line breaks
	vim.o.breakindent = true

	-- Case insensitive searching UNLESS /C or capital in search
	vim.o.ignorecase = true

	-- Save undo history
	vim.o.undofile = true

	-- Set completeopt to have a better completion experience
	vim.o.completeopt = 'menuone,noselect'

	-- Share the system clipboard
	vim.o.clipboard = 'unnamedplus'

	-- Disable netrw, since we use a file explorer
	-- vim.g.loaded_netrw = 1
	-- vim.g.loaded_netrwPlugin = 1
	vim.g.netrw_liststyle = 3

	-- Set leader to space
	vim.g.mapleader = " "
	vim.g.localmapleader = " "

	-- Save more session stuff
	vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winpos,winsize,terminal,options,localoptions"
end

return m
