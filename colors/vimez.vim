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
" #D7D787:186 - tan
" #FF0087:197 - hot pink
" #87FF00:118 - neon green
" #AFD700:148 - mustard green
" #5FD7FF:81  - sky blue



" "General Syntax"
hi Normal           guifg=#CCCCCC guibg=#121212
hi NonText          guifg=#444444 guibg=#121212
"-------------------------------------------------------------------------------



" "Cursor & UI Aids"
hi Cursor           guifg=#000000 guibg=#87FF00 gui=bold
hi CursorLine                     guibg=#1C1C1C
hi CursorColumn                   guibg=#1C1C1C
hi ColorColumn                    guibg=#080808
hi LineNr           guifg=#606060 guibg=#262626
hi VertSplit        guifg=#87FF00 guibg=#121212 gui=bold
hi Visual                         guibg=#303030
hi VisualNOS                      guibg=#403D3D
hi WildMenu         guifg=#080808 guibg=#5fd700 gui=bold
hi Title            guifg=#ef5939
hi Todo             guifg=#FFFF00 guibg=bg      gui=bold
"-------------------------------------------------------------------------------



" "Status Line"
hi StatusLine       guifg=#1C1C1C guibg=#87FF00
hi StatusLineNC     guifg=#1C1C1C guibg=#87FF00
" Normal
hi User1            guifg=#1C1C1C guibg=#87FF00 gui=bold
" Dimmed
hi User2            guifg=#5F5F00 guibg=#87FF00
" Non-Current
hi User3            guifg=#303030 guibg=#1C1C1C
"-------------------------------------------------------------------------------



" "Insert Mode Indicator" This specifies which color to change the cursor line
" and status bar to when you enter into Insert modes and back to Normal mode. As
" well as to temporarily turn off search highlighting when in Insert mode and
" back on after escaping.
au InsertEnter * hi User1 guifg=#1C1C1C guibg=#FF005F ctermfg=234 ctermbg=197
au InsertEnter * hi User2 guifg=#FF005F guibg=#FF005F ctermfg=197 ctermbg=197
au InsertEnter * hi Cursorline guifg=NONE guibg=NONE gui=underline
au InsertEnter * hi Cursorline ctermfg=NONE ctermbg=NONE cterm=underline term=underline
au InsertEnter * setlocal invhlsearch

au InsertLeave * hi User1 guifg=#1C1C1C guibg=#87FF00 ctermfg=234 ctermbg=118
au InsertLeave * hi User2 guifg=#5F5F00 guibg=#87FF00 ctermfg=58 ctermbg=118
au InsertLeave * hi Cursorline guifg=NONE guibg=#87FF00 guisp=#FF0087
au InsertLeave * hi Cursorline ctermfg=NONE ctermbg=234 cterm=NONE
au InsertLeave * setlocal invhlsearch
"-------------------------------------------------------------------------------------------------------------------------------



" "Search & Aids"
hi Search           guifg=#FFFFFF guibg=#455354
hi IncSearch        guifg=#C4BE89 guibg=#000000
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
"-------------------------------------------------------------------------------



" "Autocomplete Menu"
hi Pmenu            guifg=#5FD7FF guibg=#444444
hi PmenuSel                       guibg=#808080
hi PmenuSbar                      guibg=#080808
hi PmenuThumb       guifg=#5FD7FF
"-------------------------------------------------------------------------------



" "Messages"
hi ModeMsg          guifg=#D7D787 guibg=bg
hi ErrorMsg         guifg=#FF0000 guibg=bg      gui=bold
hi MoreMsg          guifg=#D7D787 guibg=bg
hi WarningMsg       guifg=#FFFF87 guibg=bg      gui=bold
"-------------------------------------------------------------------------------



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
