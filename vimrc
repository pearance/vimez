" Name: VimEz vimrc
" Description: A robust Vim IDE distribution.
" Maintainer: Fontaine Cook <fontaine.cook@pearance.com
" Dependencies: Requires Vim 7.2 or higher.
" Version: 0.1a



" ****************************************************
" CONTENT:
" ****************************************************
" + General Settings
" + File/Buffer
" + Edit
" + View
" + Navigation
" + Libraries
"   - Snippets
"   - Abbreviations
"   - Commands
" + Tools
" + Window
" + Help



" "Initialization" 
source $HOME/.vim/initrc    " Include dependent plugin bundles.
runtime $VIMRUNTIME/macros/matchit.vim
runtime $VIMRUNTIME/ftplugin/man.vim
"-----------------------------------------------------------------------------



"*****************************************************************************
" GENERAL SETTINGS: "{{{1
"*****************************************************************************
" "Color Scheme"
set background=dark         " Use a dark background. 
set t_Co=256                " Force terminal to go into 256 color mode.
colorscheme vimez	    " Default color scheme for the VimEz distribution.
syntax on		    " Syntax highlighting on.
"-----------------------------------------------------------------------------



" "Leader Key" 
let mapleader="\<Space>"    " Map personal modifier aka Leader key.
"-----------------------------------------------------------------------------



" "Commandline" More convenient entrance to Commandline mode from Normal mode.
map ; :
noremap ;; ;
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













"*****************************************************************************
" FILE/BUFFER: "{{{2
"*****************************************************************************
" "General File/Buffer Settings"
set hidden      " Hide buffers when they are abandoned
set confirm     " Provide user friendly prompt over nasty error messages.
set autoread    " Automatically re-read a file if modified outside of vim.
set shellslash  " Use forward slash for shell file names (Windows)
"-----------------------------------------------------------------------------



" "Open/Edit File" Give a prompt for opening files in the same dir as the
" current buffer's file.
if has("unix")
  nnoremap <leader>ef :e <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <leader>ef :e <C-R>=expand("%:p:h") . "\\" <CR>
endif
"-----------------------------------------------------------------------------



" "Rename File (Rename2)" This is handled by the Rename2 plugin and provides the following
" command: Rename[!] {newname}.
nmap <leader>rf :Rename<Space>
"-----------------------------------------------------------------------------



" "Browse Files (NERDTree)" Conventional file browser panel with bookmarking
" abilities. Provides an efficient way to view file hierarchies.
let NERDTreeChDirMode=2
nnoremap <leader><CR> :NERDTreeToggle .<CR>
"-----------------------------------------------------------------------------



" "Search Files (Command-T)" Faster alternative of locating and opening
" files, than the conventional browsing of a directory tree.
let g:CommandTMaxHeight=10                    " Show this amount of results max
let g:CommandTAcceptSelectionSplitMap=['/']   " Key to open file in vsplit win
let g:CommandTAcceptSelectionVSplitMap=[';']  " Key to to open file in vsplit win
let g:CommandTCancelMap=[',']                 " Key to cancel Command-T
nmap <silent> <leader>kk :CommandT<CR>
"-----------------------------------------------------------------------------



" "New Buffer"
nnoremap <leader>nb :enew<CR>
"-----------------------------------------------------------------------------
  


" "Write Buffer"
nmap <silent> <leader>w :write<CR>
nmap <silent> <leader>wb :write<CR>
inoremap <silent> <C-s> :update<CR>
nnoremap <silent> <C-s> :update<CR>
vnoremap <silent> <C-s> :update<CR>



" "Write All Buffers" Write all modified buffers. Buffers without a filename will not be
" saved.
nmap <silent> <leader>wa :wall<CR>:exe ":echo 'All buffers saved to files!'"<CR>



" "Close Buffer (BufKill)"
nmap <silent> <leader>cb :BD<CR>



" "Close Buffer & Window"
nmap <silent> <leader>cbb :bd<CR>



" "Write on Focus Lost" Write all buffers to file upon leaving buffer
" (gvim only).
au FocusLost * silent! wa



" "Write Session" Save the current session. Including buffers, untitled blank
" buffers, current directory, folds, help, options, tabs, window sizes.
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
nmap <leader>ws :SaveSession<CR>


" "Backups"
set backup                        " Keep backup file after overwriting a file
set writebackup                   " Make a backup before overwriting a file

 " List of directories for the backup file
if has("win32") || has("win64")
  set backupdir=$TMP              " TODO: Set for Windows and Mac environments
else
  set backupdir=$HOME/.vim/tmp/backups
end



" "Swap Files" This creates a binary version of each file as a backup in the
" event there is a crash, you have a shot at recovering your file. The swap is
" updated on every 100th character.
set updatecount=100
if has("win32") || has("win64")   " TODO: Set for Windows and Mac environments
  set directory=$TMP
else
  set directory=$HOME/.vim/tmp/swaps
end



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











