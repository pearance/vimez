 " Vim color file
"
" Author: Fontaine Cook <fontaine.cook@pearance.com>
"
" Note: Based on the molokai color scheme by Tomas Restrepo
" which was based on the monokai theme for textmate
" by Wimer Hazenberg and its darker variant
" by Hamish Stuart Macpherson


hi clear
set background=dark
syntax reset

let g:colors_name="vimez"
" Confirmed
" #D7D787:186 - tan
" #FF0087:197 - hot pink
" #87FF00:118 - neon green
" #AFD700:148 - mustard green
" #5FD7FF:81  - sky blue



" "General Syntax"
hi Normal           guifg=#CCCCCC guibg=#121212
hi NonText          guifg=#444444 guibg=#121212



" "Cursor & UI Aids"
hi Cursor           guifg=#000000 guibg=#87FF00 gui=bold
hi CursorLine                     guibg=#1C1C1C
hi CursorColumn                   guibg=#1C1C1C
hi ColorColumn                    guibg=#080808
hi LineNr           guifg=#606060 guibg=#262626
hi VertSplit        guifg=#87FF00 guibg=#121212 gui=bold
hi Visual                         guibg=#303030
hi VisualNOS                      guibg=#403D3D
hi WildMenu         guifg=#5FD7FF guibg=#000000
hi Title            guifg=#ef5939
hi Todo             guifg=#FFFFFF guibg=bg      gui=bold



" "Search & Aids"
hi Search           guifg=#FFFFFF guibg=#455354
hi IncSearch        guifg=#C4BE89 guibg=#000000



" "Diff & Aids"
hi DiffAdd                        guibg=#13354A
hi DiffChange       guifg=#89807D guibg=#4C4745
hi DiffDelete       guifg=#960050 guibg=#1E0010
hi DiffText                       guibg=#4C4745 gui=italic,bold



" "Folds & Aids"
hi FoldColumn       guifg=#465457 guibg=#262626
hi Folded           guifg=#465457 guibg=#000000



" "Marks Columnu"
hi SignColumn       guifg=#AFD700 guibg=#232526
hi SpecialChar      guifg=#FF0087               gui=bold
hi SpecialComment   guifg=#465457               gui=bold
hi Special          guifg=#5FD7FF guibg=bg      gui=italic
hi SpecialKey       guifg=#888A85               gui=italic
hi SpellBad         guisp=#FF0000 gui=undercurl
hi SpellCap         guisp=#7070F0 gui=undercurl
hi SpellLocal       guisp=#70F0F0 gui=undercurl
hi SpellRare        guisp=#FFFFFF gui=undercurl
hi Statement        guifg=#FF0087               gui=bold
hi StorageClass     guifg=#FD971F               gui=italic
hi Structure        guifg=#5FD7FF
hi Tag              guifg=#FF0087               gui=italic


" "Status Line"
hi clear StatusLine
hi clear StatusLineNC
hi StatusLine       guifg=#080808 guibg=#87FF00 gui=bold
hi StatusLineNC     guifg=#87FF00 guibg=#1C1C1C
hi User1            guifg=red     guibg=#87FF00 gui=bold


" "Autocomplete Menu"
hi Pmenu            guifg=#5FD7FF guibg=#444444
hi PmenuSel                       guibg=#808080
hi PmenuSbar                      guibg=#080808
hi PmenuThumb       guifg=#5FD7FF



" "Messages"
hi ModeMsg          guifg=#D7D787 guibg=bg
hi ErrorMsg         guifg=#FF0000 guibg=bg      gui=bold
hi MoreMsg          guifg=#D7D787 guibg=bg
hi WarningMsg       guifg=#FFFF87 guibg=bg      gui=bold



" "Syntax Keywords"
hi Comment          guifg=#444444
hi Boolean          guifg=#875FFF
hi Character        guifg=#87FF00
hi Number           guifg=#AE81FF
hi String           guifg=#D7D787
hi Conditional      guifg=#FF0087               gui=bold
hi Constant         guifg=#AE81FF               gui=bold
hi Debug            guifg=#BCA3A3               gui=bold
hi Define           guifg=#5FD7FF
hi Delimiter        guifg=#8F8F8F
hi Error            guifg=#FFFFFF guibg=#FF0000 gui=bold
hi Function         guifg=#AFD700
hi Identifier       guifg=#FD971F
hi Keyword          guifg=#FF0087               gui=bold
hi Label            guifg=#D7D787               gui=none
hi Macro            guifg=#C4BE89               gui=italic
hi SpecialKey       guifg=#5FD7FF               gui=italic
hi MatchParen       guifg=#000000 guibg=#FD971F gui=bold
hi Operator         guifg=#FF0087
hi Directory        guifg=#AFD700               gui=bold
hi Exception        guifg=#AFD700               gui=bold
hi Float            guifg=#AE81FF
hi Ignore           guifg=#808080 guibg=bg
hi PreCondit        guifg=#AFD700               gui=bold
hi PreProc          guifg=#AFD700
hi Question         guifg=#5FD7FF
hi Repeat           guifg=#FF0087               gui=bold
hi Typedef          guifg=#5FD7FF
hi Type             guifg=#5FD7FF               gui=none
hi Underlined       guifg=#808080               gui=underline



