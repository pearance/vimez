 " Vim color file
"
" Author: Fontaine Cook <fontaine.cook@pearance.com>
"
" Description: Based on the molokai color scheme by Tomas Restrepo
" which was based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson


hi clear
set background=dark
syntax reset

let g:colors_name="vimez"
" #080808:232 - Gray2
" #121212:233 - Gray3
" #1c1c1c:234 - Gray4
" #262626:235 - Gray5
" #303030:236 - Gray6
" #3a3a3a:237 - Gray7
" #444444:238 - Gray8
" #808080:8   - Gray9
" #bcbcbc:250 - Gray10

" #d7d787:186 - Tan
" #ff0087:197 - Hot pink
" #87ff00:118 - Neon green
" #afd700:148 - Mustard green
" #5fdfff:81  - Sky blue
" #af87ff:4   - purple


" "General Syntax"
hi Normal           guifg=#af87ff guibg=#121212 gui=bold
hi NonText          guifg=#444444 guibg=NONE
"-------------------------------------------------------------------------------



" "Cursor & UI Aids"
hi Cursor           guifg=#000000 guibg=#87FF00 gui=bold
hi CursorLine                     guibg=#1C1C1C
hi CursorColumn                   guibg=#1C1C1C
hi ColorColumn                    guibg=#080808
hi LineNr           guifg=#606060 guibg=#262626
hi SignColumn       guifg=#AFD700 guibg=#262626
hi VertSplit        guifg=#87FF00 guibg=#121212 gui=bold
hi Visual                         guibg=#303030
hi VisualNOS                      guibg=#403D3D
hi WildMenu         guifg=#080808 guibg=#5fd700 gui=bold
hi Title            guifg=#ef5939
hi Todo             guifg=#FFFF00 guibg=bg      gui=bold
"-------------------------------------------------------------------------------



" "ShowMarks"
" ShowMarksHLl - For marks a-z
hi ShowMarksHLl     guifg=#AFD700 guibg=#262626 gui=bold
" ShowMarksHLu - For marks A-Z
hi ShowMarksHLu     guifg=#AFD700 guibg=#262626 gui=bold
" ShowMarksHLo - For all other marks
hi ShowMarksHLo     guifg=#AFD700 guibg=#262626 gui=bold
" ShowMarksHLm - For multiple marks on the same line.
hi ShowMarksHLm     guifg=#AFD700 guibg=#262626 gui=bold



hi SpecialChar      guifg=#FF0087               gui=bold
hi SpecialComment   guifg=#465457               gui=bold
hi Special          guifg=#5fdfff guibg=bg      gui=italic
hi SpecialKey       guifg=#888A85               gui=italic
hi SpellBad         guisp=#FF0000 gui=undercurl
hi SpellCap         guisp=#7070F0 gui=undercurl
hi SpellLocal       guisp=#70F0F0 gui=undercurl
hi SpellRare        guisp=#FFFFFF gui=undercurl
hi Statement        guifg=#FF0087               gui=bold
hi StorageClass     guifg=#FD971F               gui=italic
hi Structure        guifg=#5fdfff
hi Tag              guifg=#FF0087               gui=italic
"-------------------------------------------------------------------------------



" "Status Line"
hi StatusLine       guifg=#1C1C1C guibg=#87FF00
hi StatusLineNC     guifg=#1C1C1C guibg=#87FF00
" Normal
hi User1            guifg=#1C1C1C guibg=#87FF00 gui=bold
" Dimmed
hi User2            guifg=#5F5F00 guibg=#87FF00 gui=bold
" Non-Current
hi User3            guifg=#303030 guibg=#1C1C1C

let g:Active_statusline=&g:statusline
let g:NCstatusline=substitute(
  \                substitute(g:Active_statusline,
  \                'User1', 'User3', 'g'),
  \                'User2', 'User3', 'g')
au WinEnter,BufEnter * let&l:statusline = g:Active_statusline
au WinLeave * let&l:statusline = g:NCstatusline
"-------------------------------------------------------------------------------



