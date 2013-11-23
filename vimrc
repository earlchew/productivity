" Tab settings
" http://tedlogan.com/techblog3.html
set softtabstop=4 shiftwidth=4 expandtab ai

" Content specific configuration
" http://vimdoc.sourceforge.net/htmldoc/filetype.htm
filetype on
filetype plugin on
filetype indent on

" Color selection
" http://vimdoc.sourceforge.net/htmldoc/syntax.html#:colorscheme
colorscheme desert
set background=dark

" Syntax highlighting
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27syntax%27
syntax on

" Clear search highlighting
" http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
nmap <SPACE> <SPACE>:noh<CR>
