" Name: VimEz vimrc
" Description: A robust Vim IDE distribution.
" Maintainer: Fontaine Cook <fontaine.cook@pearance.com
" Dependencies: Requires Vim 7.2 or higher.
" Version: 0.1a



"*******************************************************************************
" CONTENT:
"*******************************************************************************
" + General Settings
" + File Buffer
" + Filetypes
" + Edit
" + View
" + Navigation
" + Snippets
" + Abbreviations
" + Tools
" + Window
" + Help
"-------------------------------------------------------------------------------



" "Initialization" 
source $HOME/.vim/initrc    " Include dependent plugin bundles.
runtime $VIMRUNTIME/macros/matchit.vim
runtime $VIMRUNTIME/ftplugin/man.vim
"-------------------------------------------------------------------------------



"*******************************************************************************
" GENERAL SETTINGS: "{{{1
"*******************************************************************************
" "Color Scheme"
set background=dark         " Use a dark background. 
set t_Co=256                " Force terminal to go into 256 color mode.
colorscheme vimez	    " Default color scheme for the VimEz distribution.
syntax on		    " Syntax highlighting on.
"-------------------------------------------------------------------------------



" "Leader Key" 
let mapleader="\<Space>"    " Map personal modifier aka Leader key.
"-------------------------------------------------------------------------------



" "Commandline" More convenient entrance to Commandline mode from Normal mode.
map ; :
noremap ;; ;
"-------------------------------------------------------------------------------



" "History"
set history=256        " Amount of commands and searches to keep in history.
"-------------------------------------------------------------------------------



" "Vim Info"
set viminfo='1000,f1,<500,h " Save local/global marks, registers, etc
"-------------------------------------------------------------------------------



" "Character Encoding" Default to UTF-8 character encoding unless the terminal
" doesn't support it. In which case use Latin1 character encoding instead.
if has("multi_byte")
  set encoding=utf-8
  if $TERM == "linux" || $TERM_PROGRAM == "GLterm"
    set termencoding=latin1
  endif
  if $TERM == "xterm" || $TERM == "xterm-color"
    let propv = system
    \ ("xprop -id $WINDOWID -f WM_LOCALE_NAME 8s ' $0' -notype WM_LOCALE_NAME")
    if propv !~ "WM_LOCALE_NAME .*UTF.*8"
      set termencoding=latin1
    endif
  endif
endif
"-------------------------------------------------------------------------------



" "Restore Cursor Position" Restore original cursor position when reopening a file.
augroup RestorCursor
  autocmd!
  autocmd BufReadPost * 
  \ if line("'\"") > 1 && line("'\"") <= line("$") | 
  \   exe "normal! g'\"" | 
  \ endif
augroup END  
"-------------------------------------------------------------------------------



" "Performance Tweaks"
set ttyfast            " Indicates a fast terminal connection.
set synmaxcol=2048     " Prevent long lines from slowing down redraws.
"-------------------------------------------------------------------------------



" "Timeout Length" The time waited for a key code or mapped key sequence to
" complete.  As you become more fluent with the key mappings you may want toC
" drop this to 250.
set timeoutlen=500
"-------------------------------------------------------------------------------



" "Mouse"
set mouse=a                       " Onable mouse usage (all modes)
set selectmode=mouse              " Selection with the mouse trigers Select mode
set ttymouse=xterm2               " Enable basic mouse functionality in a terminal
"map <MouseMiddle> <esc>"*p	  " TODO: requires more testing
"-------------------------------------------------------------------------------


" "Update Time" How frequent marks, statusbar, swap files, and other are updated.
set updatetime=1000 
"-------------------------------------------------------------------------------



" "Wildmenu"
set wildchar=<Tab>
set wildmenu                 " Enable file/command auto-completion
set wildmode=longest,full    " Auto-complete up to ambiguity
set <A-h>=h
set <A-l>=l
cmap <A-h> <Left>
cmap <C-h> <Left>
cmap <A-l> <Right>
cmap <C-l> <Right>
"-------------------------------------------------------------------------------



" "Edit Vimrc" This would be Vim's version of [Edit Preferences] :-) Upon saving
" the file is sourced so most of time your changes should take effect
" immediately. However, some changes will only take effect after restarting Vim.
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
"-------------------------------------------------------------------------------



" "Edit Initrc"
nnoremap <silent> <leader>ei :e $HOME/.vim/initrc<CR>
"-------------------------------------------------------------------------------



" "Edit Color Scheme"
nnoremap <silent> <leader>ecs :e $HOME/.vim/colors/vimez.vim<CR>
"-------------------------------------------------------------------------------



" "Reload Vim"
map <F5> :call GlobalReload()<CR>

function! GlobalReload()
  for server in split(serverlist())
    call remote_send(server, '<Esc>:source $MYVIMRC<CR>')
  endfor
  call EchoMsg('Reloaded Global Instances of Vim!')
endfunction

augroup LocalReload
  autocmd!
  autocmd bufwritepost .vimrc source $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost .vimrc call EchoMsg('Reloaded Local Instance of Vim!')
augroup END
"-------------------------------------------------------------------------------



" "Echo Message" EchoMsg() prints [long] message up to (&columns-1) length
" guaranteed without "Press Enter" prompt.
function! EchoMsg(msg)
  let x=&ruler | let y=&showcmd
  set noruler noshowcmd
  redraw
  echo a:msg
  let &ruler=x | let &showcmd=y
endfun
"-------------------------------------------------------------------------------
"===============================================================================
" "}}}













