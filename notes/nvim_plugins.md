# Ideal nv plugins

## Package 

* [X] lazy.nvim
* [X] mason

## UI

* [X] nvim-notify
* [X] smart-splits
* [X] nvim-web-devicons
* [ ] bufdelete
* [X] neo-tree
* [X] heirline
* [X] telescope.nvim
* [ ] telescope-fzf-native.nvim
* [ ] toggleterm
* [X] which-key
* [X] tmux terminal integration

## Treesitter

* [X] nvim-treesiter
* [ ] nvim-ts-autotag
* [ ] nvim-ts-context-commentstring

## Completion

* [X] LuaSnip
* [X] friendly-snippets
* [X] nvim-cmp
* [X] cmp_luasnip
* [X] cmp-buffer
* [X] cmp-path

## Editing

* [X] guess-indent
* [X] NvChad/nvim-colorizer
* [X] nvim-autopairs
* [X] Comment.nvim
* [X] indent-blankline
* [X] better_escape

## LSP

* [X] nvim-lspconfig
* [X] mason-lspconfig
* [X] aerial.nvim

## Debugging

* nvim-dap
* nvim-dap-ui

## Git

* [X] gitsigns.nvim

# Features

* [X] Increase / decrease split widths / heights with ctrl + arrow keys (smart-splits)
* [X] On screen leader suggestions 
* [ ] Format code on save
* [X] Run selection on terminal
* [X] Fuzzily search files
* [X] Fuzzily search current buffer
* [X] Tmux integration
* [X] Default options following previous vim config
* [X] Hide command bar
* [X] Markdown support
* [ ] Integrated cheat sheet
* [ ] Launch lazygit from vim
* [X] Pretty icons for nvim cmp
* [ ] Lightbulb LSP (https://github.com/kosayoda/nvim-lightbulb)
* [ ] Git blame support (vim-fugitive)
* [X] Switch neozoom to zen mode
* [ ] Scroll page up / down when cursor hits 1/3 of the page
* [X] Numbers keep disapearing / change line numbers to activate to old values when leaving terminal buffers
* [X] Disable which-key for visual mode
* [ ] Allow renaming tabs
* [X] Better shortcut to quit insert mode for terminal
* [ ] Shortcut for switching tabs in terminal mode (and other modes)
* [X] Automatically go to insert mode when focusing on terminal
* [ ] Disable cmp for terminal buffers
* [X] Figure out how to change the curdir of the tree (just doing :e <dir> makes the buffers go wonky)
* [ ] Show all LSP warnings in a popup window

## Commands

Alt + hjkl = resize pane
Ctrl + hjkl = move between panes
UNDEFINED smart splits = swap buffers
gcc = comment current line
gc = comment visual block
gco = insert comment on next line
gcO = insert comment on previous line
gcA = insert comment on end of current line
jk or jj = exit insert mode
c-w J = move window to very bottom
