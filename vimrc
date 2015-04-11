" vim:ft=vim:fdm=marker:
"         _
"  __   _(_)_ __ ___  _ __ ___
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__
"    \_/ |_|_| |_| |_|_|  \___|
"
" Authors:       Fontaine Cook, Various Contributors
" Description:   The primary Vim configuration file.
"-------------------------------------------------------------------------------

" BOOTSTRAP:"{{{
" ******************************************************************************
" "## Pre Config:"{{{
set nocompatible
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:vundle_default_git_proto = 'git'
Bundle "gmarik/vundle"
"}}}
" "## Plugin Bundles:"{{{
" Syntax
Bundle "vim-scripts/CSApprox"
Bundle "vim-scripts/ScrollColors"
Bundle "vimez/vimez-themes"
Bundle "nelstrom/vim-markdown-folding"
Bundle "pangloss/vim-javascript"
Bundle "elzr/vim-json"
Bundle "groenewege/vim-less"
Bundle "tpope/vim-markdown"
Bundle "tpope/vim-haml"
Bundle "scrooloose/syntastic"
Bundle "digitaltoad/vim-jade"
Bundle "tpope/vim-git"
Bundle "wavded/vim-stylus"
Bundle "briancollins/vim-jst"
Bundle "Rykka/colorv.vim"
Bundle "jimmyhchan/dustjs.vim"

" Functional
Bundle "Shougo/neocomplcache"
Bundle "Shougo/neosnippet"
Bundle "bling/vim-airline"
Bundle "vimez/vim-tmux"
Bundle "vim-scripts/YankRing.vim"
Bundle "vim-scripts/SyntaxAttr.vim"
Bundle "tomtom/tcomment_vim"
Bundle "sjl/gundo.vim"
Bundle "docunext/closetag.vim"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-repeat"
Bundle "kien/ctrlp.vim"
Bundle "benmills/vimux"
Bundle "duff/vim-bufonly"
Bundle "scrooloose/nerdtree"
Bundle "vim-scripts/Rename2"
Bundle "godlygeek/tabular"
Bundle "endel/ctrlp-filetype.vim"
Bundle "Raimondi/delimitMate"
Bundle "tpope/vim-fugitive"
Bundle "gregsexton/gitv"
Bundle "tpope/vim-unimpaired"
Bundle "mattn/webapi-vim"
Bundle "mattn/gist-vim"
Bundle "mhinz/vim-signify"
Bundle "terryma/vim-multiple-cursors"
Bundle "mattn/emmet-vim"
Bundle "vimez/vimez-snips"
Bundle "mattn/livestyle-vim"
Bundle "mhinz/vim-startify"
Bundle "editorconfig/editorconfig-vim"
Bundle "AndrewRadev/splitjoin.vim"
Bundle "vim-scripts/indenthtml.vim"
Bundle "edkolev/tmuxline.vim"
" Bundle "gavinbeatty/dragvisuals.vim"
"}}}
" "## Post Config:"{{{
filetype plugin indent on
"}}}










"}}}
" GENERAL:"{{{
" ******************************************************************************
" "## Start Screen""{{{
" options: ['sessions', dir', 'files', 'bookmarks']
let g:startify_list_order = ['sessions', 'files']
let g:startify_files_number = 10
let g:startify_change_to_dir = 1
let g:ctrlp_reuse_window = 'startify'
let g:startify_skiplist = [
  \ 'COMMIT_EDITMSG',
  \ ]
let g:startify_bookmarks = [
  \ '',
  \ ]
let g:startify_custom_header = [
  \ '                              ',
  \ '                              ',
  \ '                              ',
  \ '        _                     ',
  \ ' __   _(_)_ __ ___   ___ ____ ',
  \ ' \ \ / | | `_ ` _ \ / _ |_  / ',
  \ '  \ V /| | | | | | |  __// /  ',
  \ '   \_/ |_|_| |_| |_|\___/___| ',
  \ '                              ',
  \ '           develop            ',
  \ '',
  \ '',
  \ '',
  \ '',
  \ ]

nnoremap <silent><Leader><Tab> :Startify<CR>
"}}}
" "## Commandline""{{{
" More convenient entrance to Commandline and Commandline Edit mode from Normal mode.
nnoremap ; :
vnoremap ; :
nnoremap ;; ;
nnoremap q; q:
"-------------------------------------------------------------------------------

"}}}
" "## Runtime Scripts""{{{
" set runtimepath=~/.dotfiles/vim.local/,$VIMRUNTIME
runtime macros/matchit.vim
runtime ftplugin/man.vim
source $VIMRUNTIME/ftplugin/man.vim
"-------------------------------------------------------------------------------

"}}}
" "## Time Settings""{{{
set timeoutlen=500
set updatetime=1000
"-------------------------------------------------------------------------------

"}}}
" "## Leader Keys""{{{
let mapleader="\<Space>" " Global mod key.
let maplocalleader="\\"  " Local mod key primarily for filetype specific maps.
"-------------------------------------------------------------------------------

"}}}
" "## Encoding""{{{
" Default to UTF-8 character encoding unless the terminal doesn't support it. In
" which case use Latin1 character encoding instead.
if has("multi_byte")
  set encoding=utf-8
  scriptencoding utf-8
  if $TERM == "linux" || $TERM_PROGRAM == "GLterm"
    set termencoding=latin1
  endif
  if $TERM == "xterm" || $TERM == "xterm-color" || $TERM == "screen256-color"
    let propv = system
    \ ("xprop -id $WINDOWID -f WM_LOCALE_NAME 8s ' $0' -notype WM_LOCALE_NAME")
    if propv !~ "WM_LOCALE_NAME .*UTF.*8"
      set termencoding=latin1
    endif
  endif
endif
"-------------------------------------------------------------------------------

"}}}
" "## Modelines""{{{
set modeline
set modelines=5

"}}}
" "## Color Scheme""{{{
set t_Co=256                " Force terminal to go into 256 color mode.
set synmaxcol=300           " Prevent long lines from slowing down redraws.
syntax on                   " Syntax highlighting on.
silent! colorscheme molokaiez

" Show syntax highlighting group for current word.
nnoremap <Leader>syn :call SyntaxAttr()<CR>
"}}}










"}}}
" FILE:"{{{
" ******************************************************************************
" "## General Settings""{{{
set fileformats=unix,dos,mac
set hidden         " Hide buffers when they are abandoned
set confirm        " Provide user friendly prompt over nasty error messages.
set autoread       " Automatically re-read a file if modified outside of vim.
set autowrite      " Automatically write a file on certain operations.
set noshellslash   " Use forward slash for shell file names (Windows)
set winminwidth=0
set winminheight=0

" Backups.
set backup       " Keep backup file after overwriting a file.
set writebackup  " Make a backup before overwriting a file.
set backupdir=~/.dotfiles/vim.local/tmp/backups//
if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

" Swap files.
set updatecount=100
set directory=~/.dotfiles/vim.local/tmp/swaps//
if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" Views.
set viewdir=~/.dotfiles/vim.local/tmp/view//
set viewoptions=folds,cursor,unix,slash

" Vim Info.
" A memory dump to remember information from the last session. The viminfo file
" is read upon startup and written when exiting Vim.
set viminfo=
set vi+='1000 " Amount of files to save marks
set vi+=f1    " Store global marks A-Z and 0-9
set vi+=<500  " How many registers are saved
set vi+=:500  " Number of lines to save from the command line history
set vi+=@500  " Number of lines to save from the input line history
set vi+=/500  " Number of lines to save from the search history
set vi+=r/tmp " Removable media, for which no marks will be stored
set vi+=!     " Global variables that start with an uppercase letter and
              " don't contain lowercase letters
set vi+=h     " Disable 'hlsearch' highlighting when starting
set vi-=%     " Buffer list (restored when starting Vim without arguments)
set vi+=c     " Convert the text using 'encoding'
set vi+=s100  " Max amount of kilobytes of any single register.
set vi+=n~/.dotfiles/vim.local/tmp/viminfo
"-------------------------------------------------------------------------------

"}}}
" "## Buffer Management""{{{
" "### Create/Find/Open"{{{
" Open files via browser (NERDTree)
let NERDTreeBookmarksFile = expand('~/.dotfiles/vim.local/tmp/NERDTreeBookmarks')
let NERDTreeChDirMode = 2
let NERDTreeMapOpenSplit = 'sh'
let NERDTreeMapPreviewSplit = 'ph'
let NERDTreeMapOpenVSplit = 'sv'
let NERDTreeMapPreviewVSplit = 'pv'
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen  =  1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeKeepTreeInNewTab=1
let NERDTreeWinPos = "left"
nnoremap <silent><Leader>bb :nohlsearch<CR>:NERDTreeFind<CR>:NERDTreeMirror<CR>

" Open files via search (CtrlP)"
let g:ctrlp_map = '<Leader>ll'
let g:ctrlp_cache_dir = '~/.dotfiles/vim.local/tmp/ctrlp/'
let g:ctrlp_open_multiple_files = '1vjr'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode  = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|tmp|temp)\|tmp\|temp\|node_modules$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': '',
  \ }
let g:ctrlp_prompt_mappings = {
\ 'PrtExit()':            ['<esc>', ','],
\ 'CreateNewFile()':      ['<c-b>'],
\ }
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }
let g:ctrlp_extensions = ['filetype']

nnoremap <silent><Leader>kk :CtrlPMixed<CR>
nnoremap <silent><Leader>hh :CtrlP<CR>
nnoremap <silent><Leader>jj :CtrlPBuffer<CR>
nnoremap <silent><Leader>ll :CtrlPMRU<CR>
nnoremap <silent><Leader>ff :CtrlPFiletype<CR>

" Open files via paths in buffers.
nnoremap gfh :wincmd f<CR>
nnoremap gfv :vertical wincmd f<CR>
"-------------------------------------------------------------------------------

" Reload buffer.
nnoremap <silent>,re :e<CR>
"-------------------------------------------------------------------------------

"}}}
" "### Navigate""{{{
" List all buffers.
nnoremap <silent><Leader>lb :ls!<CR>

" Flip through buffer list.
nnoremap <silent>gh :bprev<CR>
nnoremap <silent>gl :bnext<CR>

" Flip back to last buffer.
nnoremap <Leader><BS> <C-^>



"}}}
" "### Write""{{{
" Write buffer
nnoremap <silent><Leader>w :write<CR>
nnoremap <silent><Leader>wb :write<CR>

" Write a partial buffer
vnoremap <silent><Leader>w :write<CR>
vnoremap <silent><Leader>wb :write<CR>

" Write all buffers
nnoremap <silent><Leader>wa :wall<CR>:echo 'All buffers written'<CR>
nnoremap <silent><Leader>wab :wall<CR>:echo 'All buffers written'<CR>

" Write buffer and quit
nnoremap <silent><Leader>wq :wq<CR>

" Write and quit all buffers and windows
nnoremap <silent><Leader>wqa   :confirm wqa<CR>

" Write buffer as
nnoremap <Leader>wba :write <C-R>=expand("%:p:h") . "/" <CR>

" Write buffer as root
cmap w!! w !sudo tee % >/dev/null



"}}}
" "### Close""{{{
" Close the current buffer.
nnoremap <silent><Leader>cb :<C-u>Kwbd<CR>

" Close the current buffer and quit the window.
nnoremap <silent><Leader>cbb :bdelete<CR>

" Close all buffers.
nnoremap <silent><Leader>cab :exec "1," . bufnr('$') . "bd"<CR>
\ :echo 'All buffers closed'<CR>

" Close all inactive buffers.
nnoremap <silent><Leader>cib :silent! call CloseInactiveBuffers()<CR>
\ :echo 'All inactive buffers closed'<CR>

" Close all unlisted buffers.
nnoremap <silent><Leader>cub :silent! call CloseUnlistedBuffers()<CR>
\ :echo 'All unlisted buffers closed'<CR>

" Close other buffers (BufOnly)
nnoremap <silent><Leader>cob :BufOnly<CR>



"}}}
" "### Copy""{{{
" Edit new copy of the current buffer.
nnoremap <Leader>eba :saveas <C-R>=expand("%:p:h") . "/" <CR>
"
"
"
"}}}
" "### Rename""{{{
" Rename current buffer (Rename2).
nnoremap <Leader>rb :Rename<Space>



"}}}
" "### Delete""{{{
" Delete the current buffer and file.
nnoremap <Leader>DEL :call DeleteBufferFile()<CR>
"}}}










"}}}
" "## Window Management""{{{
" "### Focus""{{{
" Focus adjacent windows (including tmux panes)
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      " redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  nnoremap <C-h> <C-w>h
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-l> <C-w>l
endif



"}}}
" "### Split""{{{
" Split window
set splitright
set splitbelow
nnoremap <silent>sh :set nosplitright<CR>:vsplit\|bnext<CR>
nnoremap <silent>sj :set splitbelow<CR>:split\|bnext<CR>
nnoremap <silent>sk :set nosplitbelow<CR>:split\|bnext<CR>
nnoremap <silent>sl :set splitright<CR>:vsplit\|bnext<CR>



"}}}
" "### Move""{{{
" Move current window
nnoremap mh <C-w>H
nnoremap mj <C-w>J
nnoremap mk <C-w>K
nnoremap ml <C-w>L
nnoremap mx <C-w>x



"}}}
" "### Resize""{{{
" Resize windows
nnoremap <Left>  <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up>    <C-w>+
nnoremap <Up>    <C-w>+
nnoremap <Down>  <C-w>-

" Maximize and restore window
let g:windowmaximized = 0
map <silent><F11> :call MaxRestoreWindow()<CR>
"}}}
" "### Quit""{{{
" Quit adjacent windows
nnoremap <silent>qh :wincmd h<CR>:close<CR>
nnoremap <silent>qj :wincmd j<CR>:close<CR>
nnoremap <silent>qk :wincmd k<CR>:close<CR>
nnoremap <silent>ql :wincmd l<CR>:close<CR>

" Quit currently focused window
nnoremap <silent>qq :confirm quit<CR>

" Quit all other windows
nnoremap <silent>qo :only<CR>

" Quit all windows without writing
nnoremap <silent>qa  :NERDTreeClose<CR>:confirm qall<CR>
nnoremap <silent><C-q>  :NERDTreeClose<CR>:confirm qall<CR>
"}}}










"}}}
" "## Tab Management""{{{
" Previous tab
nnoremap <silent>gj :tabprevious<CR>

" Next tab
nnoremap <silent>gk :tabnext<CR>

" New tab
nnoremap <silent><Leader>nt :tabnew<CR>

" Quit tab
nnoremap <silent><Leader>qt :tabclose<CR>










"}}}
" "## Session Management""{{{
" Changes the effect of the :mksession command. It is a comma separated list of
" words.  Each word enables saving and restoring something:
set sessionoptions=
set ssop+=blank        " Blank	empty windows
set ssop+=buffers      " Hidden and unloaded buffers, not just those in windows
set ssop+=curdir       " The current directory
set ssop+=folds        " Manually created folds, opened/closed folds and local
                       " fold options
set ssop-=globals      " Global variables that start with an uppercase letter
                       " and contain at least one lowercase letter.  Only
                       " String and Number types are stored.
set ssop+=help         " Restore help windows.
set ssop+=localoptions " Options and mappings local to a window or buffer (not
                       " global values for local options)
set ssop+=options      " All options and mappings (also global values for local
                       " options)
set ssop+=resize       " Size of the Vim window: 'lines' and 'columns'
set ssop-=sesdir       " The directory in which the session file is located
                       " will become the current directory (useful with
                       " projects accessed over a network from different
                       " systems)
set ssop+=slash        " Backslashes in file names replaced with forward
                       " slashes
set ssop+=tabpages     " All tab pages; without this only the current tab page
                       " is restored, so that you can make a session for each
                       " tab page separately
set ssop+=unix         " With Unix end-of-line format (single <NL>), even when
                       " on Windows or DOS
set ssop+=winpos       " Position of the whole Vim window
set ssop+=winsize      " Window sizes

" Startify"
let g:startify_session_dir = '~/.dotfiles/vim.local/tmp/sessions'
let g:startify_session_detection = 1
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
nnoremap <silent><Leader>ws :SSave<CR>
nnoremap <silent><Leader>ds :SDelete<CR>
nnoremap <silent><Leader>os :SLoad<CR>
"}}}










"}}}
" EDIT:"{{{
" ******************************************************************************
" "## Yank/Delete/Put""{{{
" Plugin (Yankring)
set clipboard+=unnamed " Use system clipboard for yanks.
set pastetoggle=<F12>  " Preserve indentation when putting formatted text.
nnoremap <silent><F12> :set invpaste<CR>

" Put over current WORD (repeatable)
nnoremap <Leader>p ciw<C-r>0<Esc>

" Put & select
nnoremap gp p`[V`]`]

" Select pasted text
nnoremap ,v `[V`]`]

function! YRRunAfterMaps()
  nnoremap <silent>Y  :<C-u>YRYankCount 'y$'<CR>
  nnoremap <silent>yh :<C-u>YRYankCount 'y0'<CR>
  nnoremap <silent>yj :<C-u>YRYankCount 'yG'<CR>
  nnoremap <silent>yk :<C-u>YRYankCount 'ygg'<CR>
  nnoremap <silent>yl :<C-u>YRYankCount 'y$'<CR>

  " Preserve the yank post selection/put
  vnoremap <silent>p :<C-u>YRPaste 'p', 'v'<CR>gv:YRYankRange 'v'<CR>

  " Put and respect surrounding indentation
  nmap <silent>p :<C-u>YRYankCount ']p`]l'<CR>
  nmap <silent>P :<C-u>YRYankCount ']P`]l'<CR>

  " Yank current WORD
  nnoremap <Leader>y yiwe

  " Yank current LINE (characterwise)
  nnoremap <Leader>yy 0y$$l

  " Yank current LINE (linewise)
  nnoremap yy yy$l

  " Yank current BLOCK
  nnoremap ,y yip}
  vnoremap y "*y}k$l

  " Delete current WORD
  nnoremap <Leader>d diw

  " Delete contents of a line only
  nnoremap <silent><Leader>dd cc<Esc>

  " Simple delete key in insert mode
  inoremap <C-d> <Del>

  " Delete contents of several lines only
  vnoremap <silent><Leader>dd 0r<Space>

  " Delete into a black hole (Cut)
  nnoremap ,dd "_dd
endfunction

" Open YankRing browser
nnoremap <silent><Leader>rr :YRShow<CR>

let g:yankring_max_history = 1000
let g:yankring_dot_repeat_yank = 1
let g:yankring_window_height = 7
let g:yankring_min_element_length = 3
let g:yankring_manual_clipboard_check = 1
let g:yankring_history_dir = '~/.dotfiles/vim.local/tmp/'
let g:yankring_history_file = 'yankring_herstory'

" Bracketed Paste Mode
" http://www.xfree86.org/current/ctlseqs.html
" http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
if &term =~ "xterm.*"
  let &t_ti = &t_ti . "\e[?2004h"
  let &t_te = "\e[?2004l" . &t_te
  map <expr> <Esc>[200~ XTermPasteBegin("i")
  imap <expr> <Esc>[200~ XTermPasteBegin("")
  cmap <Esc>[200~ <nop>
  cmap <Esc>[201~ <nop>
endif
"}}}
" "## MultiCursors"{{{
"
"}}}
" "## Paragraph Formatting""{{{
vnoremap Q gq
nnoremap Q gqip



"}}}
" "## Undo""{{{
" Plugin (Gundo)
" Persistent undo, along with Gundo to parse the undo history.
set undolevels=1000
set undofile
set undodir=~/.dotfiles/vim.local/tmp/undos//
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif
let g:gundo_help=1
let g:gundo_preview_bottom=1
nnoremap <silent><Leader>uu :silent! GundoToggle<CR>



"}}}
" "## Nudge""{{{
" nnoremap ,<Space> i<Space><Esc>l
"}}}
" "## Select All""{{{
nnoremap <C-a> ggVG
nnoremap <Leader>a ggVG
"-------------------------------------------------------------------------------

"}}}
" "## Line/Fold Movement""{{{
" Consistent use of [hjkl] with the Shift modifier to move a line of text
" around. Up/down by one line and left/right by amount of shiftwidth.

nnoremap H <<^
nnoremap L >>^
nnoremap <silent>J ddp
nnoremap <silent>K ddkP
"-------------------------------------------------------------------------------

"}}}
" "## Block Movement""{{{
" Consistent use of [hjkl] with the Shift modifier to move a block of text
" around. Up/down by one line and left/right by amount of shiftwidth.
vnoremap H <gv^
vmap J ]egv
vmap K [egv
vnoremap L >gv^
"-------------------------------------------------------------------------------

"}}}
" "## Breaks and New Lines""{{{
" Break to line below in NORMAL mode.
nnoremap <CR> i<CR><Esc>

" Break to line above in NORMAL mode.
nnoremap <Leader><CR> DO<Esc>p

" Create a new line below/above in NORMAL mode.
nnoremap  \<CR> o<Esc>
nnoremap \\<CR> O<Esc>

" Create a new line below/above in INSERT mode.
inoremap  \<CR> <Esc>o
inoremap \\<CR> <Esc>O

" Break inline XML content to block format.
inoremap <C-\><CR> <Esc>diti<CR><Esc>O<Tab><Esc>p^i
nnoremap <C-\><CR> <Esc>diti<CR><Esc>O<Tab><Esc>p^
"-------------------------------------------------------------------------------

"}}}
" "## Join Next/Previous Line""{{{
" Normally Shift-j joins the line below with the current one, but felt it best
" to maintain [hjkl] as directional arrow keys. So, this functionality is mapped
" to Leader jn and jp for join next (line below) and join previous (line above)
" with the current line.
set nojoinspaces
nnoremap <silent><Leader>jn :call Join()<CR>x
nnoremap <silent><Leader>jp k<S-v>xpk:call Join()<CR>

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

nmap <silent><LocalLeader>k :SplitjoinJoin<cr>
nmap <silent><LocalLeader>j :SplitjoinSplit<cr>
let g:splitjoin_align = 1
let g:splitjoin_normalize_whitespace = 0
"}}}
" "## Case Manipulation""{{{
" To avoid nasty accidents when attempting to undo while in Visual mode.
vnoremap u <Esc>u
vnoremap gu u
vnoremap gU U
"-------------------------------------------------------------------------------

"}}}
" "## Alignment""{{{
" Plugin (Tabularize)"
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
"-------------------------------------------------------------------------------

"}}}
" "## Spell Checking""{{{
" Make sure to update the spelllang to your language. Custom words are tucked
" away in the .vim/spell folder.
set spelllang=en_us       " Default language
set spellsuggest=5        " How many spelling suggestions to list
set spellfile=~/.dotfiles/vim.local/dictionaries/en.utf-8.add " Custom spell file
nmap <silent><Leader>ts
      \ :setl spell!<CR><Bar>
      \ :let OnOrOff=&spell<CR><Bar>
      \ :call ToggleOnOff(" Spell Checker", OnOrOff)<CR>
"-------------------------------------------------------------------------------

"}}}
" "## Surround"{{{
let g:surround_{char2nr('d')} = "{!\r!}"
" }}}










"}}}
" VIEW:"{{{
" ******************************************************************************
" "Title Bar"
" Detected set paste! Disabled neocomplcache.
set title
set titlestring=%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{hostname()}
"-------------------------------------------------------------------------------



" "Cursor Highlights"
" This helps maintain your bearings by highlighting the current line the cursor
" is on as well as the current column.
set cursorline          " Enable cursor line highlight
set nocursorcolumn      " Enable cursor column highlight
let g:cursorlinestate=1
let g:cursorcolumnstate=0
nnoremap <silent><F2> :call ToggleCursorLine()<CR>
nnoremap <silent><Leader><F2> :call ToggleCursorColumn()<CR>
" nnoremap <silent><F2> :exec &cul==&cuc? "se cul!" : "se cuc!"<CR>
"-------------------------------------------------------------------------------



" "Line Numbers"
set relativenumber
set number
set numberwidth=4
nnoremap <silent><F3> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>
"-------------------------------------------------------------------------------



" "Error Alerts"
set noerrorbells        " No audible alerts on error
set novisualbell        " No blinking on error
"-------------------------------------------------------------------------------



" "File Info"
nnoremap <silent><C-g> 2<C-g>
"-------------------------------------------------------------------------------



" "Messages"
set shortmess+=f " Use "(3 of 5)" instead of "(file 3 of 5)"
set shortmess+=i " Use "[noeol]" instead of "[Incomplete last line]"
set shortmess+=l " Use "999L, 888C" instead of "999 lines, 888 characters"
set shortmess+=m " Use "[+]" instead of "[Modified]"
set shortmess+=n " Use "[New]" instead of "[New File]"
set shortmess+=r " Use "[RO]" instead of "[readonly]"
set shortmess-=w " Use "[w]" instead of "written" for file write message
                 " and "[a]" instead of "appended" for ':w >> file' command
set shortmess+=x " Use "[dos]" instead of "[dos format]", "[unix]" instead
                 " of "[unix format]" and "[mac]" instead of "[mac format]".
set shortmess-=a " All of the above abbreviations
set shortmess+=o " Overwrite message for writing a file with subsequent message
                 " for reading a file (useful for ":wn" or when 'autowrite' on)
set shortmess+=O " Message for reading a file overwrites any previous message.
                 " Also for quickfix message (e.g., ":cn").
set shortmess-=s " Don't give "search hit BOTTOM, continuing at TOP" or "search
                 " hit TOP, continuing at BOTTOM" messages
set shortmess+=t " Truncate file message at the start if it is too long to fit
                 " on the command-line, "<" will appear in the left most column.
set shortmess+=T " Truncate other messages in the middle if they are too long to
                 " fit on the command line.  "..." will appear in the middle.
set shortmess-=W " Don't give "written" or "[w]" when writing a file
set shortmess-=A " Don't give the "ATTENTION" message when an existing
                 " swap file is found.
set shortmess+=I " Don't give the intro message when starting Vim |:intro|.
"-------------------------------------------------------------------------------



" "Wildmenu"
set wildchar=<Tab>
set wildcharm=<C-z>
set wildmenu                 " Enable file/command auto-completion
set wildmode=longest,full    " Auto-complete up to ambiguity
set wildignore+=*.jpg,*.gif,*.bmp,*.png,*.jpeg   " Binary images
set wildignore+=*.DS_Store,Thumbs.db             " Platform files

cmap <C-h> <Left>
cmap <C-l> <Right>
"-------------------------------------------------------------------------------



" "Unprintable Characters"
" This controls visibility of unprintable characters that denote certain
" formatting information. Such as eol, tabs, trailing space, etc.
set list
set listchars=eol:\ ,tab:·\ ,trail:\ ,extends:>,precedes:<
nnoremap <silent><F6>
    \ :setlocal list!<CR><Bar>
    \ :let OnOrOff=&list<CR><Bar>
    \ :call ToggleOnOff("Unprintable Characters", OnOrOff)<CR>
"-------------------------------------------------------------------------------



" "Wraps"
set nowrap              " Turn off wrapping of text
set linebreak           " Wrap at word
set textwidth=80        " Don't wrap lines by default
set whichwrap+=b        " "]" Insert and Replace
set whichwrap+=s        " "[" Insert and Replace
set whichwrap+=h        " "~" Normal
set whichwrap+=l        " <Right> Normal and Visual
set whichwrap+=<        " <Left> Normal and Visual
set whichwrap+=>        " "l" Normal and Visual (not recommended)
set whichwrap+=~        " "h" Normal and Visual (not recommended)
set whichwrap+=[        " <Space> Normal and Visual
set whichwrap+=]        " <BS> Normal and Visual

nnoremap <silent><F9>
    \ :setlocal wrap!<CR><Bar>
    \ :let OnOrOff=&wrap<CR><Bar>
    \ :call ToggleOnOff("Word Wrap", OnOrOff)<CR>
"-------------------------------------------------------------------------------



" "Rule"
let g:rulestate = 1
nnoremap <silent><F5> :call ToggleRule()<CR>
"-------------------------------------------------------------------------------



" "## Folds""{{{
set foldenable
set foldcolumn=5
set foldnestmax=5
set foldlevelstart=0
set foldtext=FoldText()
set fillchars=fold:\ ,vert:\ ,diff:·
set foldmethod=marker

" Ensure x and . mappings work the same on folds.
nnoremap <expr> x ((foldclosed('.')==-1)?('x'):(''))
nnoremap <expr> . ((foldclosed('.')==-1)?('.'):(''))

" Toggle folding on/off.
nnoremap <silent><F4> :call ToggleFolds()<CR>

" Delete a fold.
nnoremap ,df zd

" Delete all folda.
nnoremap ,daf zE

" Close a fold.
nnoremap ,h zc

" Create a fold.
vnoremap ,h zfzc

" Close all folds.
nnoremap ,H zMgg``zz

" Close other folds.
nnoremap ,K zxzz

" Jump to next fold.
" nnoremap ,j zjzz
" vnoremap ,j zjzz

" Jump to previous fold.
" nnoremap ,k zkzz
" vnoremap ,k zkzz

" Open a fold.
nnoremap ,l zo

" Create a fold.
vnoremap ,l zfzc

" Open all folds.
nnoremap ,L zR

nnoremap ,f0 :set foldlevel=0<CR>
nnoremap ,f1 :set foldlevel=1<CR>
nnoremap ,f2 :set foldlevel=2<CR>
nnoremap ,f3 :set foldlevel=3<CR>
nnoremap ,f4 :set foldlevel=4<CR>
nnoremap ,f5 :set foldlevel=5<CR>
"-------------------------------------------------------------------------------



"}}}
" "## Statusline""{{{
set noshowmode                    " Message on status line to show current mode.
set showcmd                       " Show (partial) command in states line.
set laststatus=2                  " Keep status lines visible at all times.
set cmdheight=2                   " Number of lines to use for the command-line.

" "### Airline Settings"{{{
let g:airline_theme='vimez'
let g:airline_inactive_collapse = 0
let g:bufferline_rotate=0
let g:airline_powerline_fonts=1


let g:airline_symbols = {}
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.whitespace = ''
let g:airline_symbols.space = ' '
"}}}
" "### Airline Left Side:"{{{
" Section A
" let g:airline_section_a = ''
let g:airline_mode_map = {
    \ '__' : '    -   ',
    \ 'n'  : '    N   ',
    \ 'i'  : '    I   ',
    \ 'R'  : '    R   ',
    \ 'c'  : '    C   ',
    \ 'v'  : '    V   ',
    \ 'V'  : '    V   ',
    \ '' : '    V   ',
    \ 's'  : '    S   ',
    \ 'S'  : '    S   ',
    \ '' : '    S   ',
    \ }

" Section B
" let g:airline_section_b = ''
let g:airline#extensions#branch#empty_message = 'no ver'

" Section C
let g:airline_section_c = '%t %M'
"}}}
" "### Airline Right Side:"{{{
" Section X
" let g:airline_section_x = ''

" Section Y
let g:airline_section_y = '%{&fenc}   %{&ff}'

" Section Z
let g:airline_section_z = '%04(%l%) :%03(%v%)'
let g:airline#extensions#whitespace#trailing_format = 'trailing: %s'
let g:airline#extensions#whitespace#mixed_indent_format = ' mixed-indent: %s'
"}}}
"}}}
"}}}
" INSERT:"{{{
" ******************************************************************************
" "## Format Options""{{{
set formatoptions=
set fo-=a  " Automatic formatting of paragraphs.  Every time text is inserted or
           " deleted the paragraph will be reformatted.  See |auto-format|.
           " When the 'c' flag is present this only happens for recognized
           " comments.
set fo-=t  " Auto-wrap text using textwidth
set fo+=c  " Auto-wrap comments using textwidth, inserting the current comment
           " Leader automatically.
set fo+=r  " Automatically insert the current comment Leader after hitting
           " <Enter> in Insert mode.
set fo-=o  " Automatically insert the current comment Leader after hitting 'o' or
           " 'O' in Normal mode.
set fo+=q  " Allow formatting of comments with 'gq'.
           " Note that formatting will not change blank lines or lines containing
           " only the comment Leader.  A new paragraph starts after such a line,
           " or when the comment Leader changes.
set fo-=w  " Trailing white space indicates a paragraph continues in the next line.
           " A line that ends in a non-white character ends a paragraph.
set fo+=n  " When formatting text, recognize numbered lists.  This actually uses
           " the 'formatlistpat' option, thus any kind of list can be used.  The
           " indent of the text after the number is used for the next line.  The
           " default is to find a number, optionally followed by '.', ':', ')',
           " ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
           " well together with "2".
           " Example: >
           "	1. the first item
           "		 wraps
           "	2. the second item
set fo+=2  " When formatting text, use the indent of the second line of a paragraph
           " for the rest of the paragraph, instead of the indent of the first
           " line.  This supports paragraphs in which the first line has a
           " different indent than the rest.  Note that 'autoindent' must be set
           " too.  Example: >
           "		first line of a paragraph
           "	second line of the same paragraph
           "	third line.
set fo-=v  " Vi-compatible auto-wrapping in insert mode: Only break a line at a
           " blank that you have entered during the current insert command.  (Note:
           " this is not 100% Vi compatible.  Vi has some 'unexpected features' or
           " bugs in this area.  It uses the screen column instead of the line
           " column.)
set fo-=b  " Like 'v', but only auto-wrap if you enter a blank at or before
           " the wrap margin.  If the line was longer than 'textwidth' when you
           " started the insert, or you do not enter a blank in the insert before
           " reaching 'textwidth', Vim does not perform auto-wrapping.
set fo-=l  " Long lines are not broken in insert mode: When a line was longer than
           " 'textwidth' when the insert command started, Vim does not
           " automatically format it.
set fo-=m  " Also break at a multi-byte character above 255.  This is useful for
           " Asian text where every character is a word on its own.
set fo-=M  " When joining lines, don't insert a space before or after a multi-byte
           " character.  Overrules the 'B' flag.
set fo-=B  " When joining lines, don't insert a space between two multi-byte
           " characters.  Overruled by the 'M' flag.
set fo+=1  " Don't break a line after a one-letter word.  It's broken before it
           " instead (if possible).
"}}}
" "## Auto Completion""{{{
" Native Autocompletion Settings
set complete+=.				" Scan the current buffer ('wrapscan' is ignored)
set complete+=w				" Scan buffers from other windows
set complete+=b				" Scan other loaded buffers that are in the buffer list
set complete+=u				" Scan the unloaded buffers that are in the buffer list
set complete+=U				" Scan the buffers that are not in the buffer list
set complete-=k				" Scan the files given with the 'dictionary' option
set complete+=kspell  " Use the currently active spell checking |spell|
set complete-=k{dict} " Scan the file {dict}.  Several "k" flags can be given,
                      " patterns are valid too.  For example:
                      "		:set complete=k/usr/dict/*,k~/spanish
set complete-=s				" Scan the files given with the 'thesaurus' option
set complete-=s{tsr}	" Scan the file {tsr}.  Several "s" flags can be given,
                      " patterns are valid too.
set complete-=i				" Scan current and included files
set complete-=d				" Scan current and included files for name or macro
                      " |i_CTRL-X_CTRL-D|
set complete+=]				" Tag completion
set complete+=t				" Same as "]"

set infercase					" Match is adjusted depending on the typed text.
set pumheight=20			" Pop Up Menu height in lines

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_max_list = 24
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_temporary_dir = '~/.dotfiles/vim.local/tmp/neocache'

" Enable custom omnicompletion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Below screws up delimitmate
" inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<BS>"
"}}}
" "## Snippets""{{{
let g:neosnippet#disable_runtime_snippets = {'_' : 1,}
let g:neosnippet#snippets_directory = '~/.dotfiles/vim.local/snippets/, ~/.vim/bundle/vimez-snips/'
let g:neosnippet#enable_snipmate_compatibility = 1

" SuperTab like snippets behavior.
imap <Tab>     <Plug>(neosnippet_expand_or_jump)
smap <Tab>     <Plug>(neosnippet_expand_or_jump)
xmap <C-e>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" nnoremap <Leader>es  :NeoSnippetEdit -split -horizontal<CR>
nnoremap <Leader>es  :NeoSnippetEdit -split -horizontal <right>

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"}}}
" "## Macros""{{{
let g:user_emmet_leader_key = '<C-e>'
"}}}
" "## DelimitMate""{{{
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
"}}}
" "## Backspace""{{{
set backspace=indent,eol,start
nnoremap <BS> i<BS><Right><Esc>
"}}}
" "## Indentation""{{{
set expandtab           " Expand tabs using spaces instead of a tab char
set shiftwidth=2        " Amount of shift when in Normal mode
set tabstop=2           " Number of spaces that a <Tab> in the file counts for.
set softtabstop=2       " Set amount of spaces for a tab
set smarttab            " Uses shiftwidth instead of tabstop at start of lines.
set shiftround          " Use multiples of shiftwidth when indenting
set autoindent          " Enable auto indentation
set copyindent          " Copy the previous indentation on autoindenting
set preserveindent      " Preserve existing characters for indenting

  " Give the tab key utiltiy in normal & visual modes.
nnoremap ,<Tab> i<Tab><Esc>

" Toggle soft tab.
nnoremap <silent><F8>
      \ :setlocal expandtab!<CR><Bar>
      \ :let OnOrOff=&expandtab<CR><Bar>
      \ :call ToggleOnOff("Soft Tabs", OnOrOff)<CR>

" Define a Tab command that calls a function that prompts for a tab size and
" applies it uniformally to softtabstop, tabstop, and shiftwidth.
command! -nargs=* Tab call TabSize()
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)

"}}}
" "## Comments""{{{
let g:tcommentOptions = {'mixedindent': 'FALSE'}

" Right forward comment
nmap gcl <C-_>r

" Block comment
nmap gcb <C-_>b

" Inline comment
nmap gci <C-_>ii

" Paragraph comment
nmap gcp <C-_>p

" Visual behave Normal
vmap gcc gc
"}}}
" "## Common Inserts""{{{
" inoremap uu _
" inoremap hh =>
" inoremap aa @
"}}}
"}}}
" NAVIGATION:"{{{
" ******************************************************************************
" "Escape"
inoremap ,, <Esc>l
cnoremap ,, <C-c>
vnoremap ,, <Esc>
"-------------------------------------------------------------------------------



" "Virtual Edit"
set virtualedit+=block
set virtualedit+=insert
set virtualedit+=onemore
set nostartofline
"-------------------------------------------------------------------------------



" "Cursor Movement"
set scrolloff=5         " Start scrolling x lines before the edge of the window.
set sidescrolloff=5     " Same as above just for columns instead of lines.
set lazyredraw
set startofline
nnoremap <Leader>h ^
vnoremap <Leader>h ^
nnoremap <Leader>l $
vnoremap <Leader>l $h

nnoremap <Leader>gj ]`
nnoremap <Leader>gk [`

" Jumps to prev/next edit points
nnoremap g; g;zz
nnoremap g, g,zz

nnoremap <silent><Leader>m :call cursor(0, virtcol('$')/2)<CR>

nnoremap <C-d> jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj
nnoremap <C-u> kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
"-------------------------------------------------------------------------------



" "Marks (Signature)"
" Backtick is more useful than single quote in normal mode.
nnoremap ` '
nnoremap ' `
let g:SignaturePurgeConfirmation = 1
let g:SignatureMarkTextHL = 'SignColumn'
"------------------------------------------------------------------------------"



" "Insert Mode Navigation"
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <Left>  <Nop>
inoremap <Right> <Nop>
inoremap <Up>    <Nop>
inoremap <Up>    <Nop>
inoremap <Down>  <Nop>

"-------------------------------------------------------------------------------



" "Ignore Wrapped Lines"
" Prevent jumping over wrapped lines & use visual lines.
nnoremap j gj
nnoremap k gk
"-------------------------------------------------------------------------------



" "Search"
set hlsearch            " hightlight search terms
set incsearch           " highlight search terms dynamically and incrementally
set ignorecase          " do case insensitive matching
set smartcase           " do smart case matching
set wrapscan            " set the search scan to wrap around the file

nnoremap <silent>,, :nohlsearch<CR>
nnoremap <silent>n nzxzz
nnoremap <silent>N Nzxzz

" Bring up last search in a quickfix window.
nnoremap <silent><Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Highlight current word and maintain cursor position.
nnoremap * *<C-o>
nnoremap # #<C-o>

" Highlight current visual selection.
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>
"-------------------------------------------------------------------------------



" "Find and Replace"
vnoremap <C-f> :call FindReplace()<CR>
"-------------------------------------------------------------------------------



"}}}
" TOOLS:"{{{
" ******************************************************************************
" "Help"
nnoremap <silent><F1> viw"zyw:exe "h ".@z.""<CR>
"-------------------------------------------------------------------------------



" "Man Pages"
let $GROFF_NO_SGR=1
nnoremap <silent><LocalLeader>m :Man <cword><CR>
"-------------------------------------------------------------------------------



" "Vim Management"
nmap <silent><Leader>b<Tab> :Bundle<C-z>
nmap <silent><Leader>iv :BundleInstall<CR>
nmap <silent><Leader>uv :BundleInstall!<CR>
nmap <silent><Leader>cv :BundleClean<CR>
nmap <silent><Leader>lv :BundleList<CR>
"-------------------------------------------------------------------------------



" "Change Directory"
nmap <silent><Leader>cd :cd %:p:h<CR><Bar>:pwd<CR>
"-------------------------------------------------------------------------------



" "Git Client (Fugitive)"
nnoremap <silent><Leader>gd  :Gdiff<CR>
nnoremap <silent><Leader>gds :!clear<CR>:Git diff --staged<CR>
nnoremap <silent><Leader>gdd :q!<CR> :Gedit!<CR>
nnoremap <silent><Leader>gs  :Gstatus<CR>G<C-p>
nnoremap <silent><Leader>gw  :Gwrite<CR>
nnoremap <silent><Leader>ge  :Gedit :0<CR>
nnoremap <silent><Leader>gb  :Gblame<CR>
nnoremap <silent><Leader>gco :Gcheckout<CR>
nnoremap <silent><Leader>gcm :Gcommit<CR>
nnoremap <silent><Leader>gr  :Gremove<CR>
nnoremap <silent><Leader>gl  :Gitv<CR>
nnoremap <silent><Leader>gp  :silent! !clear<CR>:Git push<CR>
nnoremap <silent><Leader>gpu :silent! !clear<CR>:Git pull<CR>
"-------------------------------------------------------------------------------



" "Git Signify"
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_change            = '*'
let g:signify_sign_change_delete     = '*-'
let g:signify_sign_delete_first_line = '‾'

let g:signify_mapping_toggle           = '<Leader>tgs'
let g:signify_mapping_toggle_highlight = '<leader>tgh'
let g:signify_mapping_next_hunk        = '<leader>j'
let g:signify_mapping_prev_hunk        = '<leader>k'
"-------------------------------------------------------------------------------



" "Syntastic"
let g:syntastic_enable_signs=1
"-------------------------------------------------------------------------------



" "TMUX (Vimux)"
let g:VimuxOrientation = "v"
let g:VimuxHeight = "30"

" Prompt for a command to run
nnoremap <silent><Leader>cc :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
nnoremap <silent><Leader>lc :VimuxRunLastCommand<CR>

" Inspect runner pane
nnoremap <silent><Leader>it :VimuxInspectRunner<CR>

" Interrupt any command running in the runner pane
nnoremap <silent><Leader>cr :VimuxInterruptRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
nnoremap <silent><Leader>qt :VimuxCloseRunner<CR>

" Terminal Commands
nnoremap <silent><Leader>col :call VimuxRunCommand("termcolors \| less")<CR>
nnoremap <silent><Leader>vcol :let g:VimuxOrientation="h"<CR>
  \ :let g:VimuxHeight="10"<CR>
  \ :call VimuxRunCommand("termcolors \| less")<CR>
"-------------------------------------------------------------------------------



" "Present Working Directory"
nnoremap <silent><Leader>pwd :pwd<CR>
"-------------------------------------------------------------------------------



" "}}}
" AUTOMATION:"{{{
" ******************************************************************************
" TODO: Migrate to respective ftplugin/filetype.vim files, once this is fleshed
" out. http://vim.wikia.com/wiki/Keep_your_vimrc_file_clean
" "## Vim (Global)""{{{
augroup VimGlobal
  " On Start
  au!
  au VimEnter *  echo "Welcome to VimEz, Happy Coding! :-)"

  " General
  au BufWritePost *vimrc,*vimrc.local,molokaiez.vim
      \  nested so $MYVIMRC
      \| nohlsearch
      \| exe 'CSApprox'
      \| call Msg('Vim Configuration Written & Reloaded!')

  au BufNewFile *         silent! 0r  ~/.dotfiles/vim.local/templates/%:e.tpl
  au BufWritePre *        call StripTrailingWhitespace()
  au BufRead *            normal zz
  au VimResized *         wincmd =
  au BufEnter * silent!   lcd %:p:h

  " Improve UI memory
  au BufWritePost *       silent! call SaveView()
  au BufRead *            silent! call LoadView()

  " Make cursor highlights follow the cursor
  au WinEnter *           call WinEnterRoutine()
  au WinLeave *           call WinLeaveRoutine()

  " Improve popup tool environments
  au WinEnter,BufEnter *  call HelpEnvironment()
  au FileType nerdtree    call NERDTreeEnvironment()
  au FileType vundle      call VundleEnvironment()
  au FileType gundo       call GundoEnvironment()
  au FileType qf          call QuickFixEnvironment()

  " Persist sign column
  au BufWinEnter * sign define mysign
  au BufWinEnter * exe "sign place 9999 line=1 name=mysign buffer=" . bufnr('%')

  " Insert mode environment
  au InsertEnter * hi Cursorline ctermfg=NONE ctermbg=NONE cterm=NONE
  au InsertEnter * hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE
  au InsertEnter * setlocal nohlsearch

  " Normal mode environment
  au InsertLeave * hi Cursorline ctermfg=NONE ctermbg=234 cterm=NONE
  au InsertLeave * hi CursorColumn ctermfg=NONE ctermbg=234 cterm=NONE
  au InsertLeave * setlocal hlsearch
augroup END
"}}}
" "## Apache Config""{{{
augroup ApacheConfig
  au!
  au BufNewFile,BufRead /*apache*  set ft=apache
augroup END
"}}}
" "## C""{{{
augroup C
  au!
  au FileType c  setl omnifunc=ccomplete#Complete
augroup END
"}}}
" "## CSS/SCSS""{{{
augroup CSS
  au!
  au FileType css,scss,styl,sass     setl omnifunc=csscomplete#CompleteCSS
  au FileType css,scss,styl,sass     let g:cssfoldstate = 0

  au FileType css,scss  nmap <silent><buffer>
    \	<LocalLeader><F1> :call ToggleCSSFold()<CR>

  au FileType css,scss  setl equalprg=csstidy\ -\ --silent=true\ --template=template\ --preserve_css=true\ --merge_selectors=0\ --sort_properties=true\ --compress_font-weight=false\ --compress_colors=false\ --sort_selectors=false
augroup END
"}}}
" "## Drupal CMS Framework""{{{
augroup DrupalCMS
  au!
  au BufNewFile,BufRead *.module   set ft=php
  au BufNewFile,BufRead *.install  set ft=php
  au BufNewFile,BufRead *.test     set ft=php
augroup END
"}}}
" "## Dustjs""{{{
augroup Dustjs
  au!
  au BufNewFile,BufRead *.dust,*.dustjs  set ft=dustjs.html
  au BufNewFile,BufRead *.dustjs         set ft=dustjs.html
  au FileType dust                       setl omnifunc=htmlcomplete#CompleteTags
  au Filetype dust                       silent! call EnableCloseTag()
augroup END
"}}}
" "## Git""{{{
augroup Git
  au!
  au Filetype git,gitcommit call GitEnvironment()
  au BufNewFile,BufRead COMMIT_EDITMSG  call feedkeys('gg0')
  au BufNewFile,BufRead COMMIT_EDITMSG  setl spell
  au BufReadPost fugitive://*  set bufhidden=delete
augroup END
"}}}
" "## HAML""{{{
augroup HAML
  au!
  au BufNewFile,BufRead *.haml  set ft=haml
augroup END
"}}}
" "## HTML""{{{
augroup HTML
  au!
  au BufNewFile,BufRead *.htm   set ft=html
  au FileType html              setl omnifunc=htmlcomplete#CompleteTags
  au Filetype html              silent! call EnableCloseTag()
augroup END
"}}}
" "## Jade""{{{
augroup Jade
  au!
  au BufNewFile,BufRead *.jade  set ft=jade
augroup END
"}}}
" "## Javascript""{{{
augroup JavaScript
  au!
  au FileType javascript  setl omnifunc=javascriptcomplete#CompleteJS
augroup END
"}}}
" "## Markdown""{{{
augroup MarkDown
  au!
  au FileType markdown  setl omnifunc=htmlcomplete#CompleteTags
augroup END
"}}}
" "## Perl""{{{
augroup Perl
  au!
  au FileType perl  setl omnifunc=syntaxcomplete#Complete
augroup END
"}}}
" "## PHP""{{{
augroup PHP
  au!
  au BufNewFile,BufRead *.php  set ft=php
  au FileType php							 let php_minlines=500
  au FileType php              setl omnifunc=phpcomplete#CompletePHP
  au Filetype php              silent! call EnableCloseTag()
augroup END
"}}}
" "## Plain Text""{{{
augroup PlainText
  au!
  au BufNewFile,BufRead *.txt  set ft=text
augroup END
"}}}
" "## Python""{{{
augroup Python
  au!
  au FileType python  setl omnifunc=pythoncomplete#Complete
augroup END
"}}}
" "## Ruby""{{{
augroup Ruby
  au!
  au FileType ruby  setl omnifunc=rubycomplete#Complete
augroup END
"}}}
" "## Shell Script""{{{
augroup ShellScript
  au!
  au BufNewFile,BufRead *.sh  set ft=sh
  au BufWritePost *.sh        call MakeFileExecutable()
augroup END
"}}}
" "## Smarty Template Engine""{{{
augroup Smarty
  au!
  au BufNewFile,BufRead *.tpl  set ft=html
augroup END
"}}}
" "## Snippets""{{{
augroup Snippets
  au!
  au BufNewFile,BufRead *.snip  set ft=html
  au BufNewFile,BufRead *.snip  set syn=snippet
augroup END
"}}}
" "## Stylus""{{{
augroup Stylus
  au!
  " Assume the effects of the colorizer plugin before setting to vim ft
  au BufNewFile,BufRead *.styl  set ft=css
  au BufNewFile,BufRead *.styl  set ft=stylus
  au FileType stylus  setl equalprg=stylus\ --css
augroup END
"}}}
" "## Vim""{{{
augroup Vim
  au!
  " Assume the effects of the colorizer plugin before setting to vim ft
  au BufNewFile,BufRead *.vim   set ft=css
  au BufNewFile,BufRead *.vim   set ft=vim
  au FileType vim               setl omnifunc=syntaxcomplete#Complete
augroup END
"}}}










"}}}
" FUNCTIONS:"{{{
" ******************************************************************************
" "Delete Empty Buffers"
" From http://goo.gl/6OBjJ
function! DeleteEmptyBuffers()
  let empty = []
  let [i, n] = [1, bufnr('$')]
  while i <= n
    if bufexists(i) && bufname(i) == ''
      call add(empty, i)
    endif
    let i += 1
  endwhile
  if len(empty) > 0
    exe 'bdelete' join(empty, ' ')
  endif
endfunction
"-------------------------------------------------------------------------------



" "Clear Cache"
function! ClearCache()
  silent execute "!~/.vim/.aux/clear.sh &>/dev/null &"
  redraw!
  echo "Cache Cleared!"
endfunction
"-------------------------------------------------------------------------------



" "Restore Register"
function! RestoreRegister()
  if &clipboard == 'unnamed'
    let @* = s:restore_reg
  elseif &clipboard == 'unnamedplus'
    let @+ = s:restore_reg
  else
    let @" = s:restore_reg
  endif
  return ''
endfunction
"-------------------------------------------------------------------------------



" "Delete Buffer & File"
function! DeleteBufferFile()
  let l:delprompt = input('Are you sure? ')
  if l:delprompt == "y" || "Y"
    :echo delete(@%)
    :Kwbd
  else
    redraw!
    return
  endif
endfunction
"-------------------------------------------------------------------------------



" "Replace"
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<CR>"
endfunction
"-------------------------------------------------------------------------------



" "WinEnter Routine"
function! WinEnterRoutine()
  if g:cursorcolumnstate == 1 && g:cursorlinestate == 1
    setl cursorline
    setl cursorcolumn
  elseif g:cursorcolumnstate == 1 && g:cursorlinestate == 0
    setl nocursorline
    setl cursorcolumn
  elseif g:cursorcolumnstate == 0 && g:cursorlinestate == 1
    setl cursorline
    setl nocursorcolumn
  else
    setl nocursorline
    setl nocursorcolumn
  endif
endfunction
"-------------------------------------------------------------------------------



" "WinLeave Routine"
function! WinLeaveRoutine()
  setl nocursorline
  setl nocursorcolumn
endfunction
"-------------------------------------------------------------------------------



" "Toggle On/Off"
" Prints a message of the current toggled state of various features.
function! ToggleOnOff(OptionName, OnOrOff)
  let OptionName = a:OptionName
  let OnOrOff = a:OnOrOff
  let OptionState = strpart("OffOn", 3 * OnOrOff, 3)
  echo OptionName . ": " . OptionState
endfunction
"-------------------------------------------------------------------------------



" "Toggle Cursor Column"
function! ToggleCursorColumn()
  if g:cursorcolumnstate == 0
    let g:cursorcolumnstate = 1
    setl cursorcolumn
    echo 'Cursor Column: On'
  else
    let g:cursorcolumnstate = 0
    setl nocursorcolumn
    echo 'Cursor Column: Off'
  endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Cursor Line"
function! ToggleCursorLine()
  if g:cursorlinestate == 0
    let g:cursorlinestate = 1
    setl cursorline
    echo 'Cursor Line: On'
  else
    let g:cursorlinestate = 0
    setl nocursorline
    echo 'Cursor Line: Off'
  endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Maximized/Restore Window"
function! MaxRestoreWindow()
  if g:windowmaximized == 1
    let g:windowmaximized = 0
    wincmd =
    redraw!
    echo 'Windows Restored'
  else
    let g:windowmaximized = 1
    wincmd |
    wincmd _
    echo 'Window Maximized'
  endif
endfunction
"-------------------------------------------------------------------------------



" "Ctrl-P Custom Mappings""
function! MyCtrlPMappings()
  nnoremap <buffer><silent><C-c> :call <sid>DeleteBuffer()<CR>
endfunction
"-------------------------------------------------------------------------------



" "Ctrl-P Delete Buffer"
function! s:DeleteBuffer()
  exec "bd" fnamemodify(getline('.')[2:], ':p')
  exec "norm \<F5>"
endfunction"
"-------------------------------------------------------------------------------



" "Tab Size"
function! TabSize()
  let l:tabstop = 1 * input('Tab Size: ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call TabSummary()
endfunction
"-------------------------------------------------------------------------------



" "Tab Summary Report"
function! TabSummary()
    echo 'Current tab settings: '
    echo 'tabstop='.&l:ts
    echo 'shiftwidth='.&l:sw
    echo 'softtabstop='.&l:sts
    if &l:et
      echo 'expandtab'
    else
      echo 'noexpandtab'
    endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Rule"
function! ToggleRule()
  if g:rulestate == 0
    set colorcolumn=0
    let g:rulestate=1
    " echo "Rule: Off"
  else
    set colorcolumn=+1
    let g:rulestate=0
    " echo "Rule: On"
  endif
endfunction
"-------------------------------------------------------------------------------



" "Messages"
" Prints [long] message up to (&columns-1) length without the 'Press Enter'
" prompt.
function! Msg(msg)
  let x=&ruler | let y=&showcmd
  set noruler noshowcmd
  redraw
  echo a:msg
  let &ruler=x | let &showcmd=y
endfunction
"-------------------------------------------------------------------------------



" "Toggle Folds"
function! ToggleFolds()
  if &foldenable==1
    set nofoldenable
    set foldcolumn=0
  else
    set foldenable
    set foldcolumn=5
  endif
  let OnOrOff=&foldenable
  call ToggleOnOff('Folds', OnOrOff)
endfunction
"-------------------------------------------------------------------------------



" "Strip Trailing Whitespace"
function! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  %s/\s\+$//e
endfunction
"-------------------------------------------------------------------------------



" "Set Help Environment"
function! HelpEnvironment()
  if &filetype == 'help'
    setl relativenumber
    nnoremap <silent><buffer><CR> <C-]>
    nnoremap <silent><buffer><BS> <C-T>
    nnoremap <silent><buffer><Leader>qq :bdelete<CR>
    " TODO: Check if hlsearch is active
    nnoremap <silent><buffer>,,, :bdelete<CR>
  else
    nnoremap <CR> i<CR><Esc>
    nnoremap <BS> i<BS><Right><Esc>
  endif
endfunction
"-------------------------------------------------------------------------------



" "Set NERDTree Environment"
function! NERDTreeEnvironment()
  setl foldcolumn=0
  nnoremap <silent><buffer><Leader>qq :NERDTreeClose<CR>
  nnoremap <silent><buffer>,,, :NERDTreeClose<CR>
  nnoremap <silent><buffer><Leader>bb :NERDTreeClose<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set Gundo Environment"
function! GundoEnvironment()
  setl foldcolumn=0
  nnoremap <silent><buffer><Leader>qq :silent! bw __Gundo__ __Gundo_Preview__<CR>
  nnoremap <silent><buffer>,, :silent! bw __Gundo__ __Gundo_Preview__<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set QuickFix Environment"
function! QuickFixEnvironment()
  setl foldcolumn=0
  nnoremap <silent><buffer><Leader>qq :pclose<CR>
  nnoremap <silent><buffer>,, :pclose<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set Vundle Environment"
function! VundleEnvironment()
  setl foldcolumn=0
  vert resize 50
  nnoremap <silent><buffer><Leader>qq :bw<CR>
  nnoremap <silent><buffer>,, :bw<CR>
endfunction
"-------------------------------------------------------------------------------



" "Set Git Environment"
function! GitEnvironment()
  setl foldcolumn=0
  setl foldlevel=99
  nnoremap <silent><buffer><Leader>qq :bw<CR>
  nnoremap <silent><buffer>,, :bw<CR>
endfunction
"-------------------------------------------------------------------------------



" "Enable Close Tag"
" Close open tags automatically upon entering </
function! EnableCloseTag()
  so ~/.vim/bundle/closetag.vim/plugin/closetag.vim
endfunction
"-------------------------------------------------------------------------------



" "Make File Executable"
function! MakeFileExecutable()
  exe "silent! !chmod 774 %"
  redraw!
  call Msg('Written as an executable shell script!')
endfunction
"-------------------------------------------------------------------------------



" "Save Buffer View"
function! SaveView()
  if expand('%') != '' && &buftype !~ 'nofile'
    silent! mkview
  endif
endfunction
"-------------------------------------------------------------------------------



" "Load Buffer View"
function! LoadView()
  if expand('%') != '' && &buftype !~ 'nofile'
      silent! loadview
  endif
endfunction
"-------------------------------------------------------------------------------



" "Join"
function! Join()
  normal! $
  normal! l
  let l = line(".")
  let c = col(".")
  join
  call cursor(l, c)
  " TODO: make work w/repeat.vim
  " silent! call repeat#set("\<leader>jn",1:count)
endfunction
"-------------------------------------------------------------------------------



" "Find and Replace"
function! FindReplace()
  let CurrentWord=GetVisual()
  " Get search string.
  call inputsave()
  let  CurrentString = input('Search for: ', CurrentWord)
  if (empty(CurrentString))
    return
  endif
  call inputrestore()

  " Get replace string.
  call inputsave()
  let  NewString = input('Search for: '.CurrentString.'   Replace with: ')
  call inputrestore()

  " Determine wether or not to search for whole word only.
  redraw!
  let option = confirm('Search for whole word only? ', "&Yes\n&No", 2)
  if option == 0
    echo 'Invalid response. Please try again.'
  elseif option == 1
    " Find exact matches.
    exe "%s/\\<".CurrentString."\\>/".NewString."/gc"
  elseif option == 2
    " Find any matches.
    exe "%s/".CurrentString."/".NewString."/gc"
  endif
endfunction

" Escape String
" Escape special characters in a string for exact matching. This is useful to
" copying strings from the file to the search tool Based on this
" http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get Visual Selection
" Get the current visual block for search and replaces This function passed the
" visual block through a string escape function above. Based on
" - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction
"-------------------------------------------------------------------------------



" "Fold Text"
function! FoldText()
  let linecount = v:foldend-v:foldstart
  let line_count_string = ' '.linecount.' lines-|'
  let line = getline(v:foldstart)
  let line = substitute(line, '{'.'{{\|/\*{{'.'{\|/\*\|\*/\|"{{'.'{', ' ', 'g')
  let line = strpart(line, 0, windowwidth - len(line_count_string))
  let fillcharcount = &textwidth - len(line) - len(line_count_string) +0
  return line . repeat("-",fillcharcount) . line_count_string
  "<·>"
endfunction
"-------------------------------------------------------------------------------



" "CSS Fold Text"
" From Michael Wilber
" https://github.com/vim-scripts/CSS-one-line--multi-line-folding
function! CssFoldText()
  let line = getline(v:foldstart)
  let nnum = nextnonblank(v:foldstart + 1)
  while nnum < v:foldend+1
    let line = line . " " . substitute(getline(nnum), "^ *", "", "g")
    let nnum = nnum + 1
  endwhile
  return line
endfunction
"-------------------------------------------------------------------------------



" "Better Retab""
" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
"-------------------------------------------------------------------------------



" "Close Buffer Keep Window"
command! Kwbd call s:Kwbd(1)
function! s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle CSS Fold"
function! ToggleCSSFold()
  if g:cssfoldstate == 0
    let g:cssfoldstate = 1
    setl foldtext=CssFoldText()
    setl foldmethod=marker
    setl foldmarker={,}
    echo 'CSS Fold: On'
  else
    let g:cssfoldstate = 0
    setl foldtext=FoldText()
    setl foldmarker={{{,}}}
    setl foldmethod=marker
    echo 'CSS Fold: Off'
  endif
endfunction
"-------------------------------------------------------------------------------



" "Close Unlisted Buffers"
function! CloseUnlistedBuffers()
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
"-------------------------------------------------------------------------------



" "Close Inactive Buffers"
function! CloseInactiveBuffers()
  "List of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  "What tab page are we in?
  let l:currentTab = tabpagenr()
  try
    "Go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      "Go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        "Whatever buffer is in this window in this tab, remove it from
        "l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    "If there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    "Go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
"-------------------------------------------------------------------------------



" "Highlight Visual"
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
"-------------------------------------------------------------------------------



" "Xterm Bracketed Paste"
function! XTermPasteBegin(ret)
  set pastetoggle=<Esc>[201~
  set paste
  return a:ret
endfunction
"-------------------------------------------------------------------------------
"}}}
" WRAP:"{{{
" ******************************************************************************
" "Load Local Configurations"
if filereadable(expand('~/.vimrc.local'))
  so ~/.vimrc.local
endif



" "Todo/s, Fixme/s"
" TODO: reformatt rest of file according to conventions
" TODO: look into yankstack & unite.vim
"}}}