" "Insert Mode Indicator" This specifies which color to change the cursor line
" and status bar to when you enter into Insert modes and back to Normal mode. As
" well as to temporarily turn off search highlighting when in Insert mode and
" back on after escaping.
augroup ModeIndicator
  au InsertEnter * hi User1 guifg=#1C1C1C guibg=#FF005F ctermfg=234 ctermbg=197
  au InsertEnter * hi User2 guifg=#FF005F guibg=#FF005F ctermfg=197 ctermbg=197
  au InsertEnter * hi Cursorline guifg=NONE guibg=NONE gui=underline
  au InsertEnter * hi Cursorline ctermfg=NONE ctermbg=NONE cterm=NONE term=underline
  au InsertEnter * hi CursorColumn ctermfg=NONE ctermbg=NONE cterm=NONE term=underline
  au InsertEnter * setlocal nohlsearch

  au InsertLeave * hi User1 guifg=#1C1C1C guibg=#87FF00 ctermfg=234 ctermbg=118
  au InsertLeave * hi User2 guifg=#5F5F00 guibg=#87FF00 ctermfg=58 ctermbg=118
  au InsertLeave * hi Cursorline guifg=NONE guibg=#87FF00 guisp=#FF005F
  au InsertLeave * hi Cursorline ctermfg=NONE ctermbg=234 cterm=NONE
  au InsertLeave * hi CursorColumn ctermfg=NONE ctermbg=234 cterm=NONE
  au InsertLeave * setlocal hlsearch
augroup END
"-------------------------------------------------------------------------------------------------------------------------------



" "Search & Aids"
hi Search           guifg=#ffffff guibg=#444444
hi IncSearch        guifg=#ffffff guibg=#444444
"-------------------------------------------------------------------------------



" "Diff & Aids"
hi DiffAdd                        guibg=#13354A
hi DiffChange       guifg=#89807D guibg=#4C4745
hi DiffDelete       guifg=#960050 guibg=#1E0010
hi DiffText                       guibg=#4C4745 gui=italic,bold
"-------------------------------------------------------------------------------



" "Folds & Aids"
hi FoldColumn       guifg=#465457 guibg=#262626
hi Folded           guifg=#465457 guibg=#000000
"-------------------------------------------------------------------------------



" "Autocomplete Menu"
hi Pmenu            guifg=#5fdfff guibg=#444444
hi PmenuSel                       guibg=#808080
hi PmenuSbar                      guibg=#080808
hi PmenuThumb       guifg=#5fdfff
"-------------------------------------------------------------------------------



" "Messages"
hi ModeMsg          guifg=#5fdfff guibg=bg
hi ErrorMsg         guifg=#FF0000 guibg=bg      gui=bold
hi MoreMsg          guifg=#5fdfff guibg=bg
hi WarningMsg       guifg=#5fdfff guibg=bg      gui=bold
"-------------------------------------------------------------------------------



" "Syntax Keywords"
hi Comment          guifg=#444444
hi Boolean          guifg=#875FFF
hi Character        guifg=#87FF00
hi Number           guifg=#af87ff
hi String           guifg=#D7D787
hi Conditional      guifg=#FF0087               gui=bold
hi Constant         guifg=#af87ff               gui=bold
hi Debug            guifg=#BCA3A3               gui=bold
hi Define           guifg=#5fdfff
hi Delimiter        guifg=#8F8F8F
hi Error            guifg=#FFFFFF guibg=#FF0000 gui=bold
hi Function         guifg=#AFD700
hi Identifier       guifg=#FD971F
hi Keyword          guifg=#FF0087               gui=bold
hi Label            guifg=#D7D787               gui=none
hi Macro            guifg=#C4BE89               gui=italic
hi SpecialKey       guifg=#5fdfff               gui=italic
hi MatchParen       guifg=#000000 guibg=#FD971F gui=bold
hi Operator         guifg=#FF0087
hi Directory        guifg=#AFD700               gui=bold
hi Exception        guifg=#AFD700               gui=bold
hi Float            guifg=#af87ff
hi Ignore           guifg=#808080 guibg=bg
hi PreCondit        guifg=#AFD700               gui=bold
hi PreProc          guifg=#AFD700
hi Question         guifg=#5fdfff
hi Repeat           guifg=#FF0087               gui=bold
hi Typedef          guifg=#5fdfff
hi Type             guifg=#5fdfff               gui=none
hi Underlined       guifg=#808080               gui=underline
"-------------------------------------------------------------------------------


" TODO: Diff
"The diffs are highlighted with these groups:
"
"|hl-DiffAdd|  DiffAdd   Added (inserted) lines.  These lines exist in
"        this buffer but not in another.
"|hl-DiffChange| DiffChange  Changed lines.
"|hl-DiffText| DiffText  Changed text inside a Changed line.  Vim
"        finds the first character that is different,
"        and the last character that is different
"        (searching from the end of the line).  The
"        text in between is highlighted.  This means
"        that parts in the middle that are still the
"        same are highlighted anyway.  Only "iwhite" of
"        'diffopt' is used here.
"|hl-DiffDelete| DiffDelete  Deleted lines.  Also called filler lines,
"        because they don't really exist in this
"        buffer.
