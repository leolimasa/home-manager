-- Specifies leader key shortcuts
-- See https://github.com/folke/which-key.nvim for format
return {
	v = {
		["<leader>"] = {
			y = {
				name = "Yank to window",
				h = { "y<c-w><c-h>pa<cr>", "Left" },
				j = { "y<c-w><c-j>pa<cr>", "Down" },
				k = { "y<c-w><c-k>pa<cr>", "Up"},
				l = { "y<c-w><c-l>pa<cr>", "Right"},
			},
		}
	},
	n = {
		["<leader>"] = {
			["/"] = { function() require("telescope.builtin").current_buffer_fuzzy_find() end, "Fuzzy find on current buffer" },
			o = { "<cmd>NvimTreeFocus<cr>", "Open and go to explorer" },
			e = { "<cmd>NvimTreeToggle<cr>", "Toggle explorer" },
			n = { "<cmd>IconPickerNormal<cr>", "Icon picker"},
			z = { "<cmd>ZenMode<cr>", "Zoom window"},
			p = {
				name = " Packages",
				l = { "<cmd>Mason<cr>", "Manage LSP clients" },
				u = { "<cmd>MasonUpdate<cr>", "Update LSP repository" },
				z = { "<cmd>Lazy<cr>", "Lazy plugin manager" }
			},
			["?"] = {
				name = " Help",
				f = { function() require("telescope.builtin").help_tags() end, "Find in help" },
				c = { function() require("telescope.builtin").commands() end, "Commands" },
				m = { function() require("telescope.builtin").man_pages() end, "Man pages" },
				k = { function() require("telescope.builtin").keymaps() end, "Keymaps" },
				o = { function() require("telescope.builtin").vim_options() end, "Neovim Options" }
			},
			f = {
				name = " Find",
				f = { function() require("telescope.builtin").find_files() end, "Files" },
				b = { function() require("telescope.builtin").buffers() end, "Buffers" },
				m = { function() require("telescope.marks").marks() end, "Marks" },
				c = { require("fzf-lua").grep_project, "In file Contents"},
			},
			c = {
				name = " Code",
				a = { function() vim.lsp.buf.code_action() end, "LSP code actions"},
				r = { function() vim.lsp.buf.rename() end, "Rename" },
				q = { function() require("telescope.builtin").quickfix() end, "Show quick fix" },
				c = { "<Plug>(comment_toggle_linewise_current)", "Comment current line [gcc]" },
				g = { function() require("telescope.builtin").spell_suggest() end, "Suggest Spelling" },
				h = { function() require("telescope.builtin").highlights() end, "Highlights" },
				i = { function() require("telescope.builtin").lsp_incoming_calls() end, "Incoming calls (LSP)" },
				t = { function() require("telescope.builtin").lsp_outgoing_calls() end, "Outgoing calls (LSP)" },
				s = { function() require("telescope.builtin").lsp_document_symbols() end, "Document symbols (LSP)" },
				w = { function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, "Workspace symbols (LSP)" },
				d = { function() require("telescope.builtin").diagnostics() end, "Diagnostics (LSP)" },
				l = { function() require("telescope.builtin").treesitter() end,
					"List functions and variables (Treesitter)" },
				f = { function() vim.lsp.buf.format() end, "Format" },
				o = { "<cmd>AerialToggle right<cr>", "Outline"},
				k = { function() vim.lsp.buf.hover() end, "Hover documentation" }
			},
			g = {
				name = "↪ Go to",
				i = { function() require("telescope.builtin").lsp_implementations() end, "Implementations (LSP)" },
				d = { function() require("telescope.builtin").lsp_definitions() end, "Definitions (LSP)" },
				t = { function() require("telescope.builtin").lsp_type_definitions() end, "Type definitions (LSP)" },
				r = { function() require("telescope.builtin").lsp_references() end, "References (LSP)" },
			},
			i = {
				name = " Git",
				c = { function() require("telescope.builtin").git_commits() end, "Commits" },
				d = { function() require("telescope.builtin").git_bcommits() end, "Buffer Commits" },
				b = { function() require("telescope.builtin").git_branches() end, "Branches" },
				s = { function() require("telescope.builtin").git_status() end, "Status" },
				t = { function() require("telescope.builtin").git_stash() end, "Stash" },
			},
			d = {
				name = " Debug",
				n = { function() require("telescope").extensions.notify.notify() end, "View VIM notifications history" }
			},
			s = {
				name = "麗 Selection",
				j = { "y<c-w><c-j>pa<cr>", "Send visual selection down window"},
				k = { "y<c-w><c-j>pa<cr>", "Send visual selection up window"},
			},
			t = {
				name = " Terminal",
				s = { "<c-w>s<c-w>j<cmd>terminal<cr>i", "New terminal split"},
				v = { "<c-w>v<c-w>l<cmd>terminal<cr>i", "New terminal vertical"},
				b = { "<cmd>bo new<cr><cmd>terminal<cr>i", "New terminal bottom"},
			}
		}
	}
}