"*******************************************************************************
" FILE BUFFER: "{{{2
"*******************************************************************************
" "General File/Buffer Settings"
set hidden      " Hide buffers when they are abandoned
set confirm     " Provide user friendly prompt over nasty error messages.
set autoread    " Automatically re-read a file if modified outside of vim.
set shellslash  " Use forward slash for shell file names (Windows)
"-------------------------------------------------------------------------------



" "Open/Edit File" Give a prompt for opening files in the same dir as the
" current buffer's file.
if has("unix")
  nnoremap <leader>ef :e <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <leader>ef :e <C-R>=expand("%:p:h") . "\\" <CR>
endif
"-------------------------------------------------------------------------------



" "Rename File (Rename2)" This is handled by the Rename2 plugin and provides
" the following command: Rename[!] {newname}.
nnoremap <leader>rf :Rename<Space>
"-------------------------------------------------------------------------------



" "Browse Files (NERDTree)" Conventional file browser panel with bookmarking
" abilities. Provides an efficient way to view file hierarchies.
let NERDTreeChDirMode=2
nnoremap <leader><CR> :NERDTreeToggle .<CR>
"-------------------------------------------------------------------------------



" "Search Files (Command-T)" Faster alternative of locating and opening
" files, than the conventional browsing of a directory tree.
let g:CommandTMaxHeight=10                    " Show this amount of results max
let g:CommandTAcceptSelectionSplitMap=['/']   " Key to open file in split win
let g:CommandTAcceptSelectionVSplitMap=[';']  " Key to open file in vsplit win
let g:CommandTCancelMap=[',']                 " Key to cancel Command-T
nnoremap <silent> <leader>kk :CommandT<CR>
"-------------------------------------------------------------------------------



" "New Buffer"
nnoremap <leader>nb :enew<CR>
"-------------------------------------------------------------------------------
  


" "Write Buffer"
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <leader>wb :write<CR>
inoremap <silent> <C-s> :update<CR>
nnoremap <silent> <C-s> :update<CR>
vnoremap <silent> <C-s> :update<CR>
"-------------------------------------------------------------------------------



" "Write All Buffers" Write all modified buffers. Buffers without a filename will not be
" saved.
nnoremap <silent> <leader>wa :wall<CR>:exe ":echo 'All buffers saved to files!'"<CR>
"-------------------------------------------------------------------------------



" "Close Buffer (BufKill)"
nnoremap <silent> <leader>cb :BD<CR>
"-------------------------------------------------------------------------------



" "Close Buffer & Window"
nnoremap <silent> <leader>cbb :bd<CR>
"-------------------------------------------------------------------------------



" "Close Others (BufOnly)"
nnoremap <silent> <leader>co :BufOnly<CR>
"-------------------------------------------------------------------------------



" "Close All" 
nnoremap <silent> <leader>ca :exec "1," . bufnr('$') . "bd"<CR>
"-------------------------------------------------------------------------------



" "Undo Close (BufKill)"
nnoremap <silent> <leader>uc :BUNDO<CR>
"-------------------------------------------------------------------------------



" "Write on Focus Lost" Write all buffers to file upon leaving buffer
" (gvim only).
augroup FocusLost
  autocmd!	
  autocmd FocusLost * silent! wa
augroup END
"-------------------------------------------------------------------------------



" "Change Working Directory" to the file in the current buffer
augroup CWD
  autocmd BufEnter * lcd %:p:h
augroup END
"-------------------------------------------------------------------------------



" "Buffer Navigation (Simple)"
nnoremap <silent> <F12> :bnext<CR>
nnoremap <silent> <F11> :bprev<CR>
"-------------------------------------------------------------------------------



" "Buffer Navigation (Wild Menu)" Tab through buffers, similar to
" tabbing through open programs via Alt-Tab on most common desktop
" environments. From http://vim.wikia.com/wiki/Easier_buffer_switching
" You
set <A-`>=`
set wildcharm=<C-Z>
nnoremap <silent> <A-`> :b <C-Z>
cnoremap <A-`> <Right>
cnoremap <C-c> <Home><Right>d<CR>
"-------------------------------------------------------------------------------



" "Buffer Navigation (CommandT)"
nmap <silent> <leader>jj :CommandTBuffer<CR>
"-------------------------------------------------------------------------------



" "Previous Buffer (BufKill)" This is refered to in Vim parlance as the 'Alternate
" Buffer' stock keymap is ctrl-^. Leader n for greater Convenience.
nmap <silent> <leader>pb :BA<CR>
let g:BufKillOverrideCtrlCaret=1
"-------------------------------------------------------------------------------



" "Write Session (Vim-Session)" Save the current session. Including buffers, untitled blank
" buffers, current directory, folds, help, options, tabs, window sizes.
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
nnoremap <leader>ws :SaveSession<CR>
"-------------------------------------------------------------------------------



" "Open Session (Vim-Session)"
nnoremap <leader>os :OpenSession<CR>
"-------------------------------------------------------------------------------



" "Close Session (Vim-Session)"
nnoremap <leader>cs :CloseSession<CR>
"-------------------------------------------------------------------------------



" "Delete Session (Vim-Session)"
nnoremap <leader>ds :DeleteSession<CR>
"-------------------------------------------------------------------------------



" "Backups"
set backup                        " Keep backup file after overwriting a file
set writebackup                   " Make a backup before overwriting a file

 " List of directories for the backup file
if has("win32") || has("win64")
  set backupdir=$TMP              " TODO: Set for Windows and Mac environments
else
  set backupdir=$HOME/.vim/tmp/backups//
end
"-------------------------------------------------------------------------------



" "Swap Files" This creates a binary version of each file as a backup in the
" event there is a crash, you have a shot at recovering your file. The swap is
" updated on every 100th character.
set updatecount=100
if has("win32") || has("win64")   " TODO: Set for Windows and Mac environments
  set directory=$TMP
else
  set directory=$HOME/.vim/tmp/swaps//
end
"-------------------------------------------------------------------------------



" "Write and Quit All"
nnoremap <leader>wqq :wqa<CR>
"-------------------------------------------------------------------------------



" "Quit All" Simpler exit strategy, that prompts if there is any unsaved buffers
" open.
nmap <leader>qqq :qa<CR>
"-------------------------------------------------------------------------------
"===============================================================================
" "}}}










