return {
  colorscheme = "onedark",
  plugins = {
    { "navarasu/onedark.nvim" },
    { "whonore/Coqtail", lazy = false}
  },
  mappings = {
    n = {
      ["<leader>/"] = {
          function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              winblend = 10,
              previewer = false,
            })
          end, 
          desc = 'Fuzzily search in current buffer'
      },
      ["<leader>a"] = { desc = "🐓 Coq"},
      ["<leader>an"] = { "<cmd>CoqNext<cr>", desc = "Compile next line" },
      ["<leader>au"] = { "<cmd>CoqUndo<cr>", desc = "Undo compile" },
      ["<leader>al"] = { "<cmd>CoqToLine<cr>", desc = "Compile / decompile to line" }   
    }
  }
}

