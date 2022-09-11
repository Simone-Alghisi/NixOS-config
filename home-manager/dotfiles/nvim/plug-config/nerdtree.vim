"Nerd tree settings
let g:NERDTreeShowHidden = 0
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

"Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