"*******************************************************************************
" FILETYPES:{{{3
"*******************************************************************************
augroup FileTypes

  " "Shell Filetype" Automatically chmod +x Shell and Perl scripts
  autocmd BufWritePost *.sh !chmod +x %
  "-------------------------------------------------------------------------------
  
  
  
  " "Template Filetype" Make the template .tpl files behave like html files
  autocmd BufNewFile,BufRead *.tpl set filetype=html
  "-------------------------------------------------------------------------------
  
  
  " "Drupal Module Filetypes" *.module and *.install files.
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
  autocmd BufRead,BufNewFile *.test set filetype=php
  
augroup END
"-------------------------------------------------------------------------------
"===============================================================================
" "}}}










"*******************************************************************************
" EDIT: "{{{4
"*******************************************************************************
" "Virtual Edit" Allow the cursor to go where no cursor has gone before.
" Navigate into lines and columns that are not real.
set virtualedit=all
"-------------------------------------------------------------------------------



" "Undo (Gundo)" 250 levels of persistent undo.
set undolevels=250     " Amount of undos you can do.
set undofile
set undodir=$HOME/.vim/tmp/undos//
nnoremap <leader>uu :GundoToggle<CR>
"-------------------------------------------------------------------------------



" "Autocompletion/Snippets (NeoComplCache)"
" Autocompletion General Settings
set complete+=.		" Scan the current buffer ('wrapscan' is ignored)
set complete+=w		" Scan buffers from other windows
set complete+=b		" Scan other loaded buffers that are in the buffer list
set complete+=u		" Scan the unloaded buffers that are in the buffer list
set complete+=U		" Scan the buffers that are not in the buffer list
set complete-=k		" Scan the files given with the 'dictionary' option
set complete-=kspell  	" Use the currently active spell checking |spell|
set complete-=k{dict}   " Scan the file {dict}.  Several "k" flags can be given,
                      	" patterns are valid too.  For example:
                      	" 	:set cpt=k/usr/dict/*,k~/spanish
set complete-=s		" Scan the files given with the 'thesaurus' option
set complete-=s{tsr}	" Scan the file {tsr}.  Several "s" flags can be given, patterns
                        " Are valid too.
set complete+=i		" Scan current and included files
set complete-=d		" Scan current and included files for defined name or macro
                	" |i_CTRL-X_CTRL-D|
set complete-=]		" Tag completion
set complete+=t		" Same as "]"

set infercase   	" Match is adjusted depending on the typed text.
set pumheight=15        " Pop up menu height in lines

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 0
let g:neocomplcache_max_list = 50
let g:neocomplcache_max_keyword_width = 50
let g:neocomplcache_max_filename_width = 15
let g:neocomplcache_auto_completion_start_length = 2
let g:neocomplcache_manual_completion_start_length = 2
let g:neocomplcache_min_keyword_length = 3
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_wildcard = 1
let g:neocomplcache_enable_quick_match = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_caching_message = 1
let g:neocomplcache_disable_select_mode_mappings = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_enable_auto_delimiter = 0
let g:neocomplcache_snippets_complete_disable_runtime_snippets = 1
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

" Set snips_author.
if !exists('snips_author')
  let g:snips_author = 'Your Name Here'
endif

" Configure Dictionaries
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ }

