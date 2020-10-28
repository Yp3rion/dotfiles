call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" -- solarized conf
set background=dark
try
	colorscheme solarized
catch
endtry
