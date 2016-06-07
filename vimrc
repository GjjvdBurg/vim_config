" Gotta be first
set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" --- Making Vim look good ---
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'bling/vim-airline'

" --- Vim as a programmer's text editor ---
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/a.vim'

" --- Working with Git ---
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" --- Other text editing features ---
" Plugin 'Raimondi/delimitMate'

" --- man pages, tmux ---
"lugin 'jez/vim-superman'
"Plugin 'christoomey/vim-tmux-navigator'

" --- Syntax plugins ---
" Plugin 'jez/vim-c0'
" Plugin 'jez/vim-ispc'
" Plugin 'kchmck/vim-coffee-script'
Plugin 'tkztmk/vim-vala'

" -- LaTeX Plugins ---
Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Plugin 'lervag/vimtex'

" --- Extras/Advanced plugins ---
" Highlight and strip trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
" Align csv files at commans, align Markdown tables, and more
Plugin 'godlygeek/tabular'
" Automatically insert the closing html tag
Plugin 'HTML-AutoCloseTag'
" SuperTab
Plugin 'ervandew/supertab'
" Doxygen
Plugin 'aymanim/DoxygenToolkit.vim'
" TOML
Plugin 'cespare/vim-toml'
" Todo
" Plugin 'vitalk/vim-simple-todo'
" Matlab
Plugin 'MatlabFilesEdition'
" Matlab folding
Plugin 'djoshea/vim-matlab-fold'

call vundle#end()

filetype plugin indent on

" --- General settings ---
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
"set hlsearch

syntax on

" set mouse=a

" --- Plugin Specific Settings ---

" --- altercation/vim-colors-solarized settings ---
" set background=dark

" let g:solarized_termcolors=256

" Set the colorscheme
" colorscheme solarized


" --- bling/vim-airline settings ---
" Always show statusbar
set laststatus=2

" Requires Menlo-for-powerline font
let g:airline_powerline_fonts=1

" Show PASTE if in paste mode
let g:airline_detect_paste=1

" Show airline for tabs too
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

" --- jistr/vim-nerdtree-tabs ---
" Open/Close NERDTree with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup=0

" --- scrooloose/syntastic settings ---
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '▲'
augroup mySyntastic
	au!
	au FileType tex let b:syntastic_mode = 'passive'
augroup END

" --- xolox/vim-easytags settings ---
" Where to look for tags files
set tags=./tags;,~/.vimtags
" Sensible defaults
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_surpress_ctags_warning = 1

" --- majutsushi/tagbar settings
" Open/close tagbar with \b
nmap <silent> <leader>b :TagbarToggle<CR>
" Uncomment to open tagbar automatically whenever possible
" autocmd BufEnter * nested :call tagbar#autoopen(0)


" --- airblade/vim-gitgutter settings ---
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only=1

" --- Raimondi/delimitMate settings ---
" let delimitMate_expand_cr = 1
" augroup mydelimitMate
	" au!
	" au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
	" au FileType tex let b:delimitMate_quotes = ""
	" au FileType tex let b:delimitMate_matchpais = "(:),[:],{:},`:'"
	" au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
" augroup END

" --- jez/vim-superman settings ---
" better man page support
noremap K :SuperMan <cword> <CR>


" --- Start settings added by Gertjan ---
" Code folding
set foldmethod=indent
set foldlevel=99
hi Folded cterm=bold ctermfg=DarkBlue ctermbg=none
hi FoldColumn cterm=bold ctermfg=DarkBlue ctermbg=none

" Window Splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Make the 80th column stand out
augroup vimrc_autocmds
	autocmd BufEnter * highlight OverLength ctermbg=magenta guibg=#111111
	let blacklist = ['html']
	autocmd BufEnter * if index(blacklist, &ft) < 0 | match OverLength /\%81v.*/
augroup END

" Show annoying whitespace. Because we don't want to highlight tab characters,
" we use two U+2002 characters here. You can add these with Ctrl+V u 2 0 0 2
" (no spaces).
exec "set listchars=tab:  ,trail:·,nbsp:~"
set list

" Doxygen highlighting (dox files)
au BufNewFile,BufRead *.dox setfiletype doxygen

" Maximum text width
set textwidth=78

" Don't back indent preprocessor directives in C
set cinkeys-=0#

" Automatically fix text wrapping
set formatoptions+=aw

" Tab completion
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" Highlight matches when jumping to next
nnoremap <silent> n 	n:call HLNext(0.4)<cr>
nnoremap <silent> N 	N:call HLNext(0.4)<cr>

function! HLNext (blinktime)
	highlight WhiteOnRed ctermfg=white ctermbg=red
	let [bufnum, lnum, col, off] = getpos('.')
	let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
	let target_pat = '\c\%#'.@/
	let ring = matchadd('WhiteOnRed', target_pat, 101)
	redraw
	exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
	call matchdelete(ring)
	redraw
endfunction

" html
autocmd Filetype html setlocal ts=2 expandtab sts=2 sw=2 fo-=t
" matlab
autocmd Filetype matlab setlocal ts=2 sts=2 sw=2
" python
autocmd Filetype python setlocal textwidth=79 shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent

" Vim diff colors
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" Use PyFlakes as the Python syntax checker
let g:syntastic_python_checkers = ['pyflakes']

" Underline function useful for .rst files
function! s:Underline(chars)
	let chars = empty(a:chars) ? '-' : a:chars
	let nr_columns = virtcol('$') - 1
	let uline = repeat(chars, (nr_columns / len(chars)) + 1)
	put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

" Explicitly set 256 colors in Vim
set t_Co=256
