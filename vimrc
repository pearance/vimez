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
" + Filetype Associations
" + Edit
" + View
" + Navigation
" + Tools
" + Window
" + Help
"-------------------------------------------------------------------------------



" "Initialization"
source $HOME/.vim/initrc    " Include dependent plugin bundles.
runtime macros/matchit.vim
runtime ftplugin/man.vim
"-------------------------------------------------------------------------------



"*******************************************************************************
" GENERAL SETTINGS: "{{{1
"*******************************************************************************
" "Color Scheme"
set background=dark         " Use a dark background.
set t_Co=256                " Force terminal to go into 256 color mode.
colorscheme vimez	          " Default color scheme.
syntax on		                " Syntax highlighting on.

" Show syntax highlighting group for current word.
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo nnoremap(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <leader>syn :call <SID>SynStack()<CR>
"-------------------------------------------------------------------------------



" "Leader Key"
let mapleader="\<Space>"  " Map personal modifier aka Leader key.
"-------------------------------------------------------------------------------



" "Commandline" More convenient entrance to Commandline and Commandline Edit mode from Normal mode.
nnoremap ; :
nnoremap ;; ;
nnoremap q; q:
"-------------------------------------------------------------------------------



" "History"
set history=1000          " Amount of commands and searches to keep in history.
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
  autocmd! RestorCursor
  autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
augroup END
"-------------------------------------------------------------------------------



" "Performance Tweaks"
set ttyfast            " Indicates a fast terminal connection.
set synmaxcol=2048     " Prevent long lines from slowing down redraws.
set lazyredraw                    " Don't redraw while executing macros.
"-------------------------------------------------------------------------------



" "Timeout Length" The time waited for a key code or mapped key sequence to
" complete.  As you become more fluent with the key mappings you may want toC
" drop this to 250.
set timeoutlen=500
"-------------------------------------------------------------------------------



" "Mouse"
set mouse=a                     " Enable mouse usage (all modes)
set selectmode=mouse           " Selection with the mouse trigers Select mode
set ttymouse=xterm2             " Enable basic mouse functionality in a terminal
"-------------------------------------------------------------------------------


" "Update Time" How frequent marks, statusbar, swap files, and other are updated.
"-------------------------------------------------------------------------------
set updatetime=1000



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
nnoremap <silent> <F5> :so $MYVIMRC<CR><Bar> :call Msg('   VimEz Reloaded!')<CR>

augroup LocalReload
  autocmd! LocalReload
  autocmd bufwritepost .vimrc source $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost .vimrc call Msg('   VimEz Reloaded!')
augroup END
"-------------------------------------------------------------------------------



" "Message" Prints [long] message up to (&columns-1) length without the "Press
" Enter" prompt.
function! Msg(msg)
  echohl ModeMsg
  let x=&ruler | let y=&showcmd
  set noruler noshowcmd
  redraw
  echo a:msg
  let &ruler=x | let &showcmd=y
endfun
"*******************************************************************************
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



" "Write File"
if has("unix")
  nnoremap <leader>wf :w <C-R>=expand("%:p:h") . "/" <CR>
  nnoremap <leader>wf :w <C-R>=expand("%:p:h") . "\\" <CR>
else
endif
"-------------------------------------------------------------------------------



" "Write File!" with root permission.
cmap w!! w !sudo tee % >/dev/null
"-------------------------------------------------------------------------------



" "Delete File"
function! DeleteFile()
  let l:delprompt = input('Are you sure? ')
  if l:delprompt == "y" || "Y"
    :echo delete(@%)
    :BD
  else
    redraw!
    return
  endif
endfunction
nnoremap <leader>dddf :call DeleteFile()<CR>
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



" "Close Buffer (BufKill)" The i<Space><Esc> is required by an empty buffer
" created by enew in order to close it and remove it form the buffer list.
nnoremap <silent> <leader>cb i<Space><Esc><Bar>:BD<CR>
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
  autocmd! FocusLost
  autocmd FocusLost * silent! wa
augroup END
"-------------------------------------------------------------------------------



" "Change Working Directory" to the file in the current buffer
augroup CWD
  autocmd! CWD
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


" "Sessions (Session.vim)"
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_directory = '~/.vim/local/sessions/'

set sessionoptions=
set ssop+=blank        " Blank	empty windows
set ssop+=buffers	     " Hidden and unloaded buffers, not just those in windows
set ssop+=curdir	     " The current directory
set ssop+=folds	       " Manually created folds, opened/closed folds and local
                       " fold options
set ssop+=globals	     " Global variables that start with an uppercase letter
                       " and contain at least one lowercase letter.  Only
                       " String and Number types are stored.
set ssop+=help		     " The help window
set ssop+=localoptions " Options and mappings local to a window or buffer (not
                       " global values for local options)
set ssop+=options	     " All options and mappings (also global values for local
                       " options)
set ssop+=resize	     " Size of the Vim window: 'lines' and 'columns'
set ssop-=sesdir	     " The directory in which the session file is located
                       " will become the current directory (useful with
                       " projects accessed over a network from different
                       " systems)
set ssop+=slash	       " Backslashes in file names replaced with forward
                       " slashes
set ssop+=tabpages	   " All tab pages; without this only the current tab page
                       " is restored, so that you can make a session for each
                       " tab page separately
set ssop+=unix		     " With Unix end-of-line format (single <NL>), even when
                       " on Windows or DOS
set ssop+=winpos	     " Position of the whole Vim window
set ssop+=winsize	     " Window sizes
"-------------------------------------------------------------------------------



" "Write Session (Vim-Session)" Save the current session. Including
" buffers, untitled blank buffers, current directory, folds, help,
" options, tabs, window sizes.
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



" "Vim Info" A memory dump to remember information from the last
" session. The viminfo file is read upon startup and written when
" exiting Vim.
set viminfo=
set vi+='1000 " Amount of files to save marks
set vi+=f1    " Store global marks A-Z and 0-9
set vi+=<500  " How many registers are saved
set vi+=:500  " Number of lines to save from the command line history
set vi+=@500  " Number of lines to save from the input line history
set vi+=/500  " Number of lines to save from the search history
set vi+=r/tmp " Removable media, for which no marks will be stored
set vi+=!	    " Global variables that start with an uppercase letter and
              " don't contain lowercase letters
set vi+=h	    " Disable 'hlsearch' highlighting when starting
set vi+=%	    " Buffer list (restored when starting Vim without arguments)
set vi+=c	    " Convert the text using 'encoding'
set vi+=s100  " Max amount of kilobytes of any single register.
set vi-=n	    " Name used for the viminfo file (must be the last option)
"-------------------------------------------------------------------------------



" "Backups"
set backup                        " Keep backup file after overwriting a file
set writebackup                   " Make a backup before overwriting a file

 " List of directories for the backup file
if has("win32") || has("win64")
  set backupdir=$TMP              " TODO: Set for Windows and Mac environments
else
  set backupdir=$HOME/.vim/local/tmp/backups//
end
"-------------------------------------------------------------------------------



" "Swap Files" This creates a binary version of each file as a backup in the
" event there is a crash, you have a shot at recovering your file. The swap is
" updated on every 100th character.
set updatecount=100
if has("win32") || has("win64")   " TODO: Set for Windows and Mac environments
  set directory=$TMP
else
  set directory=$HOME/.vim/local/tmp/swaps//
end
"-------------------------------------------------------------------------------



" "Write and Quit"
nnoremap <leader>wqq :SaveSession<CR>:wqa<CR>
"-------------------------------------------------------------------------------



" "Quit" Simpler exit strategy, that prompts if there is any unsaved buffers
" open.
nmap <leader>qqq :qa<CR>
"-------------------------------------------------------------------------------



" "File Status"
function! Filestate_status()
  " Writable
  if &readonly || &buftype == "nowrite" || &buftype == "help"
    return '!'
  " Modified
  elseif &modified != 0
    return '*'
  " Unmodified
  else
    return ' '
  endif
endfunction
"-------------------------------------------------------------------------------



" "File Type"
function! Filetype_status()
  if &filetype == ""
    return "Plain\ Text"
  else
    "let vimez_filetype = substitute(&filetype, "\\w\\+", "\\U\\0", "g")
    return &filetype
  endif
endfunction
"-------------------------------------------------------------------------------



" "File Encoding"
function! Fileencoding_status()
  if &fileencoding == ""
    if &encoding != ""
      "let vimez_encoding = substitute(&encoding, "\\w\\+", "\\U\\0", "g")
      return &encoding
    else
      return "--"
    endif
  else
    "let vimez_fileencoding = substitute(&fileencoding, "\\w\\+", "\\U\\0", "g")
    return &fileencoding
  endif
endfunction
"-------------------------------------------------------------------------------



" "File Format"
function! Fileformat_status()
  if &fileformat == ""
    return "--"
  else
    "let vimez_fileformat = substitute(&fileformat, "\\w\\+", "\\U\\0", "g")
    return &fileformat
  endif
endfunction
"-------------------------------------------------------------------------------
" "}}}










"*******************************************************************************
" FILETYPE ASSOCIATIONS:{{{3
"*******************************************************************************
augroup Filetype_Assoc
  autocmd! Filetype_Assoc

  " "Shell Filetype" Automatically chmod +x Shell and Perl scripts
  autocmd BufWritePost *.sh call Executable()
  function! Executable()
    exe "silent! !chmod +x %"
    redraw!
    call Msg("Written as an executable shell script!")
  endfunction
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
" "}}}













