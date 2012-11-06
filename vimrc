" __     _____ __  __ ____   ____
" \ \   / /_ _|  \/  |  _ \ / ___|
"  \ \ / / | || |\/| | |_) | |
"   \ V /  | || |  | |  _ <| |___
"    \_/  |___|_|  |_|_| \_\\____|
"
"
" Authors:       Fontaine Cook, Various Contributors
" Maintainers:
" Description:   The primary Vim configuration file.
"------------------------------------------------------------------------------



" BUNDLES: {{{
" ******************************************************************************

" "Initilization"
set nocompatible
filetype on
filetype off
"-------------------------------------------------------------------------------



" "Plugin/Bundle Manager (Vundle)"
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
let g:vundle_default_git_proto = 'git'
Bundle "gmarik/vundle"
"-------------------------------------------------------------------------------



" "Form Bundles"
Bundle "vimez/vim-themes"
Bundle "vim-scripts/CSApprox"
Bundle "vim-scripts/ScrollColors"
Bundle "lilydjwg/colorizer"
Bundle "othree/html5.vim"
Bundle "hail2u/vim-css-syntax"
Bundle "hail2u/vim-css3-syntax"
Bundle "pangloss/vim-javascript"
Bundle "groenewege/vim-less"
Bundle "plasticboy/vim-markdown"
Bundle "vimez/vim-tmux"


" "Function Bundles"
Bundle "Shougo/neocomplcache"
Bundle "Shougo/neosnippet"
Bundle "vimez/vim-powerline"
Bundle "vim-scripts/YankRing.vim"
Bundle "tpope/vim-surround"
Bundle "tomtom/tcomment_vim"
Bundle "sjl/gundo.vim"
Bundle "mattn/zencoding-vim"
Bundle "docunext/closetag.vim"
Bundle "tpope/vim-repeat"
Bundle "kien/ctrlp.vim"
Bundle "benmills/vimux"
Bundle "duff/vim-bufonly"
Bundle "vim-scripts/bufkill.vim"
Bundle "vimez/vim-showmarks"
Bundle "tpope/vim-unimpaired"
Bundle "tpope/vim-rvm"
Bundle "xolox/vim-session"
Bundle "scrooloose/nerdtree"
Bundle "vim-scripts/Rename2"
Bundle "godlygeek/tabular"
Bundle "vim-scripts/Auto-Pairs"
Bundle "endel/ctrlp-filetype.vim"
"-------------------------------------------------------------------------------



" "Detect File Types"
filetype plugin indent on
"-------------------------------------------------------------------------------



" "Runtimes"
runtime macros/matchit.vim
runtime ftplugin/man.vim
"-------------------------------------------------------------------------------










" }}}
" GENERAL: {{{
" ******************************************************************************

" "Help"
nnoremap <silent><F1> "zyw:exe "h ".@z.""<CR>
"-------------------------------------------------------------------------------



" "Leader Key"
let mapleader="\<Space>"  " Map personal modifier aka Leader key.
"-------------------------------------------------------------------------------



" "Color Scheme & Syntax Highlighting"
set t_Co=256                " Force terminal to go into 256 color mode.
set synmaxcol=300           " Prevent long lines from slowing down redraws.
syntax on		                " Syntax highlighting on.
colorscheme molokai-ez      " Default color scheme.

" Show syntax highlighting group for current word.
nnoremap <Leader>syn :call <SID>SynStack()<CR>
"-------------------------------------------------------------------------------



" "Bundle Wildmenu (Vundle)"
nmap <Leader>b<Tab> :<C-u>Bundle<C-z>
nmap <Leader>1 :<C-u>BundleInstall<CR>
nmap <Leader>2 :<C-u>BundleInstall!<CR>
nmap <Leader>3 :<C-u>BundleClean<CR>
nmap <Leader>4 :<C-u>BundleList<CR>
"-------------------------------------------------------------------------------



" "Clear Cache"
nmap <Leader>\cc :call ClearCache()<CR>
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



" "Mode Lines"
set modelines=5
"-------------------------------------------------------------------------------



" "Timeout Length"
" The time waited for a key code or mapped key sequence to complete.  As you
" become more fluent with the key mappings you may want toC drop this to 250.
set timeoutlen=500 "TODO: RESEARCH
"set notimeout ttimeout ttimeoutlen=200
"-------------------------------------------------------------------------------



" "Update Time"
" How frequent marks, statusbar, swap files, and other are updated.
set updatetime=1000
"-------------------------------------------------------------------------------



" "Wildmenu"
set wildchar=<Tab>
set wildcharm=<C-z>
set wildmenu                 " Enable file/command auto-completion
set wildmode=longest,full    " Auto-complete up to ambiguity
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Linux/MacOSX
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*  " Windows ('noshellslash')
cmap <C-h> <Left>
cmap <C-l> <Right>
"-------------------------------------------------------------------------------



