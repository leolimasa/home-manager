local opts = require("leonvim.options")
local m = {}

local function download_lazynvim()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
	  vim.fn.system({
	    "git",
	    "clone",
	    "--filter=blob:none",
	    "https://github.com/folke/lazy.nvim.git",
	    "--branch=stable", -- latest stable release
	    lazypath,
	  })
	end
	vim.opt.rtp:prepend(lazypath)
end

local function setup_plugins()
	require("lazy").setup("leonvim.plugins")
end

local function setup_keymaps()
	local maps = require("leonvim.keymaps")
	for mode,mappings in pairs(maps) do
		for key,mapping in pairs(mappings) do
			vim.keymap.set(mode, key, mapping)
		end
	end
end

local function setup_ui()
	-- Change the diagnostic sign for LSP
	local signs = {
	  Error = " ",
	  Warn = " ",
	  Hint = " ",
	  Info = " "
	}
	for type, icon in pairs(signs) do
	  local hl = "DiagnosticSign" .. type
	  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end
end

function m.init()
	opts.setup()
	download_lazynvim()
	setup_plugins()
	setup_ui()
	setup_keymaps()
end

return m
