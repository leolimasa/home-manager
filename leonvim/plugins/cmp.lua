return function()
	local cmp = require("cmp")
	local lsp_symbols = {
		Text = "   Text",
		Method = "   Method",
		Function = "   Function",
		Constructor = "   Constructor",
		Field = " ﴲ  Field",
		Variable = "[] Variable",
		Class = "   Class",
		Interface = " ﰮ  Interface",
		Module = "   Module",
		Property = " 襁 Property",
		Unit = "   Unit",
		Value = "   Value",
		Enum = " 練 Enum",
		Keyword = "   Keyword",
		Snippet = "   Snippet",
		Color = "   Color",
		File = "   File",
		Reference = "   Reference",
		Folder = "   Folder",
		EnumMember = "   EnumMember",
		Constant = " ﲀ  Constant",
		Struct = " ﳤ  Struct",
		Event = "   Event",
		Operator = "   Operator",
		TypeParameter = "   TypeParameter",
	}
	local border_opts = {
		border = "single",
		winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
	}
	cmp.setup({
		snippet = {
			expand = function(args)
				-- require('luasnip').lsp_expand(args.body)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(border_opts),
			documentation = cmp.config.window.bordered(border_opts),
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' },
			{ name = 'path' },
			-- Autocomplete using all buffers
			{ name = 'buffer' }
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
