" --------------------
"  True color support
" -------------------

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" --------------------
"  Plugins that do not work well when started with nix
" --------------------

" Automatically install vim plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'puremourning/vimspector'

call plug#end()

" --------------------
"  Basic Config
" --------------------

set clipboard+=unnamedplus
set number
set relativenumber
set cmdheight=2    " Better display for messages
set expandtab      " Default to spaces
set shiftwidth=2   " Default to 2 spaces for indentation
set mouse=a        " Enable mouse support for everything
let g:vim_markdown_folding_disabled = 1  " Disable markdown folding because of bug
let g:airline_theme='onedark'
set noswapfile

" Fix the vertical split
highlight VertSplit cterm=NONE

" ----------------
"  Airline
" ---------------

let g:airline_powerline_fonts = 1        " Enables airline arrows
"let g:airline_theme = 'breezy'

" ----------------
"  COC
"  ---------------
" Typescript detection
" au BufNewFile,BufRead *.ts set filetype=typescript
"au BufNewFile,BufRead *.tsx set filetype=typescriptreact

" coc airline integration
"
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:airline#extensions#branch#enabled = 1

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <space>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <space>fs  <Plug>(coc-format-selected)
nmap <space>fs  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <space>a  <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <space>lc  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <space>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>yf  :<C-u>CocList outline<cr> 
" Search workspace symbols
nnoremap <silent> <space>yp  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" -------------------
"  Navigation
" -------------------
"
" Remap for listing buffers
vmap <space>b  :<C-u>Buffers<cr>
nmap <space>b  :<C-u>Buffers<cr>

" Open on new vertical split
nmap <space>vp  <C-w>v<C-l><space>p 
nmap <space>vP  <C-w>v<C-l><space>P 
nmap <space>vb  <C-w>v<C-l><space>b
nmap <space>ve  <C-w>v<C-l><space>:e<space>

" Finds text in files
nmap <space>sp  :<C-u>Ag<cr>

" Open file explorer
nmap <space>o  :<C-u>Explore<cr>

" Open file explorer in vertical split
nmap <space>vo  <C-w>v<C-l>:<C-u>Explore<cr>

" ---------------
"  FZF
" ---------------
nnoremap <silent> <space>p :FZF<cr>
nnoremap <silent> <space>P :FZF ~<cr>
nnoremap <silent> <space>b :Buffers<cr>
" Find text in current buffer'
nmap <space>/ :<C-u>BLines<cr>

" ---------------
" Vimspector
" ---------------
let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <silent> <space>di :call vimspector#StepInto()<CR>
nnoremap <silent> <space>dout :call vimspector#StepOut()<CR>
nnoremap <silent> <space>db :call vimspector#ToggleBreakpoint()<CR>


" --------------------
" Theme 
" -------------------
let g:airline_theme='onedark'
colorscheme onedark