"*******************************************************************************
" EDIT: "{{{4
"*******************************************************************************
" "Virtual Edit" Allow the cursor to go where no cursor has gone before.
" Navigate into lines and columns that are not real.
set virtualedit=all
"-------------------------------------------------------------------------------



" "Format Options"
set formatoptions=
set fo-=t  " Auto-wrap text using textwidth
set fo-=c  " Auto-wrap comments using textwidth, inserting the current comment
           " leader automatically.
set fo-=r  " Automatically insert the current comment leader after hitting
           " <Enter> in Insert mode.
set fo-=o  " Automatically insert the current comment leader after hitting 'o' or
           " 'O' in Normal mode.
set fo-=q  " Allow formatting of comments with 'gq'.
           " Note that formatting will not change blank lines or lines containing
           " only the comment leader.  A new paragraph starts after such a line,
           " or when the comment leader changes.
set fo-=w  " Trailing white space indicates a paragraph continues in the next line.
           " A line that ends in a non-white character ends a paragraph.
set fo-=a  " Automatic formatting of paragraphs.  Every time text is inserted or
           " deleted the paragraph will be reformatted.  See |auto-format|.
           " When the 'c' flag is present this only happens for recognized
           " comments.
set fo-=n  " When formatting text, recognize numbered lists.  This actually uses
           " the 'formatlistpat' option, thus any kind of list can be used.  The
           " indent of the text after the number is used for the next line.  The
           " default is to find a number, optionally followed by '.', ':', ')',
           " ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
           " well together with "2".
           " Example: >
           " 	1. the first item
           " 	   wraps
           " 	2. the second item
set fo-=2  " When formatting text, use the indent of the second line of a paragraph
           " for the rest of the paragraph, instead of the indent of the first
           " line.  This supports paragraphs in which the first line has a
           " different indent than the rest.  Note that 'autoindent' must be set
           " too.  Example: >
           " 		first line of a paragraph
           " 	second line of the same paragraph
           " 	third line.
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
set fo-=1  " Don't break a line after a one-letter word.  It's broken before it
           " instead (if possible).



" "Paragraph Formatting"
" set formatprg=par " TODO Put this in my vimrc.local
vnoremap Q gq
nnoremap Q gqip
"-------------------------------------------------------------------------------



" "Undo (Gundo)" Persistent undo, along with Gundo to parse the ungo history.
set undolevels=500
set undofile
set undodir=$HOME/.vim/local/tmp/undos//
nnoremap <leader>uu :GundoToggle<CR>
"-------------------------------------------------------------------------------



" "Autocompletion/Snippets (NeoComplCache)"
" Autocompletion General Settings
set cpt+=.		    " Scan the current buffer ('wrapscan' is ignored)
set cpt+=w		    " Scan buffers from other windows
set cpt+=b		    " Scan other loaded buffers that are in the buffer list
set cpt+=u		    " Scan the unloaded buffers that are in the buffer list
set cpt+=U		    " Scan the buffers that are not in the buffer list
set cpt-=k		    " Scan the files given with the 'dictionary' option
set cpt+=kspell   " Use the currently active spell checking |spell|
set cpt-=k{dict}  " Scan the file {dict}.  Several "k" flags can be given,
                  " patterns are valid too.  For example:
                  " 	:set cpt=k/usr/dict/*,k~/spanish
set cpt-=s		    " Scan the files given with the 'thesaurus' option
set cpt-=s{tsr}	  " Scan the file {tsr}.  Several "s" flags can be given,
                  " patterns are valid too.
set cpt+=i		    " Scan current and included files
set cpt-=d		    " Scan current and included files for defined name or macro
                	    " |i_CTRL-X_CTRL-D|
set cpt+=]		    " Tag completion
set cpt+=t		    " Same as "]"

set infercase   	" Match is adjusted depending on the typed text.
set pumheight=15  " Pop Up Menu height in lines

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
  autocmd! AutoComplete
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

" Configure Neocomplcache Mappings
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
nnoremap <silent><leader>dd 0D
"-------------------------------------------------------------------------------



" "Join Next or Previous line" Normally Shift-j joins the line below with the
" current one, but felt it best to maintain [hjkl] as directional arrow keys.
" So, this functionality is mapped to Leader jn and jp for join next (line
" below) and join previous (line above) with the current line.
set nojoinspaces
nnoremap <silent> <leader>jn :join<CR>
nnoremap <silent> <leader>jp k<S-v>xpk:join<CR>
"-------------------------------------------------------------------------------



" "Enter" Restore some familiar behavior to the Enter key, in Normal mode.
nnoremap <CR> i<CR><Esc>
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
" to wrap to the next line and continue deleting.
"nnoremap x i<Del><Esc>l
"-------------------------------------------------------------------------------



" "Tab Indentation" Tab to indent one level and Shift-Tab to go back one
" level, based on tab settings. Acts on a single line while in Normal mode and
" blocks of text while in Visual mode.
set expandtab           " Expand tabs using spaces instead of a tab char
set shiftwidth=2        " Amount of shift when in Normal mode
set tabstop=2           " Number of spaces that a <Tab> in the file counts for.
set softtabstop=2       " Set amount of spaces for a tab
set smarttab            " Uses shiftwidth instead of tabstop at start of lines.
set shiftround          " Use multiples of shiftwidth when indenting
set autoindent          " Enable auto indentation
set copyindent          " Copy the previous indentation on autoindenting
nnoremap <Tab> i<Tab><Esc>l
nnoremap <S-Tab> i<BS><Esc>l
vmap <Tab> >gv
vmap <S-Tab> <gv
nnoremap <leader>tab :call Tab()<CR>
command! -nargs=* Tab call Tab()
nnoremap <silent> <leader>tt :setlocal expandtab!<CR>
nmap <silent> <leader>tt :setlocal expandtab!<CR>
      \ <Bar>:echo "   Soft Tabs: " . strpart("OffOn", 3 * &expandtab, 3)<CR>

" Prompt for tab size and apply to softtabstop, tabstop, and shiftwidth.
function! Tab()
  let l:tabstop = 1 * input('Tab Size: ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call TabSummary()
endfunction

" Message a summary of current tab settings.
function! TabSummary()
  try
    echohl ModeMsg
    echon 'Current tab settings: '
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" Generate a statusline flag for expandtab.
function! Expandtab_flag()
  if &expandtab == 0
    return ""
  else
    return "Soft\ "
  endif
endfunction

" Generate statusline flags for softtabstop, tabstop, and shiftwidth.
function! Tabstop_status()
  let str = "Tab:" . &tabstop
  " Show softtabstop or shiftwidth if not equal tabstop
  if   (&softtabstop && (&softtabstop != &tabstop))
  \ || (&shiftwidth  && (&shiftwidth  != &tabstop))
    let str = "TS:" . &tabstop
    if &softtabstop
      let str = str . "\ STS:" . &softtabstop
    endif
    if &shiftwidth != &tabstop
      let str = str . "\ SW:" . &shiftwidth
    endif
  endif
  return str
endfunction
"-------------------------------------------------------------------------------



" "Spell Checking" Remember spelling bees? Those were the days. Make sure to
" update the spelllang to your language. Custom words are tucked away in the
" .vim/spell folder. Leader ts toggles dynamic spell checking.
set nospell               " Dynamic spell checking off by default
set spelllang=en_us       " Default language
set spellsuggest=5        " How many spelling suggestions to list
set spellfile=~/.vim/local/spell/en.utf-8.add " Custom spell file
nmap <silent> <leader>ts :setlocal spell!<CR>
      \ <Bar>:echo "   Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

" Generate a statusline flag for Spell Check"
function! Spell_flag()
  if &spell == 0
    return ""
  else
    return "[S]"
  endif
endfunction
"-------------------------------------------------------------------------------



" "Strip Trailing Whitespace" Quickly remove trailing whitespace.
function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
nnoremap <silent> <F6> :call <SID>StripTrailingWhitespaces()<CR>
"-------------------------------------------------------------------------------



" "Common Symbols"
inoremap uu _
inoremap hh =>
inoremap aa @
"-------------------------------------------------------------------------------
" "}}}










