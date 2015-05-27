set nocompatible

" always have a status line, even in console
set laststatus=2

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
" set hlsearch
endif

" most of the stuff below here cannabalised from Tabitha Tipper's .vimrc file,
" which in turn cannabalised a lot from others

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" not that crappy standard font
"set guifont=Courier

" start at a reasonable size goddammit
"set lines=35

" tab settings
set tabstop=8           " a tab is 8 columns
set softtabstop=2       " tab in insert mode by default is 2 columns
set shiftwidth=2        " reindenting uses 2 columns
set noexpandtab         " expandtab = always use spaces. noexpandtab = use spaces or tabs as needed

set autoindent          " always set autoindenting on
set formatoptions=qc    " q = allow gq formatting, 
                        " c = wrap comments automatically
set textwidth=78

set is                  " incremental searching
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the times
set ic                  " ignore case whilst searching
set nobackup            " don't create foo~ backup file
set showcmd             " display incomplete commands
set scrolloff=2         " preserve 2 lines when page-downing
set noai                " turns off autoindent
set nosi                " turns off smart indent


" ######## AUTO COMMANDS ########

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Set wrapping to 78 on C and Java files
au BufNewFile,BufRead *.cpp,*.c,*.h,*.java set tw=78 cin si softtabstop=8 tabstop=8 shiftwidth=8 noexpandtab
au BufNewFile,BufRead *.cpp,*.c,*.h,*.java call NiceFormatting(0) | redraw

" Set Ruby files to do the right thing (tabs are spaces, and are 2 columns
" wide)
au BufNewFile,BufRead *.rb,*.html.erb set tw=78 cin si softtabstop=2 tabstop=8 shiftwidth=2 expandtab
au BufNewFile,BufRead *.rb,*.html.erb call NiceFormatting(0) | redraw

" Perl. Tabs are 2 columns wide, but are not spaces
au BufNewFile,BufRead *.pl,*.pm set tw=78 cin si softtabstop=2 tabstop=2 shiftwidth=2 noexpandtab
au BufNewFile,BufRead *.pl,*.pm call NiceFormatting(0) | redraw

" Set wrapping to 78 on Tex files, but don't smart indent or autoindent
" and do line wrap
au BufNewFile,BufRead *.tex set tw=78
au BufNewFile,BufRead *.tex call NiceFormatting(0) | redraw

au BufNewFile,BufRead *.txt set noautoindent tw=0 wm=0 nosi
au BufNewFile,BufRead *.txt call NiceFormatting(1) | redraw

" Should stop HTML Files auto-indenting
"au BufNewFile,BufRead *.html set noautoindent
au BufNewFile,BufRead *.html call NiceFormatting(0) | redraw

" Folding, which files to use and what is a marker, also set the foldlevel
" high so nothing is folded by default.  Use zc to close and zo to open.
au BufNewFile,BufRead *.c,*.h,*.cpp,*.java,*.cs,*.hpp,*.pl
        \ setlocal foldmarker={,} |
        \ setlocal foldmethod=marker
:set foldlevel=255

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
au BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
 \   exe "normal g`\"" |
 \ endif

"----------------------------------------------------------------------------
" Adding a toggle button that adds/removes "tan" from formatoptions
"----------------------------------------------------------------------------
let g:niceformatting=0

" Calling NiceFormatting(1) forces text mode, (0) forces code mode. () toggles
function! NiceFormatting(...) 
  " if we get an arg use it to set niceformatting
  if a:0 != 0
    let g:niceformatting=a:1
  endif

  if g:niceformatting == 1
    let g:niceformatting=0
    set formatoptions+=tan
    echomsg "VIM in Text-editing mode (" &formatoptions ") now."
  else
    let g:niceformatting=1
    set formatoptions-=tan
    echomsg "VIM in Coding mode (" &formatoptions ") now."
  endif
endfunction

" ######## CONTROL MAPPING ########

" For reformating text
:noremap <F6> gg=G''	  " map F6 to reindenting the file
:noremap <F2> gqip        " reformat current para
map <F2> gqip

" Map niceformatting to something better
:noremap <F9> :call NiceFormatting()<CR>

" For deleting an entire line
map <C-K> <Home>v$<Del>

" To jump between selections
map . /<CR>
map , ?<CR>

" for getting the wordcount of the current file
map <F8> :! wc -w "%"<CR>

" For switching between buffers of text.
map <F3> :bp<CR>          " previous buffer
map <F4> :bn<CR>          " buffer next.  You might want wnext instead.
imap <F3> <ESC>:bp<CR>    " jump out of insert and previous then in
imap <F4> <ESC>:bn<CR>    " jump out of insert and next then in

" Spell checking.
map <F7> :call Aspell()<CR>

func! Aspell()
  if &ft == "tex"
    let flags = "-x -e --add-filter=tex --lang=en_GB-only -c %"
  else
    let flags = "-x -e --lang=en_GB-only -c %"
  endif
  execute ":w"
  execute ":!aspell" flags
  execute ":e!"
endfunc

" Arrow keys can be used for selection in Visual mode (for console)
vmap <Left> h
vmap <Down> j
vmap <Up> k
vmap <Right> l

" Map cursor keys to moving per on-screen-line, *not* line of text line.
nmap j gj
nmap k gk

nmap <up> gk
imap <up> <c-o>gk

nmap <down> gj
imap <down> <c-o>gj
