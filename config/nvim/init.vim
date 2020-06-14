" vim: foldmethod=marker

" vim-plug {{{1

" Specify a directory for plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'NLKNguyen/papercolor-theme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
call plug#end()

" vim-plug 1}}}

" Appearance {{{1

set colorcolumn=+1
set number relativenumber

if (has("termguicolors"))
  set termguicolors
endif

set textwidth=80

colorscheme PaperColor

" Appearance 1}}}

" Behavior {{{1

set ignorecase smartcase  " Use case insensitive search, except when using capital letters.
set magic  " Use 'magic' patterns (extended regular expressions).
set notimeout ttimeout ttimeoutlen=200  " Quickly time out on keycodes, but never time out on mappings.
set scrolloff=8  " Start scrolling when we're 8 lines away from margins.
set sidescrolloff=15
set smartindent
set tabstop=4
set undofile  " Enable persistent undos.
set whichwrap+=<,>,h,l,[,]  " Automatically wrap left and right.

augroup behavior
  autocmd!
  autocmd BufWritePre /tmp/* setlocal noundofile
  autocmd FileType json syntax match Comment +\/\/.\+$+	" jsonc comment highlighting
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END

" Behavior 1}}}

" Functions {{{1

" TwiddleCase() {{{2
" Press `~` to rotate between UPPER, lower, and Title cases on selection.
function! TwiddleCase(str)
		if a:str ==# toupper(a:str)
				let result = tolower(a:str)
		elseif a:str ==# tolower(a:str)
				let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
		else
				let result = toupper(a:str)
		endif
		return result
endfunction
" TwiddleCase() 2}}}

" Functions 1}}}

" Key Mappings {{{1

cnoremap <C-N> <Down>|		" Filter the command history in ex mode.
cnoremap <C-P> <Up>|		" Filter the command history in ex mode.
nnoremap <C-L> :nohl<CR>
"nnoremap <C-F> :Prettier<CR>
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nnoremap gt :tabnext<CR>
nnoremap gT :tabprevious<CR>
nnoremap ZZ :w<CR>:bd<CR>
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
vnoremap <C-H> "zy:exe "h ".@z.""<CR>|	    " Press Ctrl-H in visual mode to look up help for the selected word
set pastetoggle=<Leader>v

" Key Mappings 1}}}

" Plugin Configurations {{{1

" vim-airline {{{2

let g:airline_theme = 'papercolor'
let g:airline_powerline_fonts = 1
" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" vim-airline 2}}}

" Plugin Configurations 1}}}