"*******************************************************************************
" VIEW: "{{{4
"*******************************************************************************
" "Title Bar" Set title bar to display current file, path, and server hostname.
set title
set titlestring=%t%(%{Filestate_status()}%)%(\
\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{hostname()}
"-------------------------------------------------------------------------------



" "Line Numbers"
set relativenumber
set numberwidth=5
set numberwidth=4
"-------------------------------------------------------------------------------



" "Error Alerts"
set noerrorbells        " No audible alerts on error
set novisualbell        " No blinking on error
"-------------------------------------------------------------------------------



" "Cursor Hightlights" This helps maintain your bearings by highlighting the
" current line the cursor is on as well as the current column. You can Toggle
" Cursor Hightlights with Leader tch.
set cursorline          " Enable cursor line hightlight
set cursorcolumn        " Enable cursor column hightligh
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
autocmd WinEnter * setlocal cursorcolumn
autocmd WinLeave * setlocal nocursorcolumn
nmap <leader>tch :setlocal cursorline! cursorcolumn!<CR>
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
set shortmess-=T " Truncate other messages in the middle if they are too long to
                 " fit on the command line.  "..." will appear in the middle.
set shortmess-=W " Don't give "written" or "[w]" when writing a file
set shortmess-=A " Don't give the "ATTENTION" message when an existing
                 " swap file is found.
set shortmess+=I " Don't give the intro message when starting Vim |:intro|.
"-------------------------------------------------------------------------------



" "Invisible Characters" This controls non-printable characters that denote
" certain formatting information. Such as eol, tabs, trailing space, etc. You
" can specify which characters to use as well.By default invisible characters
" are off and can be toggle on via Leader ti.
set nolist                    " Don't show non-printable character by default
set listchars+=eol:~
set listchars+=tab:>-
set listchars+=trail:.
set listchars+=extends:>
set listchars+=precedes:<
set listchars+=nbsp:%
nnoremap <silent> <leader>tl :setlocal list!<CR>
      \ <Bar>:echo "   Invisible: " . strpart("OffOn", 3 * &list, 3)<CR>
" No need for a flag, clearly visible if on.
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

" Generate a statusline flag for Line Wrap"
function! WrapFlag()
  if &wrap == 0
    return ""
  else
    return "[W]"
  endif
endfunction
"-------------------------------------------------------------------------------


" "Colorcolumn"
if exists('+colorcolumn')
  nnoremap <silent> <leader>tcc :call ToggleCC()<CR>
  let g:ccToggle = 0

  function! ToggleCC()
    if g:ccToggle == 0
      set colorcolumn=0
      redraw!
      let g:ccToggle = 1
    else
      set colorcolumn=+1
      redraw!
      let g:ccToggle = 0
    endif
  endfunction
endif
"-------------------------------------------------------------------------------



" "Status Line"
set showmode                      " Message on status line to show current mode.
set showcmd                       " Show (partial) command in states line.
set laststatus=2                  " Keep status lines visible at all times.
set cmdheight=1                   " Number of lines to use for the command-line.

set statusline=
set stl+=%#User1#                       " Normal
set stl+=\                              " Space
set stl+=%t                             " Filename
set stl+=%w                             " Preview flag
set stl+=%{Filestate_status()}          " File status
set stl+=%#User2#                       " Dimmed
set stl+=\                              " Space
set stl+=\                              " Space
set stl+=\                              " Space
set stl+=[                              " Open bracket
set stl+=%{Filetype_status()}\/         " File type
set stl+=%{Fileencoding_status()}\/     " File encoding
set stl+=%{Fileformat_status()}         " File format
set stl+=]                              " Close bracket
set stl+=%=                             " Align right
set stl+=                               " TODO: diff mode flag
set stl+=                               " TODO: scrollbind flag
set stl+=                               " TODO: capslock flag
set stl+=%{WrapFlag()}                  " Wrap flag
set stl+=%{Spell_flag()}                " Spellcheck flag
set stl+=[                              " Open bracket
set stl+=%{Expandtab_flag()}            " Soft tab flag
set stl+=%{Tabstop_status()}              " Tab size
set stl+=]                              " Close bracket
set stl+=\                              " Space
set stl+=\                              " Space
set stl+=\                              " Space
set stl+=%#User1#                       " Strong
set stl+=%05(C:%v%)                     " Current column
set stl+=\                              " Space
set stl+=%06(L:%l%)                     " Current line
set stl+=%<                             " Truncate this side of the aisle

let g:Active_statusline=&g:statusline
let g:NCstatusline=substitute(
  \                substitute(g:Active_statusline,
  \                'User1', 'User3', 'g'),
  \                'User2', 'User3', 'g')
au WinEnter,BufEnter * let&l:statusline = g:Active_statusline
au WinLeave * let&l:statusline = g:NCstatusline
"-------------------------------------------------------------------------------



" "Highlight Trailing Whitespace" This will automatically highlight extra
" whitespace at the end of lines. So you can either manually remove it or
" trigger the StripTrailingWhiteSpace command via <F6>.
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()
"-------------------------------------------------------------------------------
" "}}}










"*******************************************************************************
" NAVIGATION: "{{{5
"*******************************************************************************
" "Disable Cursor Keys"
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"-------------------------------------------------------------------------------



" "Escape" A more efficient alternative to the escape key.
inoremap jj <Esc>
inoremap JJ <Esc>
cnoremap jj <C-c>
cnoremap JJ <C-c>
cnoremap jo <Enter><leader><leader>
"-------------------------------------------------------------------------------



" "Scrolling"
set scrolloff=5         " Start scrolling x lines before the edge of the window.
set sidescrolloff=5     " Same as above just for columns instead of lines.
"-------------------------------------------------------------------------------



" "Insert Mode Navigation"
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"-------------------------------------------------------------------------------



" "Hyper h|j|k|l" Consistent use of h|j|k|l with Shift to hyper traverse
" the buffer universe!
nnoremap <S-h> ^
nnoremap <S-j> 20j
nnoremap <S-k> 20k
nnoremap <S-l> $
"-------------------------------------------------------------------------------



" "Ignore Wrapped Lines" Prevent jumping over wrapped lines & use visual lines.
nnoremap j gj
nnoremap k gk
"-------------------------------------------------------------------------------



" "Search"
set hlsearch            " Hightlight search terms
set incsearch           " Highlight search terms dynamically and incrementally
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set wrapscan            " Set the search scan to wrap around the file
nnoremap <silent> <leader><leader> :nohlsearch<Bar>:echo<CR>
nnoremap <silent> <leader>hw
      \ :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hlsearch<CR>
"-------------------------------------------------------------------------------



" "Search and Replace"
nnoremap <leader>asr :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap sr :call SearchReplace()<CR>
function! SearchReplace()
  let CurrentWord=expand("<cword>")

  " Get search string.
  call inputsave()
  let  CurrentString = input("   Search for: ", CurrentWord)
  if (empty(CurrentString))
   return
  endif
  call inputrestore()

  " Get replace string.
  call inputsave()
  let  NewString = input("   Search for: ".CurrentString."   Replace with: ")
  call inputrestore()

  " Determine wether or not to search for whole word only.
  redraw!
  let option = confirm("Search for whole word only? ", "&Yes\n&No", 2)
  if option == 0
    echon "Invalid response. Please try again."
  elseif option == 1
    " Execute whole word only search and replace.
    exe "%s/\\<".CurrentString."\\>/".NewString."/gc"
  elseif option == 2
    " Execute normal search and replace.
    exe "%s/".CurrentString."/".NewString."/gc"
  endif
endfunction
"-------------------------------------------------------------------------------
" "}}}










"*******************************************************************************
" WINDOW: "{{{5
"*******************************************************************************
" "Focus Windows"
noremap <silent> <leader>h  :wincmd h<CR>
noremap <silent> <leader>j  :wincmd j<CR>
noremap <silent> <leader>k  :wincmd k<CR>
noremap <silent> <leader>l  :wincmd l<CR>
"-------------------------------------------------------------------------------



" "Move Windows"
noremap <silent> <leader>mh <C-w>H
noremap <silent> <leader>mj <C-w>J
noremap <silent> <leader>mk <C-w>K
noremap <silent> <leader>ml <C-w>L
noremap <silent> <leader>mx <C-w>x
"-------------------------------------------------------------------------------



" "Close Windows"
noremap <silent> <leader>cj :wincmd j<CR>:close<CR>
noremap <silent> <leader>ch :wincmd h<CR>:close<CR>
noremap <silent> <leader>ck :wincmd k<CR>:close<CR>
noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
noremap <silent> <leader>cw :close<CR>
"-------------------------------------------------------------------------------



" "Split Windows"
set nosplitbelow
noremap <silent> <leader>sv :vsplit<CR><Bar><C-w>l
set splitright
noremap <silent> <leader>sh :split<CR>
"-------------------------------------------------------------------------------










"*******************************************************************************
" HELP: "{{{
"*******************************************************************************
augroup HelpGroup
  autocmd! HelpGroup
  autocmd WinEnter,BufEnter * :call HelpEnv()   " Set the help environment.
  autocmd WinEnter * :call HelpEnter() " Map Enter to jump to subject.
  autocmd WinEnter * :call HelpBack()  " Map Backspace to jump back.
augroup END

" Set the help environment.
function! HelpEnv()
  if &filetype == 'help'
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal norelativenumber
    setlocal colorcolumn=0
  endif
endfunction

" Map Enter to jump to subject.
function! HelpEnter()
  if &filetype == 'help'
    nnoremap <CR> <C-]>
  else
    nnoremap <CR> i<CR><Esc>
  endif
endfunction

" Map Backspace to jump back.
function! HelpBack()
  if &filetype == 'help'
    nnoremap <BS> <C-T>
  else
    nnoremap <BS> i<BS><Right><Esc>
  endif
endfunction
"-------------------------------------------------------------------------------
" "}}}










if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
