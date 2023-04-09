return {

	-- General Lua library, and used as a dependency for various plugins
	{ 'nvim-lua/plenary.nvim' },

	-- Pretty icons
	{ "nvim-tree/nvim-web-devicons" },

	-- Code snippet engine
	{ 'hrsh7th/vim-vsnip' },

	-- Code snippet presets
	-- Framework specific snippets may need extra config. See plugin website.
	{ 'rafamadriz/friendly-snippets' },

	-- Autocomplete
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-vsnip',
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						-- require('luasnip').lsp_expand(args.body)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' },
					{ name = 'path' },
				}, {
					{ name = 'buffer' },
				}
			})
		end
	},

	-- Provides pre-made configuration for LSP servers and ensures it attaches to the buffer.
	-- This will NOT auto setup an LSP client. For that, see mason-lspconfig.
	-- Note that if you want extra features for a particular LSP, you may need to install
	-- additional plugins. See https://github.com/neovim/nvim-lspconfig/wiki.
	{
		"neovim/nvim-lspconfig",
		lazy = false
	},

	-- Manage and install LSP server binaries
	{
	    "williamboman/mason.nvim",
	    lazy = false,
	    config = function()
		require("mason").setup()
	    end
	},

	-- Ensure Mason plays well with nvim-lspconfig
	{
	    "williamboman/mason-lspconfig.nvim",
	    lazy = false,
	    dependencies = {
		    'hrsh7th/nvim-cmp',
		    'hrsh7th/cmp-nvim-lsp',
	    },
	    config = function()
		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup{
			ensure_installed = { "lua_ls" },
			automatic_installations = true
		}
		-- Have mason start an lspconfig when attached to a buffer
		mason_lspconfig.setup_handlers {
			function(server_name)
				local capabilities = require('cmp_nvim_lsp').default_capabilities()
				require('lspconfig')[server_name].setup {
					capabilities = capabilities
				}
			end,
		}
	    end
    	},

	-- Displays the shortcut hint panel
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.setup()
			wk.register(
				require("leonvim.keymaps"),
				{ prefix = "<leader>"})
		end
	},

	-- The onedark theme
	{
		"navarasu/onedark.nvim",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme onedark]])
		end
	},

	-- Allows changing between tmux windows and nvim seamlessly 
	{
		"aserowy/tmux.nvim",
		config = function()
			require("tmux").setup()
		end
	},

	-- Resize panes using arrow keys
	{ 'mrjones2014/smart-splits.nvim' },

	-- Screen overlay for finding things
	{
		'nvim-telescope/telescope.nvim',
		config = function()
			-- Enable telescope fzf native, if installed
			pcall(require('telescope').load_extension, 'fzf')
		end
	},

	-- Syntax highlighting
	{ 'nvim-treesitter/nvim-treesitter' },

	-- Automatic completion

	-- Better statusline
	{
	   'nvim-lualine/lualine.nvim',
	   config = function()
		   require('lualine').setup()
	   end
	},

	{
		'rcarriga/nvim-notify',
		config = function()
			-- Override vim's notify function with the plugin
			vim.notify = require('notify')
		end
	},

	-- Left side folder explorer
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup {
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					show_on_open_dirs = true
				}
			}
		end
	},
	--[[
	This causes segfaults. May come back to it if they ever fix it.
	{
	   "nvim-neo-tree/neo-tree.nvim",
	   config = function()
		   require('neo-tree').setup({
			   close_if_last_window = true,
			   popup_border_style = "rounded",
			   enable_git_status = true,
			   enable_diagnostics = true,
			   open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
			   sort_case_insensitive = false, -- used when sorting files and directories in the tree
		   })
	   end
	}
	-- ]]
}