" Configure Omnicompletion
augroup AutoComplete
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType c setlocal omnifunc=ccomplete#Complete
  autocmd FileType vim setlocal omnifunc=syntaxcomplete#Complete
augroup END

" Enable Custom Omnicompletion
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Configure Mappings
imap <expr><Tab> 
  \ neocomplcache#sources#snippets_complete#expandable() ? 
  \ "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? 
  \ "\<C-n>" : "\<Tab>"
inoremap <expr><C-z> neocomplcache#undo_completion()
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><CR>  neocomplcache#smart_close_popup()."\<CR>"
nnoremap <leader>es  :NeoComplCacheEditSnippets<CR>
"-------------------------------------------------------------------------------



" "Reselect Pasted Text"
nnoremap <leader>v V`]
"-------------------------------------------------------------------------------



" "Select All"
nmap <Leader>va ggVG
"-------------------------------------------------------------------------------



" "Clipboard"
set clipboard+=unnamed  " Use system clipboard for yanks
set pastetoggle=<F7>    " Avoid double indetation when pasting formatted text
set go+=a               " TODO: Visual selection automatically copied to the clipboard
"-------------------------------------------------------------------------------



" "Bulbbling Line (Unimpaired)" Consistent use of [hjkl] with the Shift modifier to move a
" line of text around. Up/down by one line and left/right by amount of
" shiftwidth.
nmap <C-h> <<
nmap <C-j> ]e
nmap <C-k> [e
nmap <C-l> >>
"-------------------------------------------------------------------------------



" "Bubbling Block (Unimpaired)" Consistent use of [hjkl] with the Shift modifier to move a
" block of text around. Up/down by one line and left/right by amount of
" shiftwidth.
vmap <C-l> >gv
vmap <C-h> <gv
vmap <C-j> ]egv
vmap <C-k> [egv
"-------------------------------------------------------------------------------



" "Bubbling Word(s) (Unimpaired)" Consistent use of [hjkl] with the Control modifier to
" transport words around. Up/down by one line and left/right by one word plus
" a space.
set <M-h>=h
set <M-j>=j
set <M-k>=k
set <M-l>=l
vmap <M-h> dBhp`[v`]
vmap <M-j> djhp`[v`]
vmap <M-k> dkhp`[v`]
vmap <M-l> dElp`[v`]
"-------------------------------------------------------------------------------



" "Add & Remove Blank Lines" Use the +plus and -minus keys to add and remove
" blank lines below the current line. With the Shift modifier, add and remove
" blank lines from above the current line.
nnoremap <silent>- m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent>_ m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent>= :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent>+ :set paste<CR>m`O<Esc>``:set nopaste<CR>
"-------------------------------------------------------------------------------
        


" "Blank Current Line" Delete line without copying its contents into a
" clipboard register and without removing the space the line accupied.
nnoremap <silent><leader>dd Vr<Space>
"-------------------------------------------------------------------------------



" "Join Next or Previous line" Normally Shift-j joins the line below with the
" current one, but felt it best to maintain [hjkl] as directional arrow keys.
" So, this functionality is mapped to Leader jn and jp for join next (line
" below) and join previous (line above) with the current line.
set nojoinspaces
map <silent> <leader>jn :join<CR>
map <silent> <leader>jp k<S-v>xpk:join<CR>
"-------------------------------------------------------------------------------



" "Enter" Restore some familiar behavior to the Enter key, in Normal mode.
nmap <CR> i<CR><Esc>
"-------------------------------------------------------------------------------



" "Backspace" Restore expected functionality to the Backspace key, while in
" Normal mode. Such as backspacing the amount of shiftwidth.
set backspace=indent,eol,start    " Sane backspacing in Insert mode
nnoremap <BS> i<BS><Right><Esc>
"-------------------------------------------------------------------------------



" "Delete" In Normal mode we have the 'x' key to delete forward characters. In
" Insert mode you have to stretch for the delete key, and to add insult to 
" injury its location varies from keyboard to keyboard.
inoremap <C-d> <Del>
"-------------------------------------------------------------------------------



" "Space" A sensible compromise for the ability to add a quick space whilst in
" Normal mode, but not with the Space bar. This is to safe guard against
" accidentally adding space in the middle of critical syntax. In addition to
" the default Leader key, it is too easily accessible. So its mapped
" to <leader> s <leader> which adds a space immediately. Alternatively,
" <leader> s has a delayed effect.
nnoremap <leader>ss i<Space><Esc>l
"-------------------------------------------------------------------------------



" "x Forward Delete" This gives the beloved 'x' key in Normal mode the ability
" to wrap to the next line and continut deleting. I thought whichwrap would
" offer this behavior but it desn't.
nnoremap x i<Del><Esc>l
"-------------------------------------------------------------------------------
"===============================================================================
" "}}}










"*******************************************************************************
" NAVIGATION: "{{{5
"*******************************************************************************
" "Escape"
" Escape from the dreaded Insert and Commandline modes to the graces of
" the beloved Normal mode.
inoremap jj <Esc>
inoremap JJ <Esc>
cnoremap jj <C-c>
cnoremap JJ <C-c>
"-------------------------------------------------------------------------------
"===============================================================================
" "}}}