" "Display Full Path"
nnoremap <silent><C-g> 2<C-g>
"-------------------------------------------------------------------------------



" "Reload"
nnoremap <silent><F5> :call Reload()<CR>
"-------------------------------------------------------------------------------










" }}}
" BUFFER: "{{{
" ******************************************************************************

" "General File/Buffer Settings"
set fileformats=unix,dos,mac
set hidden      " Hide buffers when they are abandoned
set confirm     " Provide user friendly prompt over nasty error messages.
set autoread    " Automatically re-read a file if modified outside of vim.
set shellslash  " Use forward slash for shell file names (Windows)
"-------------------------------------------------------------------------------



" "Edit (New/Open) File"
if has("unix")
  nnoremap <Leader>ef :edit <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <Leader>ef :edit <C-R>=expand("%:p:h") . "\\" <CR>
endif
"-------------------------------------------------------------------------------



" "Write File"
if has("unix")
  nnoremap <Leader>wf :write <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <Leader>wf :write <C-R>=expand("%:p:h") . "\\" <CR>
endif
"-------------------------------------------------------------------------------



" "Write File As"
if has("unix")
  nnoremap <Leader>wfa :saveas <C-R>=expand("%:p:h") . "/" <CR>
else
  nnoremap <Leader>wfa :saveas <C-R>=expand("%:p:h") . "\\" <CR>
endif
"-------------------------------------------------------------------------------



" "Goto File Horizontal"
nnoremap gfh :wincmd f<CR>
"-------------------------------------------------------------------------------



" "Goto File Vertical"
nnoremap gfv :vertical wincmd f<CR>
"-------------------------------------------------------------------------------



" "Write File! as Root"
cmap w!! w !sudo tee % >/dev/null
"-------------------------------------------------------------------------------



" "Rename File (Rename2)"
nnoremap <Leader>rf :Rename<Space>
"-------------------------------------------------------------------------------



" "Browse Files (NERDTree)"
let NERDTreeBookmarksFile = expand('~/.vim.local/tmp/NERDTreeBookmarks')
let NERDTreeChDirMode = 2
let NERDTreeMapOpenSplit = 'h'
let NERDTreeMapPreviewSplit = 'gh'
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeMapPreviewVSplit = 'gv'
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen  =  1
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
nnoremap <silent><Leader>, :NERDTreeFind<CR>
nnoremap <silent><Leader>,, :NERDTreeToggle<CR>
"-------------------------------------------------------------------------------



" "Search for Files, Buffers, or MRU (CtrlP)"
let g:ctrlp_map = '<Leader>ll'
let g:ctrlp_cache_dir = '~/.vim.local/tmp/ctrlp/'
let g:ctrlp_open_multiple_files = '1vjr'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_prompt_mappings = {
  \ 'PrtExit()':            ['<esc>', ','],
  \ 'CreateNewFile()':      ['<c-b>'],
  \ }
let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

" Find and set filetypes.
let g:ctrlp_extensions = ['filetype']
nnoremap <silent><Leader>ff :CtrlPFiletype<CR>
nnoremap <silent><Leader>hh :CtrlP<CR>
nnoremap <silent><Leader>jj :CtrlPBuffer<CR>
nnoremap <silent><Leader>kk :CtrlPMRU<CR>
nnoremap <silent><Leader>ll :CtrlP<CR>
"-------------------------------------------------------------------------------



" "New Buffer"
nnoremap <silent><Leader>nb :enew<CR><Bar>i<Space><BS><Esc>
nnoremap <silent><C-n> :enew<CR><Bar>i<Space><BS><Esc>
"-------------------------------------------------------------------------------



" "Write Buffer"
nnoremap <silent><Leader>w :write<CR>
nnoremap <silent><Leader>wb :update<CR>
inoremap <silent> <C-s> <Esc>:update<CR>
nnoremap <silent> <C-s> :update<CR>
vnoremap <silent> <C-s> :update<CR>
"-------------------------------------------------------------------------------



" "Write All Buffers"
" Write all modified buffers. Buffers without a filename will not be saved.
nnoremap <silent><Leader>wab :wall<CR>:exe ":echo 'All buffers saved to files!'"<CR>
"-------------------------------------------------------------------------------



" "Close Buffer (BufKill)"
nnoremap <silent><Leader>cb :BD<CR>
nnoremap <silent><Leader>db :BW <CR>
"-------------------------------------------------------------------------------



" "Close Buffer & Window"
nnoremap <silent><Leader>cbb :bd<CR>
"-------------------------------------------------------------------------------



" "Close Other Buffers (BufOnly)"
nnoremap <silent><Leader>cob :BufOnly<CR>
"-------------------------------------------------------------------------------



" "Close All Buffers"
nnoremap <silent><Leader>cab :exec "1," . bufnr('$') . "bd"<CR>
"-------------------------------------------------------------------------------



" "Undo Close (BufKill)"
nnoremap <silent><Leader>ub :BUNDO<CR>
"-------------------------------------------------------------------------------



" "Next & Previous Buffer (Unimpaired)"
nmap gh [b
nmap gl ]b
"-------------------------------------------------------------------------------



" "Sessions (Vim Session)"
" Changes the effect of the :mksession command. It is a comma separated list of
" words.  Each word enables saving and restoring something:
let g:session_autoload = 'yes'
let g:session_autosave = 'yes'
let g:session_directory = '~/.vim.local/tmp/sessions/'

set sessionoptions=
set ssop+=blank        " Blank	empty windows
set ssop+=buffers	     " Hidden and unloaded buffers, not just those in windows
set ssop+=curdir	     " The current directory
set ssop+=folds	       " Manually created folds, opened/closed folds and local
                       " fold options
set ssop+=globals	     " Global variables that start with an uppercase letter
                       " and contain at least one lowercase letter.  Only
                       " String and Number types are stored.
set ssop+=help		     " Restore help windows.
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

nnoremap <silent><Leader>ws :SaveSession<CR>
nnoremap <silent><Leader>ns :call NewSession()<CR>
nnoremap <silent><Leader>os :SaveSession<CR><Bar>:OpenSession<CR>
nnoremap <silent><Leader>cs :SaveSession<CR><Bar>:CloseSession<CR>
nnoremap <silent><Leader>ds :DeleteSession<CR>
"-------------------------------------------------------------------------------



" "Vim Info"
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
set vi+=!	    " Global variables that start with an uppercase letter and
              " don't contain lowercase letters
set vi+=h	    " Disable 'hlsearch' highlighting when starting
set vi+=%	    " Buffer list (restored when starting Vim without arguments)
set vi+=c	    " Convert the text using 'encoding'
set vi+=s100  " Max amount of kilobytes of any single register.
set vi+=n~/.vim.local/tmp/viminfo
"-------------------------------------------------------------------------------



" "Backups"
set backup                        " Keep backup file after overwriting a file
set writebackup                   " Make a backup before overwriting a file

 " List of directories for the backup file
if has("win32") || has("win64")
  set backupdir=~/_vim.local/tmp/backups//
else
  set backupdir=~/.vim.local/tmp/backups//
end
"-------------------------------------------------------------------------------



" "Swap Files"
" This creates a binary version of each file as a backup in the event there is
" a crash, you have a shot at recovering your file. The swap is updated on every
" 100th character.
set updatecount=100
if has("win32") || has("win64")
  set directory=~/_vim.local/tmp/swaps//
else
  set directory=~/.vim.local/tmp/swaps//
end
"-------------------------------------------------------------------------------



" "Write and Quit"
nnoremap <silent><Leader>wqq :SaveSession<CR>:wqa<CR>
"-------------------------------------------------------------------------------



" "Quit"
" Simpler exit strategy, that prompts if there is any unsaved buffers open.
nnoremap <silent><Leader>Q :qa<CR>
"-------------------------------------------------------------------------------








" "}}}
" EDIT: "{{{
" ******************************************************************************

" "Yank (Yankring)"
set clipboard+=unnamedplus  " Use system clipboard for yanks.

nnoremap Y  "+y$
nnoremap yy "+Y
vnoremap y  "+y
vnoremap Y  "+Y

" Yank from current cursor position to left or right end respectively.
nnoremap yh y0
nnoremap yl y$
"-------------------------------------------------------------------------------



" "Put (YankRing)"
set pastetoggle=<F2>        " Preserve indentation when pasting formatted text.
nnoremap P  "+]P
nnoremap p  "+]p
nnoremap <silent><Leader>pp :YRShow<CR>

let g:yankring_max_history = 1000
let g:yankring_dot_repeat_yank = 1
let g:yankring_window_height = 10
let g:yankring_min_element_length = 3
let g:yankring_replace_n_pkey = '<C-p>'
let g:yankring_replace_n_nkey = '<C-n>'
let g:yankring_history_dir = '~/.vim.local/tmp/'
let g:yankring_history_file = 'yankring_herstory'
"-------------------------------------------------------------------------------



" "Deleting (Cuting)"
nnoremap dh v0d
nnoremap dH v0di
nnoremap dl v$hd
nnoremap dL v$hdi
nnoremap DD v0r<Space>
nnoremap CC v0r<Space>R

" Delete contents of a line only
nnoremap <silent><Leader>dd cc<Esc>

" Simple delete key in insert mode
inoremap <C-d> <Del>

" Delete contents of several lines only
vnoremap <silent><Leader>dd 0r<Space>
"-------------------------------------------------------------------------------



" "Paragraph Formatting"
vnoremap Q gq
nnoremap Q gqip
"-------------------------------------------------------------------------------



" "Undo (Gundo)"
" Persistent undo, along with Gundo to parse the undo history.
set undolevels=1000
set undofile
set undodir=~/.vim.local/tmp/undos//
nnoremap <silent><Leader>uu :GundoToggle<CR>
"-------------------------------------------------------------------------------



" "Select All"
nmap <C-a> ggVG
"-------------------------------------------------------------------------------



" "Bulbbling Line (Unimpaired)"
" Consistent use of [hjkl] with the Shift modifier to move a line of text
" around. Up/down by one line and left/right by amount of shiftwidth.
nmap <S-h> <<
nmap <S-j> ]e
nmap <S-k> [e
nmap <S-l> >>
"-------------------------------------------------------------------------------



" "Bubbling Block (Unimpaired)"
" Consistent use of [hjkl] with the Shift modifier to move a block of text
" around. Up/down by one line and left/right by amount of shiftwidth.
vmap <S-h> <gv
vmap <S-j> ]egv
vmap <S-k> [egv
vmap <S-l> >gv
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
"-------------------------------------------------------------------------------



" "Alignment (Tabularize)"
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
"-------------------------------------------------------------------------------



" "Spell Checking"
" Make sure to update the spelllang to your language. Custom words are tucked
" away in the .vim/spell folder.
set nospell               " Dynamic spell checking off by default
set spelllang=en_us       " Default language
set spellsuggest=5        " How many spelling suggestions to list
set spellfile=~/.vim.local/dictionaries/en.utf-8.add " Custom spell file
nmap <silent><Leader>ts
      \ :setl spell!<CR><Bar>
      \ :let OnOrOff=&spell<CR><Bar>
      \ :call ToggleOnOff(" Spell Checker", OnOrOff)<CR>
"-------------------------------------------------------------------------------










" "}}}
" VIEW: "{{{
" ******************************************************************************

" "Title Bar" Set title bar to display current file, path, and server hostname.
set title
set titlestring=%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{hostname()}
"-------------------------------------------------------------------------------



" "Line Numbers"
set relativenumber
let g:numbertype=1
set numberwidth=3
nnoremap <silent><Leader>tnt :call g:ToggleNumberType()<CR>
nnoremap <silent><Leader>tn :call g:ToggleNumbers()<CR>
"-------------------------------------------------------------------------------



" "Error Alerts"
set noerrorbells        " No audible alerts on error
set novisualbell        " No blinking on error
"-------------------------------------------------------------------------------



" "Cursor Highlights"
" This helps maintain your bearings by highlighting the current line the cursor
" is on as well as the current column.
set cursorline          " Enable cursor line highlight
set cursorcolumn        " Enable cursor column highlight
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



" "Format Characters"
" This controls visibility of non-printable characters that denote certain
" formatting information. Such as eol, tabs, trailing space, etc.
set list
set listchars=eol:\ ,tab:·\ ,trail:\ ,extends:>,precedes:<
nnoremap <silent><Leader>tf
		\ :setlocal list!<CR><Bar>
		\ :let OnOrOff=&list<CR><Bar>
		\ :call ToggleOnOff("Formating Characters", OnOrOff)<CR>
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
"-------------------------------------------------------------------------------



" "Rule"
nnoremap <silent><Leader>tr :call ToggleRule()<CR>
let g:RuleState = 1
"------------------------------------------------------------------------------



" "View Options"
set viewdir=~/.vim.local/tmp/view//
set viewoptions=folds,options,cursor,unix,slash
"-------------------------------------------------------------------------------



" "Folds"
map <leader>f0 :set foldlevel=0<CR>
map <leader>f1 :set foldlevel=1<CR>
map <leader>f2 :set foldlevel=2<CR>
map <leader>f3 :set foldlevel=3<CR>
"-------------------------------------------------------------------------------



" "Status Line (Powerline)"
set noshowmode                    " Message on status line to show current mode.
set showcmd                       " Show (partial) command in states line.
set laststatus=2                  " Keep status lines visible at all times.
set cmdheight=2                   " Number of lines to use for the command-line.

let g:Powerline_theme = 'default'
let g:Powerline_colorscheme = 'default'
let g:Powerline_cache_enabled = 1
let g:Powerline_symbols = 'compatible'
let g:Powerline_stl_path_style = 'filename'
let g:Powerline_mode_n  = 'NORMAL'
let g:Powerline_mode_i  = 'INSERT'
let g:Powerline_mode_R  = 'REPLACE'
let g:Powerline_mode_v  = 'VISUAL'
let g:Powerline_mode_V  = 'VISUAL LINE'
let g:Powerline_mode_cv = 'VISUAL BLOCK'
let g:Powerline_mode_s  = 'SELECT'
let g:Powerline_mode_S  = 'SELECT LINE'
let g:Powerline_mode_cs = 'SELECT BLOCK'
let g:Powerline_symbols_override = {
    \ 'BRANCH': [0x2213],
    \ }
call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')
" call Pl#Theme#RemoveSegment('rvm')
"-------------------------------------------------------------------------------










" "}}}
" INSERT: "{{{
" ******************************************************************************

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
set complete-=s				" Scan the files given with the 'thesaurus' option
set complete-=s{tsr}	" Scan the file {tsr}.  Several "s" flags can be given,
											" patterns are valid too.
set complete-=i		    " Scan current and included files
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
let g:neocomplcache_temporary_dir = '~/.vim.local/tmp/neocache'

" Enable custom omnicompletion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Toggle auto completion and additional mappings.
nnoremap <Leader>ta :call ToggleAutoComplete()<CR>
inoremap <expr><BS> neocomplcache#smart_close_popup() . "\<BS>"
"-------------------------------------------------------------------------------



" "Snippets (NeoSnippets)"
" let g:neosnippet#disable_runtime_snippets = {'_' : 1,}
let g:neosnippet#snippets_directory = '~/.vim/bundle/, ~/.vim.local/snippets/'

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
nnoremap <Leader>es  :NeoSnippetEdit\ -vertical<CR>

" Set snips_author.
if !exists('snips_author')
  let g:snips_author = 'VimEz'
endif
"-------------------------------------------------------------------------------



" "Auto Pairing (Auto-Pairs)"
let g:AutoPairsShortcutFastWrap = '<C-e>'
let g:AutoPairsMapBS = 0
"-------------------------------------------------------------------------------



" "Backspace"
set backspace=indent,eol,start
nnoremap <BS> i<BS><Right><Esc>
"-------------------------------------------------------------------------------



" "Space"
nnoremap ,<Space> i<Space><Esc>l
"Add a blank line above cursor position
nmap - [<Space>
"Add a blank line below cursor position
nmap = ]<Space>
"-------------------------------------------------------------------------------



" "Tab Indentation"
set noexpandtab         " Expand tabs using spaces instead of a tab char
set shiftwidth=2        " Amount of shift when in Normal mode
set tabstop=2           " Number of spaces that a <Tab> in the file counts for.
set softtabstop=2       " Set amount of spaces for a tab
set smarttab            " Uses shiftwidth instead of tabstop at start of lines.
set shiftround          " Use multiples of shiftwidth when indenting
set autoindent          " Enable auto indentation
set copyindent          " Copy the previous indentation on autoindenting
set preserveindent      " Preserve existing characters for indenting

" Give the tab key utiltiy in normal & visual modes.
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap ,<Tab> i<Tab><Esc>

nnoremap <Leader>st :call TabSize()<CR>

" Toggle soft tab.
nnoremap <silent><Leader>tst
      \ :setlocal expandtab!<CR><Bar>
      \ :let OnOrOff=&expandtab<CR><Bar>
      \ :call ToggleOnOff("Soft Tabs", OnOrOff)<CR>

" Define a Tab command that calls a function that prompts for a tab size and
" applies it uniformally to softtabstop, tabstop, and shiftwidth.
command! -nargs=* Tab call TabSize()
"-------------------------------------------------------------------------------










"}}}
" NAVIGATION: "{{{
" ******************************************************************************

" "Escape"
inoremap ,, <Esc>l
inoremap << <Esc>l
cnoremap ,, <C-c>
cnoremap << <C-c>
vnoremap ,, <Esc>
"-------------------------------------------------------------------------------



" "Virtual Edit"
set virtualedit+=block
set virtualedit+=insert
set virtualedit+=onemore
set nostartofline
"-------------------------------------------------------------------------------



" "Scrolling"
set scrolloff=5         " Start scrolling x lines before the edge of the window.
set sidescrolloff=5     " Same as above just for columns instead of lines.
nmap <silent><C-j> <C-d>
vmap <silent><C-j> <C-d>
nmap <silent><C-k> <C-u>
vmap <silent><C-k> <C-u>
nnoremap <silent><C-h> ^
vnoremap <silent><C-h> ^
nnoremap <silent><C-l> $l
vnoremap <silent><C-l> $
map <C-u> kkkkkkkkkkkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzz
			\kzzkzzkzzkzzkzzkzzkzzkzzkzzkzzkzz
map <C-d> jjjjjjjjjjjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzz
			\jzzjzzjzzjzzjzzjzzjzzjzzjzzjzzjzz
"-------------------------------------------------------------------------------



" "Insert Mode Navigation"
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
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

" Clear Search Highlight.
nnoremap <silent>,, :nohlsearch<CR>
"-------------------------------------------------------------------------------



" "Find and Replace"
vnoremap <C-f> :call FindReplace()<CR>
"-------------------------------------------------------------------------------



" "Marks (Showmarks)"
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
let g:showmarks_textlower = ")"
let g:showmarks_textupper = "]"
nnoremap <silent><Leader>dm  :ShowMarksClearMark<CR>
nnoremap <silent><Leader>dam :ShowMarksClearAll<CR>
nnoremap <silent><Leader>tm  :ShowMarksToggle<CR>
"-------------------------------------------------------------------------------










"}}}
" TOOLS: "{{{
" ******************************************************************************

" "Execute Terminal Commands (Vimux)"
let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"

" Prompt for a command to run
nnoremap <Leader>xp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
nnoremap <Leader>xl :VimuxRunLastCommand<CR>

" Inspect runner pane
nnoremap <Leader>xi :VimuxInspectRunner<CR>

" Interrupt any command running in the runner pane
nnoremap <Leader>xs :VimuxInterruptRunner<CR>

" Clear ths tmux history of the runner pane for when
" you enter tmux scroll mode inside the runner pane.
nnoremap <Leader>xx :VimuxClearRunnerHistory<CR>

" Close vim tmux runner opened by VimuxRunCommand
nnoremap <Leader>xq :VimuxCloseRunner<CR>

" Close all other tmux panes in current window
nnoremap <Leader>xa :VimuxClosePanes<CR>

nnoremap <Leader>xc :call VimuxRunCommand("clear")<CR>

nnoremap <F9> :call VimuxRunCommand("colors")<CR>
"-------------------------------------------------------------------------------



" "Present Working Directory"
nnoremap <silent><Leader>pwd :pwd<CR>
"-------------------------------------------------------------------------------



" "Hex Color Fill (Colorizer)"
nmap <Leader>tc <Plug>Colorizer
"-------------------------------------------------------------------------------










" }}}
" WINDOW: "{{{
" ******************************************************************************

" "Window Minimum Dimensions"
set winminwidth=0
set winminheight=0
"-------------------------------------------------------------------------------



" "Focus Windows"
noremap <silent><Leader>h <C-w>h
noremap <silent><Leader>j <C-w>j
noremap <silent><Leader>k <C-w>k
noremap <silent><Leader>l <C-w>l
"-------------------------------------------------------------------------------




" "Move Windows"
noremap <silent><Leader>mh <C-w>H
noremap <silent><Leader>mj <C-w>J
noremap <silent><Leader>mk <C-w>K
noremap <silent><Leader>ml <C-w>L
noremap <silent><Leader>mx <C-w>x
"-------------------------------------------------------------------------------



" "Close Windows"
noremap <silent><Leader>cj :wincmd j<CR>:close<CR>
noremap <silent><Leader>ch :wincmd h<CR>:close<CR>
noremap <silent><Leader>ck :wincmd k<CR>:close<CR>
noremap <silent><Leader>cl :wincmd l<CR>:close<CR>
noremap <silent><Leader>cw :close<CR>
"-------------------------------------------------------------------------------



" "Resize Windows"
nnoremap <Left>  <C-w><
nnoremap <Right> <C-w>>
nnoremap <Up>    <C-w>+
nnoremap <Down>  <C-w>-
"-------------------------------------------------------------------------------



" "Expand & Restore Window"
let g:windowmaximized = 0
map <F12> :call MaxRestoreWindow()<CR>
"-------------------------------------------------------------------------------



" "Split Windows"
set nosplitbelow
nnoremap <silent><Leader>sv :vsplit<CR><Bar><C-w>l<Bar>:bnext<CR>
set splitright
noremap <silent><Leader>sh :split<CR><Bar>:bnext<CR>
"-------------------------------------------------------------------------------










" }}}
" AUTOMATION: "{{{
" ******************************************************************************

" TODO: Migrate to respective ftplugin/filetype.vim files, once this is fleshed
" out. http://vim.wikia.com/wiki/Keep_your_vimrc_file_clean

" "On Start"
augroup Start
  au!
  au VimEnter *                    echo
        \ "  Welcome to VimEz, Happy Coding! :-)"
augroup END
"-----------------------------------------------------------------------------



" "Global"
augroup Global
  au!
  au FileType *           set foldcolumn=2
  au BufNewFile *         silent! 0r  ~/.vim.local/templates/%:e.tpl
  au BufEnter *           silent! lcd %:p:h
  au BufWritePre *        call StripTrailingWhitespace()
  au BufWritePost *       call SaveView()
  au BufRead *            call LoadView()
  au BufRead *            normal zz
  au WinEnter *           setl cursorline
  au WinLeave *           setl nocursorline
  au WinEnter *           setl cursorcolumn
  au WinLeave *           setl nocursorcolumn
  au WinEnter,BufEnter *  call HelpEnvironment()
  au WinEnter,BufEnter *  call HelpJumpForward()
  au WinEnter,BufEnter *  call HelpJumpBack()
augroup END
"-----------------------------------------------------------------------------



" "Apache Config"
augroup ApacheConfig
  au!
  au BufNewFile,BufRead /*apache*  setf=apache
augroup END
"-----------------------------------------------------------------------------



" "C"
augroup C
  au!
  au FileType c  setl omnifunc=ccomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "CSS"
augroup CSS
	au!
  au FileType css  setl omnifunc=csscomplete#CompleteCSS
augroup END
"-----------------------------------------------------------------------------



" "Drupal CMS Framework"
augroup DrupalCMS
  au!
  au BufNewFile,BufRead *.module   setf=php
  au BufNewFile,BufRead *.install  setf=php
  au BufNewFile,BufRead *.test     setf=php
augroup END
"-----------------------------------------------------------------------------



" "Git"
augroup Git
  au!
  au BufNewFile,BufRead COMMIT_EDITMSG  call feedkeys('ggi', 't')
  au BufNewFile,BufRead COMMIT_EDITMSG  setl spell
augroup END
"-----------------------------------------------------------------------------



" "HTML"
augroup HTML
  au!
  au BufNewFile,BufRead *.htm   setf=html
  au BufNewFile,BufRead *.html  setf=html
  au FileType html              setl omnifunc=htmlcomplete#CompleteTags
  au Filetype html              call EnableCloseTag()
augroup END
"-----------------------------------------------------------------------------



" "Javascript"
augroup JavaScript
  au!
  au FileType javascript  setl omnifunc=javascriptcomplete#CompleteJS
augroup END
"-----------------------------------------------------------------------------



" "Markdown"
augroup MarkDown
	au!
  au BufNewFile,BufRead *.markdown  setf=markdown
  au FileType markdown              setl omnifunc=htmlcomplete#CompleteTags
augroup END
"-----------------------------------------------------------------------------



" "Perl"
augroup Perl
  au!
  au FileType perl  setl omnifunc=syntaxcomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "PHP"
augroup PHP
  au!
  au BufNewFile,BufRead *.php  setf=php
  au FileType php	             let php_minlines=500
  au FileType php              setl omnifunc=phpcomplete#CompletePHP
augroup END
"-----------------------------------------------------------------------------



" "Plain Text"
augroup PlainText
  au!
	au BufNewFile,BufRead *.txt  setf=text
	au BufNewFile,BufRead *.txt  setl tw=80
augroup END
"-----------------------------------------------------------------------------



" "Python"
augroup Python
  au!
  au FileType python  setl omnifunc=pythoncomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "Ruby"
augroup Ruby
  au!
  au FileType ruby  setl omnifunc=rubycomplete#Complete
augroup END
"-----------------------------------------------------------------------------



" "Shell Script"
augroup ShellScript
  au!
  au BufNewFile,BufRead *.sh  setf=sh
  au BufWritePost *.sh        call MakeFileExecutable()
augroup END
"-----------------------------------------------------------------------------



" "Smarty Template Engine"
augroup Smarty
  au!
  au BufNewFile,BufRead *.tpl  setf=html
augroup END
"-----------------------------------------------------------------------------



" "Vim Script"
augroup VimScript
	au!
	au BufNewFile,BufRead *.vim	  setf=vim
	au FileType vim               setl omnifunc=syntaxcomplete#Complete
	au BufWritePost {.,_,}vimrc,{.,_,}vimrc.local,molokai-ez.vim
			\  nested so $MYVIMRC
			\| nohlsearch
			\| exe 'CSApprox'
			\| call Pl#Load()
			\| call Msg('Vim Configuration Written & Reloaded!')
augroup END
"-----------------------------------------------------------------------------



" "XML/XSL"
augroup XMLXSL
	au!
	au BufNewFile,BufRead *.xml   setf xml
	au BufNewFile,BufRead *.xsl   setf xml
	au BufNewFile,BufRead *.rss   setf xml
	au BufNewFile,BufRead *.atom  setf xml
	au FileType xml               setl omnifunc=xmlcomplete#CompleteTags
	au Filetype xml               call EnableCloseTag()
	au Filetype xsl               call EnableCloseTag()
augroup END
"-----------------------------------------------------------------------------










" "}}}
" FUNCTIONS: "{{{
" ******************************************************************************

" "Reload Configurations"
if !exists("*Reload")
	function! Reload()
		so $MYVIMRC
		nohlsearch
		" Reapproximate hex color codes for terminal
		exe 'CSApprox'
		" Reapply Powerline color scheme
		call Pl#Load()
		call Msg('Vim Configuration Written & Reloaded!')
	endfunction
endif
"-------------------------------------------------------------------------------



function! ClearCache()
	silent execute "!~/.vim/.aux/clear.sh &>/dev/null &"
	redraw!
	echo "Cache Cleared!"
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



" "Toggle Auto Completion"
function! ToggleAutoComplete()
  if g:neocomplcache_disable_auto_complete == 1
    echo 'Auto Completion: On'
    let g:neocomplcache_disable_auto_complete = 0
    NeoComplCacheEnable
  else
    echo 'Auto Completion: Off'
    let g:neocomplcache_disable_auto_complete = 1
    NeoComplCacheDisable
  endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Maximized/Restore Window"
function! MaxRestoreWindow()
	if g:windowmaximized == 1
		let g:windowmaximized = 0
		wincmd =
		echo 'Windows Restored'
  else
		let g:windowmaximized = 1
		wincmd |
		wincmd _
		echo 'Window Maximized'
	endif
endfunction



" "Ctrl-P Custom Mappings""
function! MyCtrlPMappings()
	nnoremap <buffer><silent><C-c> :call <sid>DeleteBuffer()<cr>
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
  if g:RuleState == 0
    set colorcolumn=0
    redraw!
    let g:RuleState=1
  else
    set colorcolumn=+1
    redraw!
    let g:RuleState=0
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



" "Toggle Number Type"
function! g:ToggleNumberType()
  if(&relativenumber==1)
    echo 'Number Type: Normal'
    set number
    let g:numbertype=0
  else
    echo 'Number Type: Relative'
    set relativenumber
    let g:numbertype=1
  endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Numbers"
function! g:ToggleNumbers()
  if(g:numbertype==1)
    call g:ToggleRelativeNumbers()
  else
  	call g:ToggleNormalNumbers()
  endif
endfunction
"-------------------------------------------------------------------------------



" "Toggle Normal Numbers"
function! g:ToggleNormalNumbers()
  if(&number==1)
    setlocal nonumber
  else
    setlocal number
  endif
  let OnOrOff=&number
  call ToggleOnOff("Line Numbers", OnOrOff)
endfunction
"-------------------------------------------------------------------------------



" "Toggle Relative Numbers"
function! g:ToggleRelativeNumbers()
  if(&relativenumber==1)
    setlocal norelativenumber
  else
    setlocal relativenumber
  endif
  let OnOrOff=&relativenumber
  call ToggleOnOff('Relative Line Numbers', OnOrOff)
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



" "Show Syntax Highlight Group"
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
"-------------------------------------------------------------------------------



" "New Session"
function! NewSession()
  call inputsave()
  let SessionName = input('New Session Name: ')
  exe "SaveSession " . SessionName
endfunction
"-------------------------------------------------------------------------------



" "Set Help Environment"
function! HelpEnvironment()
  if &filetype == 'help'
    setlocal nocursorline
    setlocal nocursorcolumn
    setlocal norelativenumber
    setlocal colorcolumn=0
    setlocal noexpandtab
  endif
endfunction
"-------------------------------------------------------------------------------



" "Help Jump Forward"
function! HelpJumpForward()
  if &filetype == 'help'
    nnoremap <CR> <C-]>
  else
    nnoremap <CR> i<CR><Esc>
  endif
endfunction
"-------------------------------------------------------------------------------



" "Help Jump Back"
function! HelpJumpBack()
  if &filetype == 'help'
    nnoremap <BS> <C-T>
  else
    nnoremap <BS> i<BS><Right><Esc>
  endif
endfunction
"-------------------------------------------------------------------------------



" "Enable Close Tag"
" Close open tags automatically upon entering </
function! EnableCloseTag()
    so ~/.vim/bundle/closetag.vim/plugin/closetag.vim
endfunction
"-------------------------------------------------------------------------------



" "Current Session Status"
function! CurrentSession()
  let g:currSession = fnamemodify(v:this_session, ':t:r')
  return g:currSession
endfunction
"-------------------------------------------------------------------------------



" "Make File Executable"
function! MakeFileExecutable()
  exe "silent! !chmod +x %"
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
"-------------------------------------------------------------------------------



" "Escape String"
" Escape special characters in a string for exact matching. This is useful to
" copying strings from the file to the search tool Based on this
" - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction
"-------------------------------------------------------------------------------



" "Get Visual Selection"
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










" "}}}
" WRAP: "{{{
" ******************************************************************************

" "Load Local Configurations"
if filereadable(expand('~/.vimrc.local'))
  so ~/.vimrc.local
endif
"-------------------------------------------------------------------------------



" "Todo/s, Fixme/s"
" TODO: session info in powerline
" TODO: create functions to toggle cursor column and line.

" vim:ft=vim:fdm=marker:
" }}}
