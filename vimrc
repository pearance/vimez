" Name: VimEz vimrc
" Description: A robust Vim IDE distribution.
" Maintainer: Fontaine Cook <fontaine.cook@pearance.com
" Dependencies: Requires Vim 7.2 or higher.
" Version: 0.1a



"*****************************************************************************
" GENERAL SETTINGS: "{{{1
"*****************************************************************************
" "ViMproved"
set nocompatible            " Harnest the iMprovements brough by Vim.



" "Color Scheme"
set background=dark         " Use a dark background. 
set t_Co=256                " Force terminal to go into 256 color mode.
colorscheme vimez	    " Default color scheme for the VimEz distribution.
syntax on		    " Syntax highlighting on.
"-----------------------------------------------------------------------------



" "Plugin Bundles" 
filetype on                 " Turn on file type detection, required for Mac.
filetype off                " Turn it off so run time paths can be set.
source $HOME/.vim/initrc    " Include dependent plugin bundles.
"-----------------------------------------------------------------------------



" "Leader Key" 
let mapleader="\<Space>"    " Map personal modifier aka Leader key.
"-----------------------------------------------------------------------------



" "History"
set history=256        " Amount of commands and searches to keep in history.
"-----------------------------------------------------------------------------



" "Vim Info"
set viminfo='1000,f1,<500,h " Save local/global marks, registers, etc
"-----------------------------------------------------------------------------



" "Character Encoding" Default to UTF-8 character encoding unless the terminal
" doesn't support it. In which case use Latin1 character encoding instead.
if has("multi_byte")
  set encoding=utf-8
  if $TERM == "linux" || $TERM_PROGRAM == "GLterm"
    set termencoding=latin1
  endif
  if $TERM == "xterm" || $TERM == "xterm-color"
    let propv = system("xprop -id $WINDOWID -f WM_LOCALE_NAME 8s ' $0' -notype WM_LOCALE_NAME")
    if propv !~ "WM_LOCALE_NAME .*UTF.*8"
      set termencoding=latin1
    endif
  endif
endif
"-----------------------------------------------------------------------------



" "Restore Cursor Position" Restore original cursor position when reopening a file.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"-----------------------------------------------------------------------------



" "Performance Tweaks"
set ttyfast            " Indicates a fast terminal connection.
set synmaxcol=2048     " Prevent long lines from slowing down redraws.
"-----------------------------------------------------------------------------



" "Timeout Length" The time waited for a key code or mapped key sequence to
" complete.  As you become more fluent with the key mappings you may want toC
" drop this to 250.
set timeoutlen=500
"-----------------------------------------------------------------------------



" "Mouse"
set mouse=a                       " Onable mouse usage (all modes)
set selectmode=mouse              " Selection with the mouse trigers Select mode
set ttymouse=xterm2               " Enable basic mouse functionality in a terminal
"map <MouseMiddle> <esc>"*p	  " TODO: requires more testing
"-----------------------------------------------------------------------------


" "Update Time" How frequent marks, statusbar, swap files, and other are updated.
set updatetime=1000 



" "Edit Vimrc" This would be Vim's version of [Edit Preferences] :-) Upon saving
" the file is sourced so most of time your changes should take effect
" immediately. However, some changes will only take effect after restarting Vim.
nmap <silent> <leader>ev :e $MYVIMRC<CR>
"-----------------------------------------------------------------------------



" "Edit Initrc"
nmap <silent> <leader>ei :e $HOME/.vim/initrc<CR>
"-----------------------------------------------------------------------------



" "Edit Color Scheme"
nmap <silent> <leader>ecs :e $HOME/.vim/colors/vimez.vim<CR>
"-----------------------------------------------------------------------------



" "Refresh Vim"
map <F5> :so $MYVIMRC<CR>:filetype detect<CR>:nohlsearch<CR>:exe ":echo 'vimrc reloaded'"<CR>
"-----------------------------------------------------------------------------
" "}}}








" "File Types"
filetype plugin indent on   " Automatically detect file types.
"-----------------------------------------------------------------------------







"*****************************************************************************
" FILE: "{{{2
"*****************************************************************************
" "General File/Buffer Settings"
set hidden      " Hide buffers when they are abandoned
set confirm     " Provide user friendly prompt over nasty error messages.
set autoread    " Automatically re-read a file if modified outside of vim.
set shellslash  " Use forward slash for shell file names (Windows)
"-----------------------------------------------------------------------------



" "}}}










"*****************************************************************************
" NAVIGATION: "{{{2
"*****************************************************************************

" "Escape"
" Escape from the dreaded Insert and Commandline modes to the graces of
" the beloved Normal mode.
inoremap jj <Esc>
inoremap JJJ <Esc>
cnoremap jj <C-c>
cnoremap JJ <C-c>
"-----------------------------------------------------------------------------
" "}}}











