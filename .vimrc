""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Author: 
"    Karthik Balu
"    http://sites.google.com/site/balukarthik/
"
" Location:
"   https://github.com/Setup/.vimrc
" 
" Goals: 
"   1) Simple: No functions
"   2) Self sufficient: No dependency on outside packages or schemes 
"   3) Cross-platform: No platform specific functionality 
"
"
" Acknowledgements:
"   1) Amir Salihefendic (http://amix.dk - amix@amix.dk)
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=500

" Set to autoread when a file is changed from the outside
set autoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets scroll off so cursor stays few lines above/below top/bottom of screen
set so=7

" Turn on wildmenu for command line completion
set wildmenu

" Show the current cursor position
set ruler

" Set height of the command bar
set cmdheight=2

" Allows abandoning buffers without saving 
set hid

" Configure backspace correctly
set backspace=eol,start,indent

" Allow cursor to wrap correctly
set whichwrap+=<,>,[,]

" Ignore case while searching
set ignorecase

" When searching try to be smart about case
set smartcase

" Highlight search results
set hlsearch

" Don't redraw while executing macros
set lazyredraw

" For regular expressions turn on magic
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Add extra margin to the left
set foldcolumn=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""   

" Enable syntax highlighting
syntax enable
"
" Enable 256 colors palette in Gnome Terminal
set t_Co=256
try
  colorscheme gruvbox
catch
endtry

"               set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, backups and undo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs 
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=0

" Linebreak on 500 characters
set lbr
set tw=500
  
set ai "Auto indent
set si "Smart indent
set cindent "cindent

set wrap "Wrap lines

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Always show the status line
set laststatus=2

"Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c\ Length:%L

"Set dark background
set background=dark

"Set font according to OS
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata \12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h9:cANSI
  endif
endif     

"Copy to system clipboard
set clipboard=unnamed

"No need for vi compatibility
set nocompatible

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Set the leader 
let mapleader = ","
