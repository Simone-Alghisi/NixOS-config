"Start the terminal in insert mode with escape
au BufEnter * if &buftype == 'terminal' | :startinsert | endif

function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
