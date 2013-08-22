" vim:ft=vim:fdm=marker:
"                  _       _         _
"  _ __ ___   ___ | | ___ | | ____ _(_) ___ ____
" | '_ ` _ \ / _ \| |/ _ \| |/ / _` | |/ _ \_  /
" | | | | | | (_) | | (_) |   < (_| | |  __// /
" |_| |_| |_|\___/|_|\___/|_|\_\__,_|_|\___/___|
"
"
"
" Authors:        Hamish Macpherson, Wimer Hazenberg, Tomas Restrepo
"	Description:    Default colorscheme of VimEz. Based on the molokai color
"                 scheme by Tomas Restrepo which was based on the monokai theme
"                 for textmate by Wimer Hazenberg and its darker variant by
"                 Hamish Stuart Macpherson
"-------------------------------------------------------------------------------



" COLORS:"{{{
" ******************************************************************************

" "Terminal Colors""{{{
" fg 196 141 255
" bg 18 18 18
" black 26 26 26
" red 229 34 34
" green 166 227 45
" yellow 252 149 30
" blue 196 141 255
" magenta 233 4 125
" cyan 103 217 240
" white 255 255 255



"}}}
" "Primary Syntax Colors"
" #BCBCBC:250 #121212:233

" #FF0087:198 #D7D787:186 #5FD7FF:81 #AFD700:148 #444444;240
"-------------------------------------------------------------------------------



" "UI/Secondary Colors"
" #FF005F:197 #87FF00:118 #FFD700:220 #AF87FF:141 #FF8700:208 #FF5F5F:203

" #080808 #121212 #1C1C1C #262626 #303030 #444444 #808080
"-------------------------------------------------------------------------------

"}}}
" INTIALIZATION:"{{{
" ******************************************************************************
hi clear

if exists("syntax_on")
	syntax reset
endif

set background=dark
let g:colors_name="molokaiez"
"-------------------------------------------------------------------------------

"}}}
" USER INTERFACE:"{{{
" ******************************************************************************

" "General""{{{
hi Normal           guifg=#B2B2B2 guibg=#121212
hi WildMenu         guifg=#87FF00 guibg=#262626
hi Directory        guifg=#AFD700 guibg=bg
"-------------------------------------------------------------------------------
"}}}
" "Window Split""{{{
hi VertSplit        guifg=NONE    guibg=#262626
"-------------------------------------------------------------------------------
"}}}
" "Cursor""{{{
hi Cursor           guifg=#000000 guibg=#AFD700
hi CursorLine                     guibg=#1C1C1C
hi CursorColumn                   guibg=#1C1C1C
hi CursorLineNr     guifg=#121212 guibg=#AFD700 gui=NONE
"-------------------------------------------------------------------------------
"}}}
" "#/+ Columns""{{{
hi LineNr           guifg=#666666 guibg=#262626
hi SignColumn       guifg=#AFD700 guibg=#262626
"-------------------------------------------------------------------------------
"}}}
" "ShowMarks""{{{
hi ShowMarksHLl     guifg=#AFD700 guibg=#262626 gui=NONE
hi ShowMarksHLu     guifg=#AFD700 guibg=#262626 gui=NONE
hi ShowMarksHLo     guifg=#AFD700 guibg=#262626 gui=NONE
hi ShowMarksHLm     guifg=#AFD700 guibg=#262626 gui=NONE
"-------------------------------------------------------------------------------
"}}}
" "Diff""{{{
hi DiffAdd          guifg=#000000 guibg=#D7FFAF
hi DiffChange       guifg=#000000 guibg=#5FD7FF
hi DiffDelete       guifg=#000000 guibg=#FFAFAF
hi DiffText         guifg=#000000 guibg=#D7FFAF

hi SignifyLineAdd    guifg=#000000 guibg=#D7FFAF
hi SignifyLineChange guifg=#000000 guibg=#5FD7FF
hi SignifyLineDelete guifg=#000000 guibg=#FFAFAF

hi SignifySignAdd    guifg=#D7FFAF guibg=#262626
hi SignifySignChange guifg=#5FD7FF guibg=#262626
hi SignifySignDelete guifg=#FFAFAF guibg=#262626
"-------------------------------------------------------------------------------
"}}}
" "Folds""{{{
hi FoldColumn       guifg=#AFD700 guibg=#262626
hi Folded           guifg=#AFD700 guibg=bg
"-------------------------------------------------------------------------------
"}}}
" "Meta Characters""{{{
" The 'NonText' highlightinG WILL be used FOR 'eol', 'extends' and precedes.
" SpecialKey" for 'nbsp', 'TAB' And 'traiL'.
hi NonText          guifg=#444444 guibg=bg
hi SpecialKey       guifg=#444444 guibg=bg      gui=italic
hi MatchParen       guifg=#080808 guibg=#FFD700
"-------------------------------------------------------------------------------
"}}}
" "Rule""{{{
hi ColorColumn                    guibg=#080808
"-------------------------------------------------------------------------------
"}}}
" "Tab Line""{{{
hi title            guifg=#AFD700
hi TabLine          guifg=#080808 guibg=#444440
hi TabLineFill                    guibg=#262626
hi TabLineSel       guifg=#AFD700 guibg=bg
"-------------------------------------------------------------------------------
"}}}
" "Visual Selection""{{{
hi Visual                         guibg=#303030
hi VisualNOS                      guibg=#303030
"-------------------------------------------------------------------------------
"}}}
" "Search""{{{
hi Search           guifg=#000000 guibg=#FFD700
hi IncSearch        guifg=#000000 guibg=#FFD700
"-------------------------------------------------------------------------------
"}}}
" "Messages""{{{
hi ModeMsg          guifg=fg      guibg=bg
hi ErrorMsg         guifg=#FF0000 guibg=bg
hi MoreMsg          guifg=fg      guibg=bg
hi Question         guifg=fg      guibg=bg
hi WarningMsg       guifg=fg      guibg=bg
"-------------------------------------------------------------------------------
"}}}
" "Spell Checker""{{{
hi SpellBad         guisp=#FF5F5F gui=undercurl
hi SpellCap         guisp=#FF5F5F gui=undercurl
hi SpellLocal       guisp=#FF8700 gui=undercurl
hi SpellRare        guisp=#FF8700 gui=undercurl
"-------------------------------------------------------------------------------
"}}}
" "Autocomplete Menu""{{{
hi Pmenu            guifg=#666666 guibg=#1C1C1C
hi PmenuSel         guifg=#666666 guibg=#121212
hi PmenuSbar        guifg=NONE    guibg=#262626
hi PmenuThumb       guifg=NONE    guibg=#444444
"-------------------------------------------------------------------------------
"}}}
" "Insert Mode Indicator""{{{
" This specifies which color to change the cursor line
" and status bar to when you enter into Insert modes and back to Normal mode. As
" well as to temporarily turn off search highlighting when in Insert mode and
" back on after escaping.
" augroup ModeIndicator
"   au InsertEnter * hi User1 guifg=#1C1C1C guibg=#FF005F ctermfg=234 ctermbg=197
"   au InsertEnter * hi User2 guifg=#FF005F guibg=#FF005F ctermfg=197 ctermbg=197
"   au InsertEnter * hi Cursorline guifg=NONE guibg=NONE gui=underline
"   au InsertEnter * hi Cursorline ctermfg=NONE ctermbg=NONE cterm=NONE term=underline
"   au InsertEnter * hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE term=underline
"   au InsertEnter * setlocal nohlsearch
"
"   au InsertLeave * hi User1 guifg=#1C1C1C guibg=#87FF00 ctermfg=234 ctermbg=118
"   au InsertLeave * hi User2 guifg=#5F5F00 guibg=#87FF00 ctermfg=58 ctermbg=118
"   au InsertLeave * hi Cursorline guifg=NONE guibg=#87FF00 guisp=#FF005F
"   au InsertLeave * hi Cursorline ctermfg=NONE ctermbg=234 cterm=NONE
"   au InsertLeave * hi CursorColumn ctermfg=NONE ctermbg=234 cterm=NONE
"   au InsertLeave * setlocal hlsearch
" augroup END
"-------------------------------------------------------------------------------------------------------------------------------

"}}}
" "Startify:"{{{
hi StartifyBracket guifg=#444444 guibg=NONE
hi StartifyHeader  guifg=#AFD700 guibg=NONE
hi StartifyNumber  guifg=#AFD700 guibg=NONE
hi StartifyPath    guifg=#BCBCBC guibg=NONE
hi StartifySlash   guifg=#BCBCBC guibg=NONE
"}}}
" "Powerline:"{{{
call Pl#Hi#Allocate({
	\ 'color0'  : 234,
	\ 'color1'  : 236,
	\ 'color2'  : 238,
	\ 'color3'  : 225,
	\ 'color4'  : 148,
	\ 'color5'  : 196,
	\ 'color6'  : 220,
	\
	\ 'black'   : 16,
	\ 'gray0'   : 233,
	\ 'gray1'   : 234,
	\ 'gray1-1' : 235,
	\ 'gray2'   : 236,
	\ 'gray3'   : 238,
	\ 'gray4'   : 240,
	\ 'gray5'   : 241,
	\ 'gray6'   : 244,
	\ 'gray7'   : 245,
	\ 'gray8'   : 247,
	\ 'gray9'   : 249,
	\ 'gray10'  : 252,
	\ 'white'   : 15,
	\ })

" color0 NONE     gray0 #121212
" color1 NONE     gray1 #1c1c1c
" color2 NONE     gray2 #303030
" color3 NONE     gray3 #444444
" color4 #aFd700  gray4 #585858
" color5 #ff0000  gray5 #626262
" color6 #fFd700  gray6 #808080

let g:Powerline#Colorschemes#default#colorscheme = Pl#Colorscheme#Init([
	\ Pl#Hi#Segments(['SPLIT'], {
		\ 'n': ['gray2', 'gray1-1'],
		\ 'N': ['gray2', 'gray1'],
		\ 'i': ['gray2', 'color4'],
		\ }),
	\
	\ Pl#Hi#Segments(['mode_indicator'], {
		\ 'n': ['gray0', 'color4', ['none']],
		\ 'i': ['gray0', 'color4', ['none']],
		\ 'v': ['gray0', 'color4', ['none']],
		\ 'r': ['gray0', 'color4', ['none']],
		\ 's': ['gray0', 'color4', ['none']],
		\ }),
	\
	\ Pl#Hi#Segments(['branch', 'scrollpercent', 'raw', 'filesize'], {
		\ 'n': ['gray3', 'gray1'],
		\ 'N': ['gray2', 'gray1'],
		\ 'i': ['gray3', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo', 'filename'], {
		\ 'n': ['color4', 'gray1', ['none']],
		\ 'N': ['gray3', 'gray1', ['none']],
		\ 'i': ['color4', 'gray1', ['none']],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo.filepath'], {
		\ 'n': ['gray2'],
		\ 'N': ['gray2'],
		\ 'i': ['gray2'],
		\ }),
	\
	\ Pl#Hi#Segments(['static_str'], {
		\ 'n': ['gray9', 'gray4'],
		\ 'N': ['gray9', 'gray4'],
		\ 'i': ['gray9', 'gray4'],
		\ }),
	\
	\ Pl#Hi#Segments(['fileinfo.flags'], {
		\ 'n': ['color5', ['bold']],
		\ 'N': ['color5'],
		\ 'i': ['color5', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['currenttag', 'fullcurrenttag', 'fileformat', 'fileencoding', 'pwd', 'filetype', 'rvm:string', 'rvm:statusline', 'virtualenv:statusline', 'charcode', 'currhigroup'], {
		\ 'n': ['gray2', 'gray1'],
 		\ 'i': ['gray2', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['lineinfo'], {
		\ 'n': ['gray2', 'color4', ['none']],
		\ 'N': ['gray1', 'gray1', ['none']],
		\ 'i': ['gray2', 'color4', ['none']],
		\ }),
	\
	\ Pl#Hi#Segments(['errors'], {
		\ 'n': ['color5', 'gray2', ['none']],
		\ 'i': ['color5', 'gray2', ['none']],
		\ }),
	\
	\ Pl#Hi#Segments(['lineinfo.line.tot'], {
		\ 'n': ['gray4'],
		\ 'N': ['gray1'],
		\ 'i': ['gray4'],
		\ }),
	\
	\ Pl#Hi#Segments(['paste_indicator', 'ws_marker'], {
		\ 'n': ['white', 'color5', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:static_str.name', 'command_t:static_str.name'], {
		\ 'n': ['gray3', 'white', ['bold']],
		\ 'N': ['gray7', 'gray1', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:static_str.buffer', 'command_t:raw.line'], {
		\ 'n': ['gray3', 'gray1'],
		\ 'N': ['gray7', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['gundo:SPLIT', 'command_t:SPLIT'], {
		\ 'n': ['black', 'gray2'],
		\ 'N': ['gray7', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['lustyexplorer:static_str.name', 'minibufexplorer:static_str.name', 'nerdtree:raw.name', 'tagbar:static_str.name'], {
		\ 'n': ['gray3', 'gray1', ['bold']],
		\ 'N': ['gray7', 'gray1', ['none']],
		\ }),
	\
	\ Pl#Hi#Segments(['lustyexplorer:static_str.buffer', 'tagbar:static_str.buffer'], {
		\ 'n': ['gray1', 'gray2'],
		\ 'N': ['gray7', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['lustyexplorer:SPLIT', 'minibufexplorer:SPLIT', 'nerdtree:SPLIT', 'tagbar:SPLIT'], {
		\ 'n': ['white', 'gray2'],
		\ 'N': ['gray7', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:focus', 'ctrlp:byfname'], {
		\ 'n': ['gray3', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:prev', 'ctrlp:next', 'ctrlp:pwd'], {
		\ 'n': ['gray3', 'gray1'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:item'], {
		\ 'n': ['gray3', 'white', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:marked'], {
		\ 'n': ['color5', 'gray1', ['bold']],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:count'], {
		\ 'n': ['color5', 'white'],
		\ }),
	\
	\ Pl#Hi#Segments(['ctrlp:SPLIT'], {
		\ 'n': ['black', 'gray2'],
		\ }),
	\ ])
"-------------------------------------------------------------------------------

" "Legacy Status Line""{{{
" hi StatusLine       guifg=#1C1C1C guibg=#87FF00
" hi StatusLineNC     guifg=#1C1C1C guibg=#87FF00
" " Normal
" hi User1            guifg=#1C1C1C guibg=#87FF00 gui=NONE
" " Dimmed
" hi User2            guifg=#5F5F00 guibg=#87FF00 gui=NONE
" " Non-Current
" hi User3            guifg=#303030 guibg=#1C1C1C
"
" let g:Active_statusline=&g:statusline
" let g:NCstatusline=substitute(
"   \                substitute(g:Active_statusline,
"   \                'User1', 'User3', 'g'),
"   \                'User2', 'User3', 'g')
" au WinEnter,BufEnter * let&l:statusline = g:Active_statusline
" au WinLeave * let&l:statusline = g:NCstatusline
"-------------------------------------------------------------------------------


"}}}
"}}}

"}}}
" GENERAL SYNTAX:"{{{
" ******************************************************************************

" "Comments"
hi Comment          guifg=#444444
 "-------------------------------------------------------------------------------

" "Values"
hi Constant         guifg=#5FD7FF               gui=NONE
hi Character        guifg=#5FD7FF               gui=NONE
hi Number           guifg=#5FD7FF               gui=NONE
hi Boolean          guifg=#5FD7FF               gui=NONE
hi Float            guifg=#5FD7FF               gui=NONE
hi String           guifg=#5FD7FF               gui=NONE
"-------------------------------------------------------------------------------

" "Names" Function and variable names.
hi Identifier       guifg=#D7D787               gui=NONE
hi Function         guifg=#D7D787               gui=NONE
"-------------------------------------------------------------------------------

" "Statements" Major keywords and operators.
hi Statement        guifg=#FF0087               gui=NONE
hi Conditional      guifg=#FF0087               gui=NONE
hi Repeat           guifg=#FF0087               gui=NONE
hi Label            guifg=#FF0087               gui=NONE
hi Operator         guifg=#FF0087               gui=NONE
hi Keyword          guifg=#FF0087               gui=NONE
hi Exception        guifg=#FF0087               gui=NONE
"-------------------------------------------------------------------------------

" "Preprocessors"
hi PreProc          guifg=#AFD700               gui=NONE
hi Include          guifg=#AFD700               gui=NONE
hi Define           guifg=#AFD700               gui=NONE
hi Macro            guifg=#AFD700               gui=NONE
hi PreCondit        guifg=#AFD700               gui=NONE
"-------------------------------------------------------------------------------

" "Type"
hi Type             guifg=#D7D787               gui=NONE
hi StorageClass     guifg=#D7D787               gui=NONE
hi Structure        guifg=#D7D787               gui=NONE
hi Typedef          guifg=#D7D787               gui=NONE
"-------------------------------------------------------------------------------

" "Special"
hi Special          guifg=#5FD7FF               gui=NONE
hi SpecialChar      guifg=#AFAFD7               gui=NONE
hi Tag              guifg=#AFAFD7               gui=NONE
hi Delimiter        guifg=#BCBCBC               gui=NONE
hi SpecialComment   guifg=#D7D787               gui=underline
hi Debug            guifg=#FF005F               gui=NONE
"-------------------------------------------------------------------------------

" "Misc"
hi Underlined       guifg=#808080               gui=underline
hi Ignore           guifg=#B2B2B2 guibg=bg      gui=NONE
hi Error            guifg=#FFFFFF guibg=#FF0000 gui=NONE
hi Todo             guifg=#FFD700 guibg=bg      gui=bold
"-------------------------------------------------------------------------------

"}}}
" GIT SYNTAX:"{{{
" ******************************************************************************

hi DiffAdded               guifg=#87FF00 guibg=bg gui=NONE
hi DiffRemoved             guifg=#FF005F guibg=bg gui=NONE
hi GitCommitDiff           guifg=#BCBCBC guibg=bg gui=NONE
hi GitCommitSummary        guifg=#BCBCBC guibg=bg gui=NONE
hi gitcommitHeader         guifg=#5FD7FF guibg=bg gui=NONE
hi gitcommitDiscardedType  guifg=#FFD700 guibg=bg gui=NONE
hi gitcommitDiscardedFile  guifg=#FFD700 guibg=bg gui=NONE
hi gitcommitSelectedType   guifg=#87FF00 guibg=bg gui=NONE
hi gitcommitSelectedFile   guifg=#87FF00 guibg=bg gui=NONE
hi gitcommitUntrackedFile  guifg=#FF0000 guibg=bg gui=NONE
"-------------------------------------------------------------------------------

"}}}
" HTML SYNTAX:"{{{
" ******************************************************************************

hi link htmlItalic               Normal
hi link htmlSpecialTagName       Exception
hi link htmlTagN                 Statement
"-------------------------------------------------------------------------------

"}}}
" VIMSCRIPT SYNTAX:"{{{

" Pink
hi link VimCommand         Statement
hi link VimFuncName        Statement

" Blue
hi link VimIsCommand       Constant
hi link VimSetEqual        Ignore
hi link VimSet             Constant
hi link VImGroup           Constant
hi link VimAutoEvent       Constant
hi link VimFBVar           Number
hi link VimGroupName       Constant

" Tan
hi link VimCommentString   SpecialComment

" Lavender
hi link VimFunction        Tag

hi link VimHiGuiRgb        PreProc
"-------------------------------------------------------------------------------

"}}}
" SCSS SYNTAX:"{{{
" ******************************************************************************

" Pink
hi link CssColorProp       Statement
hi link CssFontProp        Statement
hi link CssRenderProp      Statement
hi link SassProperty       Statement
hi link CssTextProp        Operator
hi link CssBoxProp         Operator
hi link SassIDChar         Operator
hi link SassClassChar      Operator
hi link CssPseudoClass     Operator
hi link CssUIProp          Operator
hi link SassMixing         Operator
hi link SassDefinition     Operator
hi link CssFontAttr        Operator
hi link CssUIAttr          Operator
hi link CssGeneratedContentProp Statement

" Tan
hi link CssBraces          Type
" hi link SassDefinition     Type
hi link SassMixinName      Type
hi link SassClass          Type
hi link CssMediaComma      Type
hi link CssTagName         Type

" Blue
hi link SassVariable       Constant
hi link CssCommonAttr      Constant
hi link CssTextAttr        Constant
hi link CssStringQ         Constant
hi link CssValueLength     Constant
hi link SassCssAttribute   Constant
hi link CssColor           Constant
hi link CssRenderAttr      Constant
hi link CssBoxAttr         Constant
hi link SassMixinName      Constant
hi link CssGeneratedContentAttr Constant

" Green
hi link CssImportant       PreProc
hi link CssPseudoClass     PreProc
hi link CssPseudoClassId   PreProc
"-------------------------------------------------------------------------------
"}}}
