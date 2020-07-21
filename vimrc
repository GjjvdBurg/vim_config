" Gotta be first
set nocompatible
set exrc

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
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/a.vim'

" --- Working with Git ---
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" --- Syntax plugins ---
Plugin 'tkztmk/vim-vala'
Plugin 'ambv/black'
Plugin 'dense-analysis/ale'

" -- LaTeX Plugins ---
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'gerw/vim-tex-syntax'
" Plugin 'lervag/vimtex'

" --- Extras/Advanced plugins ---
" Highlight and strip trailing whitespace
Plugin 'ntpeters/vim-better-whitespace'
" Align csv files at commas, align Markdown tables, and more
Plugin 'godlygeek/tabular'
" Automatically insert the closing html tag
Plugin 'HTML-AutoCloseTag'
" SuperTab
Plugin 'ervandew/supertab'
" Doxygen
Plugin 'aymanim/DoxygenToolkit.vim'
" TOML
Plugin 'cespare/vim-toml'
" Matlab
Plugin 'MatlabFilesEdition'
" Matlab folding
Plugin 'djoshea/vim-matlab-fold'
" Make in background
Plugin 'gjjvdburg/vim-background-make'
" Javascript
Plugin 'pangloss/vim-javascript'
" Stan
Plugin 'maverickg/stan.vim'

" Vim for writing
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround'

" SnipMate
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" Ledger
Plugin 'ledger/vim-ledger'

" Tables
Plugin 'dhruvasagar/vim-table-mode'

" YUNOcommit
Plugin 'esneider/YUNOcommit.vim'

" Better python highlighting
Plugin 'vim-python/python-syntax'

" Blocking text
Plugin 'sk1418/blockit'

" TitleCase
Plugin 'christoomey/vim-titlecase'

" VimWiki
Plugin 'vimwiki/vimwiki'

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
set background=dark

" let g:solarized_termcolors=256

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
" Ignore certain files
let NERDTreeIgnore = ['\.pyc$', '\.o$']
" Fix for Gvim
let g:nerdtree_tabs_open_on_gui_startup=0

" --- scrooloose/syntastic settings ---
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = '▲'
let g:syntastic_disabled_filetypes = ['java']
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

" Disable better whitespace for tex files
let g:better_whitespace_filetypes_blacklist=['tex', 'r', 'markdown']

" Show annoying whitespace. Because we don't want to highlight tab characters,
" we use two U+2002 characters here. You can add these with Ctrl+V u 2 0 0 2
" (no spaces).
exec "set listchars=tab:  ,trail:·,nbsp:~"
set list

" Doxygen highlighting (dox files)
au BufNewFile,BufRead *.dox setfiletype doxygen
let g:DoxygenToolkit_authorName="G.J.J. van den Burg"

" Maximum text width
set textwidth=78

" Don't back indent preprocessor directives in C
set cinkeys-=0#

" Automatically fix text wrapping
set formatoptions+=aw

" Tab completion
au FileType python set omnifunc=python3complete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" Highlight matches when jumping to next
nnoremap <silent> n 	n:call HLNext(0.1)<cr>
nnoremap <silent> N 	N:call HLNext(0.1)<cr>

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
autocmd Filetype htmldjango setlocal ts=2 expandtab sts=2 sw=2 fo-=t cc=80
" matlab
autocmd Filetype matlab setlocal ts=2 expandtab sts=2 sw=2
" python
autocmd Filetype python setlocal textwidth=79 shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent
" java
autocmd Filetype java setlocal textwidth=79 shiftwidth=4 tabstop=4 expandtab softtabstop=4 shiftround autoindent
" markdown
autocmd Filetype markdown setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 autoindent
" R
autocmd Filetype r setlocal textwidth=79 shiftwidth=2 tabstop=2 expandtab softtabstop=2 shiftround autoindent fo+=r cc=80
" ruby
autocmd Filetype ruby setlocal ts=2 shiftwidth=2 tabstop=2 expandtab softtabstop=2 shiftround autoindent
" yaml
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
" lua
autocmd Filetype lua setlocal ts=3 sts=3 sw=3 expandtab
" tex
autocmd Filetype tex setlocal nolist
" bib
autocmd Filetype bib setlocal nospell fo-=t
" make
autocmd Filetype make setlocal cc=80

" Vim diff colors
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" Use PyFlakes as the Python syntax checker
let g:syntastic_python_checkers = ['pyflakes']

" Use lintr as the R syntax checker
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']
let g:ale_linters_explicit = 1
let g:ale_linters = {}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {'r': ['styler']}

" Underline function useful for .rst files
function! s:Underline(chars)
	let chars = empty(a:chars) ? '-' : a:chars
	let nr_columns = virtcol('$') - 1
	let uline = repeat(chars, (nr_columns / len(chars)) + 1)
	put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

" #####################
" #                   #
" # LATEXBOX SETTINGS #
" #                   #
" #####################

" Choose pdf viewer based on desktop environment
if ($GDMSESSION == 'gnome' || $GDMSESSION == 'gnome-xorg')
	let g:LatexBox_viewer = 'zathura'
else
	let g:LatexBox_viewer = 'zathura'
endif

" Allow asynchronous compilation (requires starting vim server, e.g.
" vim --servername VIM)
let g:LatexBox_latexmk_async=1
let g:LatexBox_ignore_warnings = [
	\ 'Latex Font Warning',
	\ 'Underfull',
	\ 'Overfull',
	\ 'contains only floats',
	\ ]
let g:LatexBox_Folding=1
let g:LatexBox_latexmk_options = "-shell-escape"

" ##### END LATEXBOX SETTINGS #####

" Function for adding code statement in python code
function! s:Code()
	r~/.vim/python/code.txt
endfunction
command! Code call s:Code()

" Function for adding coding line to python code
function! s:coding()
	execute 'normal i' . '# -*- coding: utf-8 -*-'
	execute 'normal o'
endfunction
command! Enc call s:coding()

" Don't show notification on successful background make
let g:background_make_notify_cmd="echo"

set secure

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" map :W to :w and :Q to :q
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

" Strip double spaces from eol in markdown
function! <SID>StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\s\+$/\ /e
	call cursor(l, c)
endfun
autocmd BufWritePre *.md :call <SID>StripTrailingWhitespaces()

" Black settings
let g:black_linelength = 79 " PEP8 recommends 79
let g:black_on_save = 1
function! s:MyBlack()
	if g:black_on_save == 1
		execute ':Black'
	endif
endfunction
command! MyBlack call s:MyBlack()
autocmd BufWritePost *.py execute ':MyBlack'

" Table Mode settings
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='

" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<tab>'

" Python syntax highlighting
let python_highlight_all = 1

" BlockIt settings
" We'll mostly use this for Python and Makefiles
let g:blockit_H_char='#'
let g:blockit_V_char='#'
let g:blockit_align='c'

" Highlight specific keywords in comments
augroup vimrc_todo
	au!
	au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|XXX)/
		\ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo

" Disable titlecase default mapping
let g:titlecase_map_keys = 0

" VimWiki configuration
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/share/both/zettelkasten', 'syntax': 'markdown', 'ext': '.md', 'links_space_char': '_'}]
