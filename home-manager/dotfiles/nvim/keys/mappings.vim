" Use alt + hjkl to resize windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" To return to the normal vim screen just press Ctrl+w+w
nnoremap <c-n> :call OpenTerminal()<CR>

" Turn the terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>

"Fuzzy finder
nnoremap <C-p> :Rg<CR>

"Toggle with CTRL-B
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
