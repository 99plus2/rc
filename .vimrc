" Eevee's vimrc

" vim mode preferred!
set nocompatible

" if we're in screen, vim doesn't know wtf it's doing with a lot of keycodes.
" so tell it we're in xterm, instead.  also, tweak title so it will change the
" screen window's title to something minimal and useful
if &term =~ "^screen"
  set titlestring=vim\ %{expand(\"%t\")}
  set t_ts=k
  set t_fs=\
endif
set title

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" backups
set nobackup                    " backups are annoying
set writebackup                 " temp backup during write
" TODO: backupdir?
set history=50                  " keep 50 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set ignorecase                  " useful more often than not
set smartcase                   " case-sens when capital letters
set number                      " line numbers

" whitespace
set autoindent                  " keep indenting on <CR>
set shiftwidth=4                " one tab = four spaces (autoindent)
set softtabstop=4               " one tab = four spaces (tab key)
set expandtab                   " never use hard tabs
set fileformats=unix,dos        " unix linebreaks in new files please
set listchars=tab:→·,extends:>,precedes:<,nbsp:␠,trail:␠
                                " appearance of invisible characters


" gui stuff
set ttymouse=xterm2             " force mouse support for screen
set mouse=a                     " terminal mouse when possible
set guifont=DejaVu\ Sans\ Mono\ 9
                                " nice fixedwidth font

" unicode
set encoding=utf-8              " best default encoding
setglobal fileencoding=utf-8    " ...
set nobomb                      " do not write utf-8 BOM!
set fileencodings=ucs-bom,utf-8,iso-8859-1
                                " order to detect Unicodeyness

" tab completion
set wildmenu                    " show a menu of completions like zsh
set wildmode=full               " complete longest common prefix first

" miscellany
set scrolloff=2                 " always have 2 lines of context on the screen


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings
" Swaps selection with buffer
vnoremap <C-X> <Esc>`.``gvP``P

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and syntax
" in GUI or color console, enable coloring and search highlighting
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  set hlsearch
endif

set t_Co=256  " force 256 colors
colorscheme molokai

if has("autocmd")
  " Filetypes and indenting settings
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif " has("autocmd")

" template detection
" Template Toolkit
au BufNewFile,BufRead *.tt setf tt2html
let b:tt2_syn_tags = '\[% %]'
" Mako
au BufNewFile,BufRead *.mako setf mako

" trailing whitespace; must define AFTER colorscheme, setf, etc!
hi WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+\%#\@<!$/
