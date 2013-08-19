"  ____  _   _ ____  ____  _     _____ ____ _   _ __  __
" | __ )| | | | __ )| __ )| |   | ____/ ___| | | |  \/  |
" |  _ \| | | |  _ \|  _ \| |   |  _|| |  _| | | | |\/| |
" | |_) | |_| | |_) | |_) | |___| |__| |_| | |_| | |  | |
" |____/ \___/|____/|____/|_____|_____\____|\___/|_|  |_|
"
"
"	Description:    Default colorscheme of VimEz.
" Authors:        Hamish Macpherson, Wimer Hazenberg, Tomas Restrepo
" Maintainer:     Fontaine Cook <fontaine.cook@pearance.com>
" History:        Based on the molokai color scheme by Tomas Restrepo
"                 which was based on the monokai theme for textmate
"                 by Wimer Hazenberg and its darker variant
"                 by Hamish Stuart Macpherson
"-------------------------------------------------------------------------------



" "Terminal Colors" (Recommended for your terminal emulator)
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


hi clear
set background=dark
syntax reset

let g:colors_name="bubblegum"
" #080808:232 - Gray2
" #121212:233 - Gray3
" #1c1c1c:234 - Gray4
" #262626:235 - Gray5
" #303030:236 - Gray6
" #3a3a3a:237 - Gray7
" #444444:238 - Gray8
" #808080:8   - Gray9
" #bcbcbc:250 - Gray10

" #87ff00:118 - Neon green
" #afd700:148 - Mustard green
" #ff0087:197 - Original Molokai Hot pink
" #ff00ff:13 -  Hot pink
" #5fafff:81  - Sky blue
" #af87ff:4   - Purple
" #d7d787:186 - Dark Tan
" #ffd75f:221 - Off Yellow
" #ffff00:226 - Yellow


" "General Syntax"
hi Normal           guifg=#ffffff guibg=#121212

" "Hidden Characters"
" (eol, extends, & precedes)
hi NonText          guifg=#333333 guibg=NONE
" (nbsp, tab, & trail)
hi SpecialKey       guifg=#333333 gui=italic
"-------------------------------------------------------------------------------



" "Cursor & UI Aids"
hi Cursor           guifg=#000000 guibg=#87FF00 gui=bold
hi CursorLine                     guibg=#1C1C1C
hi CursorColumn                   guibg=#1C1C1C
hi ColorColumn                    guibg=#080808
hi LineNr           guifg=#606060 guibg=#262626
hi SignColumn       guifg=#AFD700 guibg=#262626
hi VertSplit        guifg=#87FF00 guibg=bg      gui=bold
hi Visual                         guibg=#303030
hi VisualNOS                      guibg=#403D3D
hi WildMenu         guifg=#080808 guibg=#87ff00 gui=bold
hi title            guifg=#ef5939
hi todo             guifg=#ffff00 guibg=bg      gui=bold,underline
"-------------------------------------------------------------------------------



" "Search & Aids"
hi Search           guifg=#ffffff guibg=#444444
hi IncSearch        guifg=bg      guibg=#ffd75f gui=none
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



" "Messages"
hi ModeMsg          guifg=#ffffff guibg=bg      gui=bold
hi ErrorMsg         guifg=#FF0000 guibg=bg      gui=bold
hi MoreMsg          guifg=#ffffff guibg=bg      gui=bold
hi WarningMsg       guifg=#ffffff guibg=bg      gui=bold
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



hi SpecialChar      guifg=#ff00ff               gui=bold
hi SpecialComment   guifg=#465457               gui=bold
hi Special          guifg=#5fafff guibg=bg      gui=italic
hi SpellBad         guisp=#FF0000 gui=undercurl
hi SpellCap         guisp=#7070F0 gui=undercurl
hi SpellLocal       guisp=#70F0F0 gui=undercurl
hi SpellRare        guisp=#FFFFFF gui=undercurl
"-------------------------------------------------------------------------------



" "Autocomplete Menu"
hi Pmenu            guifg=#5fafff guibg=#262626
hi PmenuSel         guifg=#dddddd guibg=#1c1c1c
hi PmenuSbar                      guibg=#303030
hi PmenuThumb       guifg=#5fafff guibg=#4e4e4e
"-------------------------------------------------------------------------------



" "Syntax Keywords"
hi Comment          guifg=#555555
hi Statement        guifg=#ff00ff               gui=bold
hi StorageClass     guifg=#FD971F               gui=italic
hi Structure        guifg=#5fafff
hi Tag              guifg=#ff00ff               gui=italic
hi Boolean          guifg=#875FFF
hi Character        guifg=#87FF00
hi Number           guifg=#af87ff
hi String           guifg=#D7D787
hi Conditional      guifg=#ff00ff               gui=bold
hi Constant         guifg=#af87ff               gui=bold
hi Debug            guifg=#BCA3A3               gui=bold
hi Define           guifg=#5fafff
hi Delimiter        guifg=#8F8F8F
hi Error            guifg=#FFFFFF guibg=#FF0000 gui=bold
hi Function         guifg=#AFD700
hi Identifier       guifg=#FD971F
hi Keyword          guifg=#ff00ff               gui=bold
hi Label            guifg=#D7D787               gui=none
hi Macro            guifg=#C4BE89               gui=italic
hi MatchParen       guifg=#000000 guibg=#FD971F gui=bold
hi Operator         guifg=#ff00ff
hi Directory        guifg=#AFD700               gui=bold
hi Exception        guifg=#AFD700               gui=bold
hi Float            guifg=#af87ff
hi Ignore           guifg=#808080 guibg=bg
hi PreCondit        guifg=#AFD700               gui=bold
hi PreProc          guifg=#AFD700
hi Question         guifg=#5fafff
hi Repeat           guifg=#ff00ff               gui=bold
hi Typedef          guifg=#5fafff
hi Type             guifg=#5fafff               gui=none
hi Underlined       guifg=#ffff00               gui=none
hi vimIsCommand			guifg=#cccccc

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

