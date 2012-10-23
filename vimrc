" Title:         vimrc
" Description:   Main configuration file for VimEz.
" Authors:       Fontaine Cook, Various Contributors
" Maintainers:   Fontaine Cook, Various Contributors
" Last Modified: Tue Oct 23, 2012  02:05PM
"------------------------------------------------------------------------------

" GENERAL: "{{{
"*******************************************************************************
" "Initialization"
so ~/.vim/initrc    " Include dependent plugin bundles.
runtime macros/matchit.vim
runtime ftplugin/man.vim
"-------------------------------------------------------------------------------



" "Color Scheme & Syntax Highlighting"
set background=dark         " Use a dark background.
set t_Co=256                " Force terminal to go into 256 color mode.
set synmaxcol=300           " Prevent long lines from slowing down redraws.
syntax on		                " Syntax highlighting on.
colorscheme molokai-ez       " Default color scheme.
nnoremap <Leader>theme :SCROLL<CR>


" Show syntax highlighting group for current word.
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
nnoremap <Leader>syn :call <SID>SynStack()<CR>
"-------------------------------------------------------------------------------



" "Leader Key"
let mapleader="\<Space>"  " Map personal modifier aka Leader key.
"-------------------------------------------------------------------------------



" "Commandline"
" More convenient entrance to Commandline and Commandline Edit mode from Normal mode.
nnoremap ; :
vnoremap ; :
nnoremap ;; ;
nnoremap q; q:
"-------------------------------------------------------------------------------



" "History"
set history=100          " Amount of commands and searches to keep in history.
"-------------------------------------------------------------------------------



" "Character Encoding"
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



" "Terminal Settings"
set ttyfast            " Indicates a fast terminal connection.
"-------------------------------------------------------------------------------



" "Timeout Length" The time waited for a key code or mapped key sequence to
" complete.  As you become more fluent with the key mappings you may want toC
" drop this to 250.
set timeoutlen=750 "TODO: RESEARCH
"set notimeout ttimeout ttimeoutlen=200
"-------------------------------------------------------------------------------



" "Mouse"
"set mouse=a                  " Enable mouse usage (all modes)
"set selectmode=mouse         " Selection with the mouse trigers Select mode
"set ttymouse=xterm2          " Enable basic mouse functionality in a terminal
"-------------------------------------------------------------------------------



" "Update Time" How frequent marks, statusbar, swap files, and other are updated.
set updatetime=1000
"-------------------------------------------------------------------------------



" "Wildmenu"
set wildchar=<Tab>
set wildcharm=<C-z>
set wildmenu                 " Enable file/command auto-completion
set wildmode=longest,full    " Auto-complete up to ambiguity
set <A-h>=h
set <A-l>=l
cmap <A-h> <Left>
cmap <C-h> <Left>
cmap <A-l> <Right>
cmap <C-l> <Right>
"-------------------------------------------------------------------------------










" "}}}
" BUFFER: "{{{
"*******************************************************************************
" "General File/Buffer Settings"
set fileformats=unix,dos,mac
set hidden      " Hide buffers when they are abandoned
set confirm     " Provide user friendly prompt over nasty error messages.
set autoread    " Automatically re-read a file if modified outside of vim.
set shellslash  " Use forward slash for shell file names (Windows)
"-------------------------------------------------------------------------------


" TODO: Needs work
" "Edit (New/Open) File" Give a prompt for opening files in the same dir as the
" current buffer's file.
if has("unix")
  nnoremap <Leader>ef :edit <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <Leader>ef :edit <C-R>=expand("%:p:h") . "\\" <CR>
endif
"-------------------------------------------------------------------------------



" "Goto File Horizontal"
nnoremap gfh :wincmd f<CR>
"-------------------------------------------------------------------------------



" "Goto File Vertical"
nnoremap gfv :vertical wincmd f<CR>
"-------------------------------------------------------------------------------



" "Write File"
if has("unix")
  nnoremap <Leader>wf :write <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <Leader>wf :write <C-R>=expand("%:p:h") . "\\" <CR>
endif
"-------------------------------------------------------------------------------



" "Write File! as Root" with root permission.
cmap w!! w !sudo tee % >/dev/null
"-------------------------------------------------------------------------------



" "Write File As"
if has("unix")
  nnoremap <Leader>wfa :saveas <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <Leader>wfa :saveas <C-R>=expand("%:p:h") . "\\" <CR>
endif
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
nnoremap <Leader>dddf :call DeleteFile()<CR>
"-------------------------------------------------------------------------------



" "Rename File (Rename2)" This is handled by the Rename2 plugin and provides
" the following command: Rename[!] {newname}.
nnoremap <Leader>rf :Rename<Space>
"-------------------------------------------------------------------------------



" "Change Directory" globally to the directory of the current buffer.
map <leader>cd :cd %:p:h<CR>
"-------------------------------------------------------------------------------



" "Browse Files (NERDTree)" Conventional file browser panel with bookmarking
" abilities. Provides an efficient way to view file hierarchies.
let NERDTreeChDirMode=2
let NERDTreeMapOpenSplit='h'
let NERDTreeMapPreviewSplit='gh'
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapPreviewVSplit='gv'
let NERDTreeBookmarksFile=expand("~/.vim.local/data/NERDTreeBookmarks")
nnoremap <silent><Leader>,, :NERDTreeToggle .<CR>
"-------------------------------------------------------------------------------



" "Search Files | Buffers | MRU (CtrlP)" Faster alternative of locating and opening
" files, than the conventional browsing of a directory tree.
let g:ctrlp_map = '<Leader>ll'
let g:ctrlp_prompt_mappings = {
  \ 'PrtExit()':            ['<esc>', '<c-c>', ','],
  \ }
nnoremap <silent><Leader>jj :CtrlPBuffer<CR>
nnoremap <silent><Leader>kk :CtrlPMRU<CR>
nnoremap <silent><Leader>ll :CtrlP<CR>
"-------------------------------------------------------------------------------



" "New Buffer"
nnoremap <silent><Leader>nb :enew<CR><Bar>i<Space><BS><Esc>
"-------------------------------------------------------------------------------



" "Write Buffer"
nnoremap <silent><Leader>w :write<CR>
nnoremap <silent><Leader>wb :update<CR>
inoremap <silent> <C-s> <Esc>:update<CR>
nnoremap <silent> <C-s> :update<CR>
vnoremap <silent> <C-s> :update<CR>
"-------------------------------------------------------------------------------



" "Write All Buffers" Write all modified buffers. Buffers without a filename
" will not be saved.
nnoremap <silent><Leader>wa :wall<CR>:exe ":echo 'All buffers saved to files!'"<CR>
"-------------------------------------------------------------------------------



" "Close Buffer (BufKill)" The i<Space><Esc> is required by an empty buffer
" created by enew in order to close it and remove it form the buffer list.
nnoremap <silent><Leader>cb :BD<CR>
"-------------------------------------------------------------------------------



" "Close Buffer & Window"
nnoremap <silent><Leader>cbb :bd<CR>
"-------------------------------------------------------------------------------



" "Close Others (BufOnly)"
nnoremap <silent><Leader>co :BufOnly<CR>
"-------------------------------------------------------------------------------



" "Close All"
nnoremap <silent><Leader>cab :exec "1," . bufnr('$') . "bd"<CR>
"-------------------------------------------------------------------------------



" "Undo Close (BufKill)"
nnoremap <silent><Leader>uc :BUNDO<CR>
"-------------------------------------------------------------------------------



" "Write on Focus Lost" Write all buffers to file upon leaving buffer
" (gvim only).
augroup FocusLost
  autocmd! FocusLost
  autocmd FocusLost * silent! wa
augroup END
"-------------------------------------------------------------------------------



" "Buffer Navigation (Wild Menu)" Tab through buffers, similar to
" tabbing through open programs via Alt-Tab on most common desktop
" environments.
nnoremap <Leader><Tab> :b <C-z><C-z>

cnoremap <silent><C-c> <Home><Right>d<CR>
cnoremap <C-s><C-v> <Home><Del>vs<CR>
cnoremap <C-s><C-h> <Home><Del>sp<CR>
"-------------------------------------------------------------------------------



" "Previous Buffer (BufKill)" This is refered to in Vim parlance as the 'Alternate
" Buffer' stock keymap is ctrl-^. Leader n for greater Convenience.
nnoremap <silent><Leader><BS> :BA<CR>
let g:BufKillOverrideCtrlCaret=1
"-------------------------------------------------------------------------------


" "Sessions (Session.vim)"
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_directory = '~/.vim.local/sessions/'

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



" "New Session (Vim-Session)"
nnoremap <Leader>ns :SaveSession<CR><Bar>:CloseSession<CR><Bar>
      \ :SaveSession .vim<Left><Left><Left><Left>
"-------------------------------------------------------------------------------



" "Write Session (Vim-Session)"
nnoremap <Leader>ws :SaveSession<CR>
"-------------------------------------------------------------------------------



" "Write Session As (Vim-Session)"
nnoremap <Leader>wsa :call WriteSessionAs()<CR>
function! WriteSessionAs()
  call inputsave()
  let SessionName = input('Session Name: ')
  exe "SaveSession " . SessionName
endfunction
"-------------------------------------------------------------------------------



" "Open Session (Vim-Session)"
nnoremap <Leader>os :SaveSession<CR><Bar>:OpenSession<CR>
"-------------------------------------------------------------------------------



" "Close Session (Vim-Session)"
nnoremap <Leader>cs :SaveSession<CR><Bar>:CloseSession<CR>
"-------------------------------------------------------------------------------



" "Delete Session (Vim-Session)"
nnoremap <Leader>ds :DeleteSession<CR>
"-------------------------------------------------------------------------------



" "Current Session Status"
function! CurrentSession()
  let g:currSession = fnamemodify(v:this_session, ":t:r")
  return g:currSession
endfunction
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
set vi+=n~/.vim.local/data/viminfo	" Name used for the viminfo file.
"-------------------------------------------------------------------------------



" "Backups"
set backup                        " Keep backup file after overwriting a file
set writebackup                   " Make a backup before overwriting a file

 " List of directories for the backup file
if has("win32") || has("win64")
  set backupdir=$TMP              " TODO: Set for Windows and Mac environments
else
  set backupdir=~/.vim.local/tmp/backups//,.
end
"-------------------------------------------------------------------------------



" "Swap Files" This creates a binary version of each file as a backup in the
" event there is a crash, you have a shot at recovering your file. The swap is
" updated on every 100th character.
set updatecount=100
if has("win32") || has("win64")   " TODO: Set for Windows and Mac environments
  set directory=$TMP
else
  set directory=~/.vim.local/tmp/swaps//,.
end
"-------------------------------------------------------------------------------



" "Write and Quit"
nnoremap <Leader>wqq :SaveSession<CR>:wqa<CR>
"-------------------------------------------------------------------------------



" "Quit" Simpler exit strategy, that prompts if there is any unsaved buffers
" open.
nnoremap <Leader>Q :qa<CR>
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



" "File Type Status"
function! Filetype_status()
  if &filetype == ""
    return "Plain\ Text"
  else
    "let vimez_filetype = substitute(&filetype, "\\w\\+", "\\U\\0", "g")
    return &filetype
  endif
endfunction
"-------------------------------------------------------------------------------



" "File Encoding Status"
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



" "File Format Status"
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
" EDIT: "{{{
"*******************************************************************************
" "Yank | Put | Clipboard (Copy | Paste | Yankring)"
set clipboard+=unnamedplus  " Use system clipboard for yanks.
set pastetoggle=<F6>        " Preserve indetation when pasting formatted text.
set go+=a                   " ?

nnoremap y  "+y
nnoremap yy "+Y
nnoremap p  "+gp
nnoremap P  "+gP
vnoremap y  "+y
vnoremap Y  "+Y

" Preserve indentation while put (pasting) text from the system clipboard
" imap <C-v>  <C-O>:set paste<CR><C-O>:set nopaste<CR>

" Yank from current cursor position to left or right end respectively.
nnoremap yh v0y
nnoremap yl v$y$
nnoremap <silent><Leader>pp :YRShow<CR>

let g:yankring_max_history = 1000
let g:yankring_dot_repeat_yank = 1
let g:yankring_window_height = 10
let g:yankring_min_element_length = 3
let g:yankring_replace_n_pkey = '<C-p>'
let g:yankring_replace_n_nkey = '<C-n>'
let g:yankring_history_dir = '~/.vim.local/data/'
let g:yankring_history_file = 'yankring_history'
"-------------------------------------------------------------------------------



" "Deleting (Cuting)"
nnoremap dh v0r<Space>
nnoremap dl v$hd
nnoremap DD v0r<Space>
nnoremap CC v0r<Space>R
"-------------------------------------------------------------------------------



" "Paragraph Formatting"
vnoremap Q gq
nnoremap Q gqip
"-------------------------------------------------------------------------------



" "Undo (Gundo)" Persistent undo, along with Gundo to parse the ungo history.
set undolevels=1000
set undofile
set undodir=~/.vim.local/tmp/undos//,.
nnoremap <silent><Leader>uu :GundoToggle<CR>
"-------------------------------------------------------------------------------



" "Reselect Pasted Text"
nnoremap <Leader>v V`]
"-------------------------------------------------------------------------------



" "Select All"
nmap <Leader>a ggVG
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
vmap <C-h> <gv
vmap <C-j> ]egv
vmap <C-k> [egv
vmap <C-l> >gv
"-------------------------------------------------------------------------------



" "Bubbling Word(s) (Unimpaired)" Consistent use of [hjkl] with the Control modifier to
  " transport words around. Up/down by one line and left/right by one word plus
" a space.
"set <A-h>=h
"set <A-j>=j
"set <A-k>=k
"set <A-l>=l
"vmap <A-h> dBhp`[v`]
"vmap <A-j> djhp`[v`]
"vmap <A-k> dkhp`[v`]
"vmap <A-l> dElp`[v`]
"-------------------------------------------------------------------------------



" "Break to Next or Previous Line"
" Restore some familiar behavior to the Enter key, in Normal mode.
" Break to line below in normal mode
nnoremap <CR> i<CR><Esc>
" Break to line above in normal mode
nmap <Leader><CR> DO<Esc>p
"-------------------------------------------------------------------------------



" "Join Next or Previous line"
" Normally Shift-j joins the line below with the
" current one, but felt it best to maintain [hjkl] as directional arrow keys.
" So, this functionality is mapped to Leader jn and jp for join next (line
" below) and join previous (line above) with the current line.
set nojoinspaces
nnoremap <silent><Leader>jn :call Join()<CR>
nnoremap <silent><Leader>jp k<S-v>xpk:call Join()<CR>
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



" "Spell Checking" Remember spelling bees? Those were the days. Make sure to
" update the spelllang to your language. Custom words are tucked away in the
" .vim/spell folder. Leader ts toggles dynamic spell checking.
set nospell               " Dynamic spell checking off by default
set spelllang=en_us       " Default language
set spellsuggest=5        " How many spelling suggestions to list
set spellfile=~/.vim.local/spell/en.utf-8.add " Custom spell file
nmap <silent><Leader>ts
      \ :setl spell!<CR><Bar>
      \ :let OnOrOff=&spell<CR><Bar>
      \ :call ToggleOnOff("Spell Checker", OnOrOff)<CR>

" Generate a statusline flag for Spell Check"
function! SpellFlag()
  if &spell == 0
    return ""
  else
    return "[S]"
  endif
endfunction
"-------------------------------------------------------------------------------



" "Edit Vimrc" This would be Vim's version of [Edit Preferences]. Upon saving
" the file is sourced so most of time your changes should take effect
" immediately. However, some changes will only take effect after restarting Vim.
nnoremap <silent><Leader>ev :e $MYVIMRC<CR>
"-------------------------------------------------------------------------------



" "Redraw/Reload"
" Manually
nnoremap <silent> <F5> :redraw!<CR><Bar> :call Msg('VimEz Redrawn!')<CR>
nnoremap <silent> <F5><F5>
      \       :ColorClear<CR>
      \ <Bar> :so $MYVIMRC<CR>
      \ <Bar> :nohlsearch<CR>
      \ <Bar> :call Msg('VimEz Reloaded!')<CR>
      \ <Bar> <C-w>=
      \ <Bar> <C-w>h



" "Edit Initrc"
nnoremap <silent><Leader>ei :e ~/.vim/initrc<CR>
"-------------------------------------------------------------------------------



" "Edit Color Scheme"
nnoremap <silent><Leader>ecs :e ~/.vim/bundle/themes/colors/molokai-ez.vim<CR>
"-------------------------------------------------------------------------------



" "Edit Tmux" Edit and reload on write.
nnoremap <silent><Leader>et :e ~/.tmux.conf<CR>
"-------------------------------------------------------------------------------










" "}}}
" VIEW: "{{{
"*******************************************************************************
" "Title Bar" Set title bar to display current file, path, and server hostname.
set title
set titlestring=%t%(%{Filestate_status()}%)
set titlestring+=%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{hostname()}
"-------------------------------------------------------------------------------



" "Line Numbers" TODO:Need to finish!
set relativenumber
let g:numbermode=1
set numberwidth=3
nnoremap <silent><Leader>tnm :call g:ToggleNumberMode()<CR>
nnoremap <silent><Leader>tn :call g:ToggleNumber()<CR>

function! g:ToggleNumberMode()
  if(&relativenumber==1)
    set number
    let g:numbermode=0
    echo "Number Type: Normal"
  else
    set relativenumber
    let g:numbermode=1
    echo "Number Type: Relative"
  endif
endfunction

function! g:ToggleNumber()
  if(g:numbermode==1)
    call g:ToggleRelativeNumber()
  else
  	call g:ToggleNormalNumber()
  endif
endfunction

function! g:ToggleNormalNumber()
  if(&number==1)
    setlocal nonumber
  else
    setlocal number
  endif
  let OnOrOff=&number
  call ToggleOnOff("Line Numbers", OnOrOff)
endfunction

function! g:ToggleRelativeNumber()
  if(&relativenumber==1)
    setlocal norelativenumber
  else
    setlocal relativenumber
  endif
  let OnOrOff=&relativenumber
  call ToggleOnOff("Relative Line Numbers", OnOrOff)
endfunction
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
nmap <silent><Leader>tch :setlocal cursorline! cursorcolumn!<CR>
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
nnoremap <silent><Leader>ti
      \ :setlocal list!<CR><Bar>
      \ :let OnOrOff=&list<CR><Bar>
      \ :call ToggleOnOff("Invisible Characters", OnOrOff)<CR>
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

nnoremap <silent><Leader>tw
      \ :setlocal wrap!<CR><Bar>
      \ :let OnOrOff=&wrap<CR><Bar>
      \ :call ToggleOnOff("Word Wrap", OnOrOff)<CR>

" Generate a statusline flag for Line Wrap"
function! WrapFlag()
  if &wrap == 0
    return ""
  else
    return "[W]"
  endif
endfunction
"-------------------------------------------------------------------------------


" "Print Margin" TODO: Needs work
if exists('+colorcolumn')
  nnoremap <silent><Leader>tpm :call ToggleCC()<CR>
  let g:ccToggle = 0

  function! ToggleCC()
    if g:ccToggle == 0
      set colorcolumn=0
      redraw!
      let g:ccToggle=1
    else
      set colorcolumn=+1
      redraw!
      let g:ccToggle=0
    endif
  endfunction
endif
"-------------------------------------------------------------------------------



" "Folds"
augroup Folds
  autocmd! Folds
  autocmd FileType * set foldcolumn=2
augroup END
"-------------------------------------------------------------------------------



" "View Options"
set viewoptions-=options
set viewdir=~/.vim.local/view//,.
augroup vimrc
    autocmd BufWritePost *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      mkview
    \|  endif
    autocmd BufRead *
    \   if expand('%') != '' && &buftype !~ 'nofile'
    \|      silent loadview
    \|  endif
augroup END
"-------------------------------------------------------------------------------



" "Status Line"
set showmode                      " Message on status line to show current mode.
set showcmd                       " Show (partial) command in states line.
set laststatus=2                  " Keep status lines visible at all times.
set cmdheight=2                   " Number of lines to use for the command-line.

" set statusline=
" set stl+=%#User1#                       " Brighten
" set stl+=\                              " Space
" set stl+=%04(%l%),%02(%v%)              " Current line
" set stl+=\                              " Space
" set stl+=%#User2#                       " Dimmed
" set stl+=[                              " Open bracket
" set stl+=S:%{CurrentSession()}          " Current Session
" set stl+=]                              " Close bracket
" set stl+=\                              " Space
" set stl+=%#User1#                       " Brighten
" set stl+=%t                             " Filename
" set stl+=%{Filestate_status()}          " File status
" set stl+=%#User2#                       " Dimmed
" set stl+=%w                             " Preview flag
" set stl+=\                              " Space
" set stl+=\                              " Space
" set stl+=\                              " Space
" set stl+=%=                             " Align right
" set stl+=                               " TODO: diff mode flag
" set stl+=                               " TODO: scrollbind flag
" set stl+=                               " TODO: capslock flag
" set stl+=%{AutoCompleteFlag()}          " Auto Complete flag
" set stl+=%{WrapFlag()}                  " Wrap flag
" set stl+=%{SpellFlag()}                 " Spellcheck flag
" set stl+=\                              " Space
" set stl+=[                              " Open bracket
" set stl+=%{ExpandTabFlag()}             " Soft tab flag
" set stl+=%{TabStopStatus()}             " Tab size
" set stl+=]                              " Close bracket
" set stl+=\                              " Space
" set stl+=[                              " Open bracket
" set stl+=%{Fileencoding_status()}\/     " File encoding
" set stl+=%{Fileformat_status()}         " File format
" set stl+=]                              " Close bracket
" set stl+=\                              " Space
" set stl+=%#User1#                       " Brighten
" set stl+=[%{Filetype_status()}]         " File type
" set stl+=%<                             " Truncate this side of the aisle
"-------------------------------------------------------------------------------


" "Power Line"
let g:Powerline_cache_enabled = 0
let g:Powerline_symbols = 'unicode'
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
"-------------------------------------------------------------------------------










" "}}}
" INSERT: "{{{
"*******************************************************************************
" "Format Options"
set formatoptions=
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
set fo-=a  " Automatic formatting of paragraphs.  Every time text is inserted or
           " deleted the paragraph will be reformatted.  See |auto-format|.
           " When the 'c' flag is present this only happens for recognized
           " comments.
set fo+=n  " When formatting text, recognize numbered lists.  This actually uses
           " the 'formatlistpat' option, thus any kind of list can be used.  The
           " indent of the text after the number is used for the next line.  The
           " default is to find a number, optionally followed by '.', ':', ')',
           " ']' or '}'.  Note that 'autoindent' must be set too.  Doesn't work
           " well together with "2".
           " Example: >
           " 	1. the first item
           " 	   wraps
           " 	2. the second item
set fo+=2  " When formatting text, use the indent of the second line of a paragraph
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
set fo+=1  " Don't break a line after a one-letter word.  It's broken before it
           " instead (if possible).



" "Autocompletion (Omnicompletion/NeoComplCache)"
" Native Autocompletion Settings
set complete+=.		    " Scan the current buffer ('wrapscan' is ignored)
set complete+=w		    " Scan buffers from other windows
set complete+=b		    " Scan other loaded buffers that are in the buffer list
set complete+=u		    " Scan the unloaded buffers that are in the buffer list
set complete+=U		    " Scan the buffers that are not in the buffer list
set complete-=k		    " Scan the files given with the 'dictionary' option
set complete+=kspell  " Use the currently active spell checking |spell|
set complete-=k{dict} " Scan the file {dict}.  Several "k" flags can be given,
                      " patterns are valid too.  For example:
                      " 	:set complete=k/usr/dict/*,k~/spanish
set complete-=s		    " Scan the files given with the 'thesaurus' option
set complete-=s{tsr}	" Scan the file {tsr}.  Several "s" flags can be given,
                      " patterns are valid too.
set complete-=i		    " Scan current and included files
set complete-=d		    " Scan current and included files for name or macro
                	    " |i_CTRL-X_CTRL-D|
set complete+=]		    " Tag completion
set complete+=t		    " Same as "]"

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
let g:neocomplcache_snippets_dir = '~/.vim/snippets'
if !exists('g:neocomplcache_filetype_include_lists')
  let g:neocomplcache_filetype_include_lists= {}
endif

" Configure Dictionaries
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ }

map <Leader>ta :call ToggleAutoComplete()<CR>
function! ToggleAutoComplete()
  if g:neocomplcache_disable_auto_complete == 1
    let g:neocomplcache_disable_auto_complete = 0
    NeoComplCacheEnable
    echo "Auto Completion: On"
  else
    let g:neocomplcache_disable_auto_complete = 1
    NeoComplCacheDisable
    echo "Auto Completion: Off"
  endif
endfunction


" Generate a statusline flag for AutoComplete.
function! AutoCompleteFlag()
  if g:neocomplcache_disable_auto_complete == 1
    return ""
  else
    return "[A]"
  endif
endfunction


" Configure Omnicompletion
augroup AutoComplete
  autocmd! AutoComplete
  autocmd FileType xml            setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType xhtml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css            setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType javascript     setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType php            setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType ruby           setlocal omnifunc=rubycomplete#Complete
  autocmd FileType python         setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType c              setlocal omnifunc=ccomplete#Complete
  autocmd FileType perl,vim       setlocal omnifunc=syntaxcomplete#Complete
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
inoremap <expr><C-z> neocomplcache#undo_completion()
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><CR>  neocomplcache#smart_close_popup()."\<CR>"
nnoremap <Leader>es  :NeoComplCacheEditSnippets<CR>
"-------------------------------------------------------------------------------

" "Snippets (NeoSnippets)"
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"")

" Set snips_author.
if !exists('snips_author')
  let g:snips_author = 'Your Name Here'
endif
"-------------------------------------------------------------------------------



" "Auto Close (DelimitMate)"
"-------------------------------------------------------------------------------



" "Backspace"
" Restore expected functionality to the Backspace key, while in
" Normal mode. Such as backspacing the amount of shiftwidth.
set backspace=indent,eol,start
nnoremap <BS> i<BS><Right><Esc>
"-------------------------------------------------------------------------------



" "Delete"
" Simple delete key in insert mode
inoremap <C-d> <Del>
" Delete contents of a line only
nnoremap <silent><Leader>dd cc<Esc>
" Delete contents of several lines only
vnoremap <silent><Leader>dd 0r<Space>
"-------------------------------------------------------------------------------



" "Space"
" A sensible compromise for the ability to add a quick space whilst in
" Normal mode.
nnoremap <Space><Space> i<Space><Esc>l
"Add a blank line above cursor position
nmap - [<Space>
"Add a blank line below cursor position
nmap = ]<Space>
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
set preserveindent      " Preserve existing characters for indenting
set smartindent
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <Leader>tab :call Tab()<CR>
command! -nargs=* Tab call Tab()
nnoremap <silent><Leader>tt :setlocal expandtab!<CR>
nmap <silent><Leader>tt
      \ :setlocal expandtab!<CR><Bar>
      \ :let OnOrOff=&expandtab<CR><Bar>
      \ :call ToggleOnOff("Soft Tabs", OnOrOff)<CR>

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
    echo 'Current tab settings: '
    echo 'tabstop='.&l:ts
    echo ' shiftwidth='.&l:sw
    echo ' softtabstop='.&l:sts
    if &l:et
      echo ' expandtab'
    else
      echo ' noexpandtab'
    endif
endfunction

" Generate a statusline flag for expandtab.
function! ExpandTabFlag()
  if &expandtab == 0
    return ""
  else
    return "S"
  endif
endfunction

" Generate statusline flags for softtabstop, tabstop, and shiftwidth.
function! TabStopStatus()
  let str = "T:" . &tabstop
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



" "Common Symbols"
" inoremap uu _
" inoremap hh =>
" inoremap aa @
"-------------------------------------------------------------------------------










"}}}
" NAVIGATION: "{{{
"*******************************************************************************
" "Escape" A more efficient alternative to the escape key.
inoremap jj <Esc>
inoremap JJ <Esc>
cnoremap jj <C-c>
cnoremap JJ <C-c>
vnoremap <Space><Space> <Esc>
"-------------------------------------------------------------------------------



" "Virtual Edit"
" Allow the cursor to go where no cursor has gone before. Navigate into lines
" and columns that are not real.
set virtualedit+=block
set virtualedit+=insert
set virtualedit+=onemore
set nostartofline
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



" "Hyper h|j|k|l"
" Consistent use of h|j|k|l with Shift to hyper traverse
" the buffer uiverse!
nnoremap <S-h> ^
nnoremap <S-j> <C-d>
nnoremap <S-k> <C-u>
nnoremap <S-l> $l
vnoremap <S-h> ^
vnoremap <S-j> <C-d>
vnoremap <S-k> <C-u>
vnoremap <S-l> $
"-------------------------------------------------------------------------------



" "Ignore Wrapped Lines"
" Prevent jumping over wrapped lines & use visual lines.
nnoremap j gj
nnoremap k gk
"-------------------------------------------------------------------------------



" "Search"
set hlsearch            " Hightlight search terms
set incsearch           " Highlight search terms dynamically and incrementally
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set wrapscan            " Set the search scan to wrap around the file
" Clear search highlight
nnoremap <silent><Leader>/ :nohlsearch<CR>
" Prevent search current word command from jumping
nnoremap * *``
"-------------------------------------------------------------------------------



" "Search and Replace"
" TODO: Add functionality for visual selection
nnoremap <Leader>asr :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
nnoremap <Leader>sr :call SearchReplace()<CR>
function! SearchReplace()
  let CurrentWord=expand("<cword>")

  " Get search string.
  call inputsave()
  let  CurrentString = input("Search for: ", CurrentWord)
  if (empty(CurrentString))
   return
  endif
  call inputrestore()

  " Get replace string.
  call inputsave()
  let  NewString = input("Search for: ".CurrentString."   Replace with: ")
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



" "Marks (ShowMarks)"
let g:showmarks_enable = 1
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_textlower = ")"
let g:showmarks_textupper = "]"
nnoremap <silent><Leader>tm  :ShowMarksToggle<CR>
nnoremap <silent><Leader>dm  :ShowMarksClearMark<CR>
nnoremap <silent><Leader>dam :ShowMarksClearAll<CR>
nnoremap <silent><Leader>mm  :ShowMarksPlaceMark<CR>
"-------------------------------------------------------------------------------










"}}}
" TOOLS: "{{{
"*******************************************************************************
" "Color Table (XtermColorTable)"
nnoremap <silent><Leader>tct :XtermColorTable<CR>
"-------------------------------------------------------------------------------



" "Present Working Directory"
nnoremap <silent><Leader>pwd :pwd<CR>
"-------------------------------------------------------------------------------










" }}}
" WINDOW: "{{{
"*******************************************************************************
" "Focus Windows"
noremap <silent><Leader>h  :wincmd h<CR>
noremap <silent><Leader>j  :wincmd j<CR>
noremap <silent><Leader>k  :wincmd k<CR>
noremap <silent><Leader>l  :wincmd l<CR>
"-------------------------------------------------------------------------------



" "Move Windows"
noremap <silent><Leader>mh <C-w>H
noremap <silent><Leader>mj <C-w>J
noremap <silent><Leader>mk <C-w>K
noremap <silent><Leader>ml <C-w>L
noremap <silent><Leader>mx <C-w>x
"-------------------------------------------------------------------------------



" "Resize Windows"
nnoremap <Left> <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up> <C-w>+
nnoremap <Down> <C-w>-
"-------------------------------------------------------------------------------



" "Close Windows"
noremap <silent><Leader>cj :wincmd j<CR>:close<CR>
noremap <silent><Leader>ch :wincmd h<CR>:close<CR>
noremap <silent><Leader>ck :wincmd k<CR>:close<CR>
noremap <silent><Leader>cl :wincmd l<CR>:close<CR>
noremap <silent><Leader>cw :close<CR>
"-------------------------------------------------------------------------------



" "Split Windows"
set nosplitbelow
noremap <silent><Leader>sv :vsplit<CR><Bar><C-w>l
set splitright
noremap <silent><Leader>sh :split<CR>
"-------------------------------------------------------------------------------










" }}}
" HELP: "{{{
"*******************************************************************************
nnoremap <silent><F1> "zyw:exe "h ".@z.""<CR>
augroup HelpGroup
  autocmd! HelpGroup
  autocmd WinEnter,BufEnter * :call HelpEnv()   " Set the help environment.
  autocmd WinEnter,BufEnter * :call HelpEnter() " Map Enter to jump to subject.
  autocmd WinEnter,BufEnter * :call HelpBack()  " Map Backspace to jump back.
augroup END

" Set the help environment.
function! HelpEnv()
  if &filetype == 'help'
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal norelativenumber
    setlocal colorcolumn=0
    setlocal noexpandtab
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
" ACTIONS: "{{{
"*******************************************************************************
augroup AllFileTypes
  autocmd!
  autocmd BufWritePre *                 call LastModified()
  autocmd BufWritePre *                 call StripTrailingWhitespace()
  autocmd BufNewFile *                  silent! 0r  ~/.vim.local/templates/%:e.tpl
  " Change the directory to the current file upon entering a buffer.
  autocmd BufEnter *                    silent! lcd %:p:h
augroup END
"-----------------------------------------------------------------------------



augroup HTML
  autocmd!
  autocmd BufNewFile,BufRead *.htm      set filetype=html
  autocmd BufNewFile,BufRead *.html     set filetype=html
  autocmd Filetype html                 call EnableCloseTag()
augroup END
"-----------------------------------------------------------------------------



" "XML/XSL"
autocmd Filetype xml                  call EnableCloseTag()
autocmd Filetype xsl                  call EnableCloseTag()
"-----------------------------------------------------------------------------



" "Shell Script"
autocmd BufWritePost *.sh             call MakeFileExecutable()
"-----------------------------------------------------------------------------



" "Smarty Template Engine"
autocmd BufNewFile,BufRead *.tpl      set filetype=html
"-----------------------------------------------------------------------------



" "Drupal CMS Framework"
autocmd BufNewFile,BufRead *.module   set filetype=php
autocmd BufNewFile,BufRead *.install  set filetype=php
autocmd BufNewFile,BufRead *.test     set filetype=php
"-----------------------------------------------------------------------------



" "PHP"
autocmd BufNewFile,BufRead *.php      set filetype=php
autocmd FileType php                  let php_minlines=500



" "Vim Script"
augroup LocalReload
  autocmd!
  autocmd BufNewFile,BufRead .vim       set filetype=vim
  autocmd bufwritepost .vimrc so $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost  vimrc so $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost .vimrc call Msg('VimEz Reloaded!')
  autocmd bufwritepost  vimrc call Msg('VimEz Reloaded!')
  autocmd bufwritepost  molokai-ez.vim so $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost  molokai-ez.vim call Msg('VimEz Reloaded!')
augroup END
"-----------------------------------------------------------------------------



" "Apache Config"
autocmd BufNewFile,BufRead /*apache*  set filetype=apache
"-----------------------------------------------------------------------------



" "Plain Text"
autocmd BufNewFile,BufRead *.txt      setlocal tw=79
"-----------------------------------------------------------------------------



" "Vimez Dev"
augroup VimezDev
  autocmd!
  autocmd bufwritepost .vimrc so $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost  vimrc so $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost .vimrc call Msg('VimEz Reloaded!')
  autocmd bufwritepost  vimrc call Msg('VimEz Reloaded!')
  autocmd bufwritepost  molokai-ez.vim so $MYVIMRC | exe 'CSApprox' | nohlsearch
  autocmd bufwritepost  molokai-ez.vim call Msg('VimEz Reloaded!')
augroup END
"-------------------------------------------------------------------------------



" "Toggle On/Off Function"
" Prints a message of the current toggled state of various features.
function! ToggleOnOff(OptionName, OnOrOff)
  let OptionName = a:OptionName
  let OnOrOff = a:OnOrOff
	let OptionState = strpart("OffOn", 3 * OnOrOff, 3)
	echo OptionName . ": " . OptionState
endfunction
"-------------------------------------------------------------------------------



" "Message Funtion"
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




" "Last Modified"
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last Modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
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



" "Enable Close Tag"
" Close open tags automatically upon entering </
function! EnableCloseTag()
    so ~/.vim/bundle/closetag.vim/plugin/closetag.vim
endfunction
"-------------------------------------------------------------------------------



" "Make File Executable"
function! MakeFileExecutable()
  exe "silent! !chmod +x %"
  redraw!
  call Msg("Written as an executable shell script!")
endfunction
"-------------------------------------------------------------------------------



" "Source Local Config"
if filereadable(expand("~/.vimrc.local"))
	so ~/.vimrc.local
endif
"-------------------------------------------------------------------------------



" "Wrap Up"
" HACK: Reload Powerline color scheme.
autocmd bufwritepost .vimrc call Pl#Load()
autocmd bufwritepost molokai-ez.vim call Pl#Load()
"-------------------------------------------------------------------------------



" TODO: Refactor statusline
" TODO: Finish grouping autocmds

" FIXME: LastModified function jumps

" NOTE:



" vim: set fdm=marker:
" vim: set ft=vim:
" "}}}
