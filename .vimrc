call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'frazrepo/vim-rainbow'
call plug#end()

" -- solarized conf
set background=dark
try
	colorscheme solarized
catch
endtry

" -- vim-rainbow conf
let g:rainbow_active = 1
