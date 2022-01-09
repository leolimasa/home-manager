
function! myspacevim#before() abort
  call SpaceVim#custom#SPCGroupName(['o'], '+CustomBindings')
  call SpaceVim#custom#SPC('nore', ['o', '/'], 'BLines', 'Fuzzy search in File', 1)
  call SpaceVim#custom#SPC('nore', ['o', 'f'], 'FZF', 'Fuzzy search in pwd file names', 1)
  call SpaceVim#custom#SPC('nore', ['o', 'c'], 'Ag', 'Fuzzy search in pwd file contents', 1)
  call SpaceVim#custom#SPC('nore', ['o', 'b'], 'Buffers', 'Fuzzy search in buffer names', 1)
endfunction

function! myspacevim#after() abort
endfunction
