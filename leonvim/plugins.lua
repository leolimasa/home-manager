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
			'windwp/nvim-autopairs'
		},
		config = function()
			local cmp = require("cmp")
			local lsp_symbols = {
				Text = "   (Text) ",
				Method = "   (Method)",
				Function = "   (Function)",
				Constructor = "   (Constructor)",
				Field = " ﴲ  (Field)",
				Variable = "[] (Variable)",
				Class = "   (Class)",
				Interface = " ﰮ  (Interface)",
				Module = "   (Module)",
				Property = " 襁 (Property)",
				Unit = "   (Unit)",
				Value = "   (Value)",
				Enum = " 練 (Enum)",
				Keyword = "   (Keyword)",
				Snippet = "   (Snippet)",
				Color = "   (Color)",
				File = "   (File)",
				Reference = "   (Reference)",
				Folder = "   (Folder)",
				EnumMember = "   (EnumMember)",
				Constant = " ﲀ  (Constant)",
				Struct = " ﳤ  (Struct)",
				Event = "   (Event)",
				Operator = "   (Operator)",
				TypeParameter = "   (TypeParameter)",
			}
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
					-- Autocomplete using all buffers
					{
						name = 'buffer',
						option = {
							get_bufnrs = function()
								return vim.api.nvim_list_bufs()
							end
						}
					}
				},
				formatting = {
					format = function(entry, item)
						item.kind = lsp_symbols[item.kind]
						item.menu = ({
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							vsnip = "[Snippet]",
							neorg = "[Neorg]",
						})[entry.source.name]
						return item
					end,
				},
				mapping = cmp.mapping.preset.insert {
					['<C-d>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<CR>'] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { 'i', 's' }),
				},
			})

			-- Connect cmp to autopairs
			local cmp_autopairs = require('nvim-autopairs.completion.cmp')
			cmp.event:on(
				'confirm_done',
				cmp_autopairs.on_confirm_done()
			)
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
			mason_lspconfig.setup { ensure_installed = { "lua_ls" },
				automatic_installations = true
			}
			-- Have mason start an lspconfig when attached to a buffer
			mason_lspconfig.setup_handlers {
				function(server_name)
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
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
			wk.setup({
				icons = {
					group = ""
				}
			})
			for mode,mappings in pairs(require("leonvim.leader_keymaps")) do
				for prefix,submappings in pairs(mappings) do
					wk.register(
						submappings,
						{ prefix = prefix, mode = mode })
				end
			end
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
	{
		'nvim-treesitter/nvim-treesitter',
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

	-- Adds git markers to the gutter
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},

	-- Adjusts indent settings for buffer automatically
	{
		'nmac427/guess-indent.nvim',
		config = function()
			require("guess-indent").setup {}
		end
	},

	-- Adds color to hex codes
	{
		'NvChad/nvim-colorizer.lua',
		config = function()
			require("colorizer").setup()
		end
	},


	-- Automatic insertion of parenthesis and brackets
	{
		"windwp/nvim-autopairs",
		config = function()
			require('nvim-autopairs').setup {}

			------------------------------------
			-- Have autopairs be treesitter aware
			-------------------------------------
			local npairs = require("nvim-autopairs")
			local Rule = require('nvim-autopairs.rule')
			npairs.setup({
				check_ts = true,
				ts_config = {
					lua = { 'string' }, -- it will not add a pair on that treesitter node
					javascript = { 'template_string' },
					java = false, -- don't check treesitter on java
				}
			})
			local ts_conds = require('nvim-autopairs.ts-conds')
			-- press % => %% only while inside a comment or string
			npairs.add_rules({
				Rule("%", "%", "lua")
				    :with_pair(ts_conds.is_ts_node({ 'string', 'comment' })),
				Rule("$", "$", "lua")
				    :with_pair(ts_conds.is_not_ts_node({ 'function' }))
			})
		end
	},

	-- Comment toggling
	{
		'numToStr/Comment.nvim',
		config = function()
			require("Comment").setup()
		end
	},

	-- Shows line indents
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup {
				show_current_context = true,
				show_current_context_start = true,
			}
		end
	},

	-- Use jk to exit insert mode
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- Display code outline
	{
		'stevearc/aerial.nvim',
		config = function() require('aerial').setup() end
	},

	-- Icon picker
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({
				disable_legacy_commands = true
			})
		end,
	},

	-- Prettier UI prompts
	{
		'stevearc/dressing.nvim',
		config = function()
			require("dressing").setup()
		end
	},

	-- Decent markdown support
	{
		'vimwiki/vimwiki'
	},

	-- Tab management
	{
		'nanozuki/tabby.nvim'
	},

	{
		'folke/zen-mode.nvim',
		config = function()
			require("zen-mode").setup {
				window = {
					width = 0.90
				}
			}
		end
	}

	-- Zoom
	--[[
	{
		'nyngwang/NeoZoom.lua',
		config = function()
			require("neo-zoom").setup {
				winopts = {
					offset = {
						-- NOTE: you can omit `top` and/or `left` to center the floating window.
						-- top = 0,
						-- left = 0.17,
						width = 0.95,
						height = 0.95,
					},
					-- NOTE: check :help nvim_open_win() for possible border values.
					border = 'rounded',
				},
				popup = {
					enabled = false
				}
			}
		end
	}
	--]]
}
