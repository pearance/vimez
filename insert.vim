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
"-------------------------------------------------------------------------------



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
nnoremap <Leader>es  :NeoSnippetEdit<CR>

" Set snips_author.
if !exists('snips_author')
  let g:snips_author = 'VimEz'
endif

" imap <silent> <C-l> <Plug>(neocomplcache_snippets_expand)
" PopupMap <C-y>   neocomplcache#close_popup()
" PopupMap <C-e>   neocomplcache#cancel_popup()
" PopupMap <CR>    neocomplcache#close_popup() . "\<CR>"
" PopupMap <Tab>   "\<C-n>"
" PopupMap <S-Tab> "\<C-p>"
"-------------------------------------------------------------------------------



" "Auto Pairing (Auto-Pairs)"
let g:AutoPairsShortcutFastWrap = '<C-f>'
let g:AutoPairsCenterLine = 0
"-------------------------------------------------------------------------------



" "Backspace"
set backspace=indent,eol,start
nnoremap <BS> i<BS><Right><Esc>
"-------------------------------------------------------------------------------



" "Space"
nnoremap ,<Space> i<Space><Esc>l
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
