-- Specifies leader key shortcuts
-- See https://github.com/folke/which-key.nvim for format

local win = require("leonvim.window")

local function yank_to_window(pos)
	return "y<c-w><c-" .. pos .. "><cmd>stopinsert<cr>gpi<cr>"
end

return {
	v = {
		["<leader>"] = {
			y = {
				name = "Yank to window",
				h = { yank_to_window("h"), "Left" },
				j = { yank_to_window("j"), "Down" },
				k = { yank_to_window("k"), "Up" },
				l = { yank_to_window("l"), "Right" },
			},
			a = {
				name = " ChatGPT",
				o = {"<cmd>NeoAIContext<cr>", "Open with current code as context"},
				i = {"<cmd>NeoAIInject<cr>", "Inject selection"},
			}
		}
	},
	n = {
		["<leader>"] = {
			["/"] = { function() require("telescope.builtin").current_buffer_fuzzy_find() end,
				"Fuzzy find on current buffer" },
			a = {
				name = " ChatGPT",
				o = {"<cmd>NeoAIToggle<cr>", "Open"},
				g = {'"gp', "Paste output"},
				p = {'"cp', "Paste code"},
			},
			o = { "<cmd>Neotree float toggle dir=%:h<cr>", "Open file" },
			n = { "<cmd>IconPickerNormal<cr>", "Icon picker" },
			z = { "<cmd>ZenMode<cr>", "Zoom window" },
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
				c = { require("fzf-lua").grep_project, "In file Contents" },
			},
			c = {
				name = " Code",
				a = { function() vim.lsp.buf.code_action() end, "LSP code actions" },
				r = { function() vim.lsp.buf.rename() end, "Rename" },
				q = { function() require("telescope.builtin").quickfix() end, "Show quick fix" },
				c = { "<Plug>(comment_toggle_linewise_current)", "Comment current line [gcc]" },
				g = { function() require("telescope.builtin").spell_suggest() end,
					"Suggest Spelling" },
				i = { function() require("telescope.builtin").lsp_incoming_calls() end,
					"Incoming calls (LSP)" },
				t = { function() require("telescope.builtin").lsp_outgoing_calls() end,
					"Outgoing calls (LSP)" },
				s = { function() require("telescope.builtin").lsp_document_symbols() end,
					"Document symbols (LSP)" },
				w = { function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
					"Workspace symbols (LSP)" },
				-- d = { function() require("telescope.builtin").diagnostics() end,
				-- 	"Diagnostics (LSP)" },
				 d = { "<cmd>TroubleToggle<cr>", "Diagnostics (LSP)" },
				l = { function() require("telescope.builtin").treesitter() end,
					"List functions and variables (Treesitter)" },
				f = { function() vim.lsp.buf.format() end, "Format" },
				o = { "<cmd>AerialToggle right<cr>", "Outline" },
				k = { function() vim.lsp.buf.hover() end, "Hover documentation" },
				e = { function() vim.diagnostic.open_float() end, "Current line diagnostics"}
			},
			g = {
				name = "↪ Go to",
				i = { function() require("telescope.builtin").lsp_implementations() end,
					"Implementations (LSP)" },
				d = { function() require("telescope.builtin").lsp_definitions() end,
					"Definitions (LSP)" },
				t = { function() require("telescope.builtin").lsp_type_definitions() end,
					"Type definitions (LSP)" },
				r = { function() require("telescope.builtin").lsp_references() end,
					"References (LSP)" },
			},
			i = {
				name = " Git",
				c = { function() require("telescope.builtin").git_commits() end, "Commits" },
				d = { function() require("telescope.builtin").git_bcommits() end,
					"Buffer Commits" },
				b = { function() require("telescope.builtin").git_branches() end, "Branches" },
				s = { function() require("telescope.builtin").git_status() end, "Status" },
				t = { function() require("telescope.builtin").git_stash() end, "Stash" },
			},
			d = {
				name = " Debug",
				n = { function() require("telescope").extensions.notify.notify() end,
					"View VIM notifications history" },
				b = { function() require 'dap'.toggle_breakpoint() end,
					"Toggle breakpoint" },
				c = { function() require 'dap'.continue() end,
					"Start or continue debugging session" },
				o = { function() require 'dap'.step_over() end,
					"Step over" },
				i = { function() require 'dap'.step_into() end,
					"Step into" },
				t = { function() require 'dap'.step_out() end,
					"Step out" },
				s = { function() require 'dap'.repl.open() end,
					"Debugger state" },
				u = { function() require("dapui").toggle() end,
					"Toggle UI" }
			},
			r = {
				name = " Terminal",
				s = { "<c-w>s<c-w>j<cmd>terminal<cr>i", "New terminal split" },
				v = { "<c-w>v<c-w>l<cmd>terminal<cr>i", "New terminal vertical" },
				b = { "<cmd>bo new<cr><cmd>terminal<cr>i", "New terminal bottom" },
			},
			t = {
				name = "裡Tabs",
				l = { "gt", "Next tab" },
				h = { "gT", "Previous tab" },
				n = { "<cmd>tabnew<cr>", "New tab" },
				r = { function()
					vim.ui.input(
						{ prompt = "Tab name" },
						function(tabname)
							if tabname and tabname ~= "" then
								vim.cmd("TabRename " .. tabname)
							end
						end)
				end,
					"Rename current tab" },
				d = { "<cmd>tabclose<cr>", "Close tab" }
			},
			-- w = {
			-- 	name = "缾Window",
			-- 	y = { function() win.yank() end, "Yanks a window" },
			-- 	p = { function() win.paste() end, "Pastes a yanked window into the current window" },
			-- 	s = { function() win.swap() end, "Swaps the current window with the yanked window" },
			-- 	z = { function() win.zoom() end, "Zooms the current window in a new tab" },
			-- 	j = { "<c-w>=<c-w>j", "Equalize windows and move down" },
			-- 	k = { "<c-w>=<c-w>k", "Equalize windows and move up" },
			-- 	m = { "<c-w>_", "Maximize height" },
			-- 	w = { "<c-w>|", "Maximize width" }
			-- },
			s = {
				name = "漣Settings",
				k = { function() require("leonvim.init").reload_keymaps() end, "Reload keymaps" },
				h = { function() require("telescope.builtin").highlights() end, "Show highlight groups" },
			}

		}
	}
}
