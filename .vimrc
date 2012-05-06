" use Vim settings, rather than Vi settings. 
" This must be first, because it changes other options as a side effect.
set nocompatible

" Set terminal title to filename
set title

" Switch syntax highlighting on.
syntax on

" Enable loading the plugin files for specific file types.
filetype plugin on

" Enable loading the indent file for specific file types.
filetype indent on

" Copy indent from current line when starting a new line.
set autoindent

" disable usage of cursor keys within insert mode, removes delay when pressing
" <Shift><o> immediately after <Esc>.
set noesckeys

" Fix the delete key
:fixdel

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4

" Controls how many columns Vim uses when <Tab> is pressed in insert mode.
set softtabstop=4

" When set, hitting <Tab> in insert mode will produce the appropriate
" number of spaces.
set expandtab 

" How many columns text is indented with reindent operations (>> & <<) and 
" automatic C-style indentation
set shiftwidth=4

" When on, a <Tab> in front of a line inserts balnks according to 'shiftwidth'
set smarttab

" Influences the working of <BS>, <Del>, <CTRL-W>, <CTRL-U> in Insert mode.
" This is a list of items, separated by commas. Each item allows a way to
" backspace over something:
" value     effect
" indent    allow backspacing over autoindent
" eol       allow backspacing over line breaks (join lines)
" start     allow backspacing over the start of insert; CTRL-W and CTRL-U stop
"           once at the start of insert.
set backspace=indent,eol,start

" Maximum width of text that is being inserted. A longer line will be broken
" after whitespace to get this width. A zero value disables this.
set textwidth=79

" When set to dark, Vim will try to use colors that look good on a dark
" background.
set background=dark

" Set the color scheme.
colorscheme slate

" Print the line number in front of each line.
set number

" While typing a search command, show where the pattern, as it was typed so far,
" When a bracket is inserted, briefly jump to the matching one. A Beep is given
" if there is no match.
set showmatch

" Highlight the screen line of the cursor with CursorLine.
" set cursorline " cursorcolumn
