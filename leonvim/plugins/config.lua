return {
	-- General Lua library, and used as a dependency for various plugins
	["nvim-lua/plenary.nvim"] = {},
	-- Pretty icons
	["nvim-tree/nvim-web-devicons"] = {},
	-- Code snippet engine
	["hrsh7th/vim-vsnip"] = {},
	-- Code snippet presets
	-- Framework specific snippets may need extra config. See plugin website.
	["rafamadriz/friendly-snippets"] = {},
	-- Autocomplete
	["hrsh7th/nvim-cmp"] = {
		dependencies = {
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-vsnip',
			'windwp/nvim-autopairs'
		},
		config = require("leonvim.plugins.cmp")
	},
	-- Provides pre-made configuration for LSP servers and ensures it attaches to the buffer.
	-- This will NOT auto setup an LSP client. For that, see mason-lspconfig.
	-- Note that if you want extra features for a particular LSP, you may need to install
	-- additional plugins. See https://github.com/neovim/nvim-lspconfig/wiki.
	["neovim/nvim-lspconfig"] = { lazy = false },
	-- Manage and install LSP server binaries
	["williamboman/mason.nvim"] = {
		lazy = false,
		config = function()
			require("mason").setup()
		end
	},
	-- Ensure Mason plays well with nvim-lspconfig
	["williamboman/mason-lspconfig.nvim"] = {
		lazy = false,
		dependencies = {
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
		},
		config = require("leonvim.plugins.mason")
	},
	-- Displays the shortcut hint panel
	["folke/which-key.nvim"] = {
		config = require("leonvim.plugins.which-key")
	},
	-- The onedark theme
	["navarasu/onedark.nvim"] = {
		lazy = false,
		config = function()
			vim.cmd([[colorscheme onedark]])
		end
	},
	-- Allows changing between tmux windows and nvim seamlessly
	["aserowy/tmux.nvim"] = {
		config = function()
			require("tmux").setup()
		end
	},
	-- Resize panes using arrow keys
	['mrjones2014/smart-splits.nvim'] = {},
	-- Screen overlay for finding things
	['nvim-telescope/telescope.nvim'] = {
		config = function()
			-- Enable telescope fzf native, if installed
			pcall(require('telescope').load_extension, 'fzf')
		end
	},
	-- Syntax highlighting
	['nvim-treesitter/nvim-treesitter'] = {
		config = function()
			require('nvim-treesitter.configs').setup {
				ensure_installed = { "lua", "nix", "typescript" },
				highlight = {
					enable = true
				}
			}
		end
	},
	-- Better statusline
	['nvim-lualine/lualine.nvim'] = {
		config = function()
			require('lualine').setup()
		end
	},
	['rcarriga/nvim-notify'] = {
		config = function()
			-- Override vim's notify function with the plugin
			vim.notify = require('notify')
		end
	},
	-- Adds git markers to the gutter
	['lewis6991/gitsigns.nvim'] = {
		config = function()
			require('gitsigns').setup()
		end
	},
	-- Adjusts indent settings for buffer automatically
	['tpope/vim-sleuth'] = {},
	-- Adds color to hex codes
	['NvChad/nvim-colorizer.lua'] = {
		config = function()
			require("colorizer").setup()
		end
	},
	-- Automatic insertion of parenthesis and brackets
	["windwp/nvim-autopairs"] = {
		config = require("leonvim.plugins.autopairs")
	},
	-- Comment toggling
	['numToStr/Comment.nvim'] = {
		config = function()
			require("Comment").setup()
		end
	},
	-- Shows line indents
	["lukas-reineke/indent-blankline.nvim"] = {
		config = function()
			require("indent_blankline").setup {
				show_current_context = true,
				show_current_context_start = true,
			}
		end
	},
	-- Use jk to exit insert mode
	["max397574/better-escape.nvim"] = {
		config = function()
			require("better_escape").setup()
		end,
	},
	-- Display code outline
	["stevearc/aerial.nvim"] = {
		config = function() require('aerial').setup() end
	},
	-- Icon picker
	["ziontee113/icon-picker.nvim"] = {
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true
			})
		end,
	},
	-- Prettier UI prompts
	["stevearc/dressing.nvim"] = {
		config = function()
			require("dressing").setup()
		end
	},
	-- Better markdown support than native
	["vimwiki/vimwiki"] = {},
	-- Tab management
	["nanozuki/tabby.nvim"] = {
		config = require("leonvim.plugins.tabby")
	},
	-- Fuzzy search in files
	["ibhagwan/fzf-lua"] = {},
	-- File explorer
	-- ["ms-jpq/chadtree"] = {
	-- 	build = "python3 -m chadtree deps"
	-- }
	["nvim-neo-tree/neo-tree.nvim"] = {
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		tag = "2.59",
		config = function()
			-- Unless you are still migrating, remove the deprecated commands from v1.x
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
			require("neo-tree").setup({
				enable_diagnostics = true,
				follow_current_file = true,
				popup_border_style = "rounded",
			})
		end
	}
}
