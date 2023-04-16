local opts = require("leonvim.options")
local m = {}

-- b will overwrite a
local function merge_tables(a, b)
	for k,v in pairs(b) do
		a[k] = v
	end
	return a
end

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

local function setup_plugins(extra_plugins)
	if extra_plugins == nil then
		extra_plugins = {}
	end
	local plugins = require("leonvim.plugins.config")
	plugins = merge_tables(plugins, extra_plugins)
	local lazy_plugins = {}
	for k,v in pairs(plugins) do
		v[1] = k
		table.insert(lazy_plugins, v)
	end
	require("lazy").setup(lazy_plugins)
end

local function setup_keymaps()
	local maps = require("leonvim.keymaps")
	for mode, mappings in pairs(maps) do
		for key, mapping in pairs(mappings) do
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

local function setup_terminal()
	vim.cmd("autocmd BufWinEnter,WinEnter term://* startinsert")
end

Cur_config = {}

function m.init(extra_plugins)
	opts.setup()
	download_lazynvim()
	setup_plugins(extra_plugins)
	setup_ui()
	setup_keymaps()
	setup_terminal()
	Cur_config = { extra_plugins = extra_plugins}
end

function m.reload_keymaps()
	package.loaded["leonvim.keymaps"] = nil
	package.loaded["leonvim.leader_keymaps"] = nil
	package.loaded["leonvim.plugins.whichkey"] = nil
	require("leonvim.plugins.which-key")()
	setup_keymaps()
end

return m
