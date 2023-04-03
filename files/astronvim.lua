return {
  colorscheme = "onedark",
  plugins = {
    { "navarasu/onedark.nvim"}
  },
  mappings = {
    n = {
      ["<leader>/"] = function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, 
      { desc = '[/] Fuzzily search in current buffer]' }
    }
  }
}
