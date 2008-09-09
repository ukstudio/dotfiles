" Remove all existing highlighting and set the defaults.
hi clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
  syntax reset
endif

let colors_name = "inkpot16"

hi Normal         cterm=NONE   ctermfg=grey   ctermbg=NONE

hi IncSearch      cterm=BOLD   ctermfg=black   ctermbg=yellow
hi Search         cterm=NONE   ctermfg=black   ctermbg=yellow
hi ErrorMsg       cterm=BOLD   ctermfg=white   ctermbg=darkred
hi WarningMsg     cterm=BOLD   ctermfg=white   ctermbg=red
hi ModeMsg        cterm=BOLD   ctermfg=blue   ctermbg=NONE
hi MoreMsg        cterm=BOLD   ctermfg=blue   ctermbg=NONE
hi Question       cterm=BOLD   ctermfg=yellow   ctermbg=NONE

hi StatusLine     cterm=NONE ctermfg=white     ctermbg=darkgrey
hi User1          cterm=BOLD   ctermfg=lightgreen   ctermbg=darkgrey
hi User2          cterm=BOLD   ctermfg=darkblue   ctermbg=darkgrey
hi StatusLineNC   cterm=none ctermfg=grey ctermbg=darkgrey
hi VertSplit      cterm=NONE   ctermfg=grey   ctermbg=darkgrey

hi WildMenu       cterm=BOLD   ctermfg=white   ctermbg=darkblue

hi MBENormal                 ctermfg=grey   ctermbg=NONE
hi MBEChanged                ctermfg=white  ctermbg=NONE
hi MBEVisibleNormal          ctermfg=grey   ctermbg=darkblue
hi MBEVisibleChanged         ctermfg=white ctermbg=darkblue

hi DiffText       cterm=NONE   ctermfg=yellow   ctermbg=magenta
hi DiffChange     cterm=NONE   ctermfg=yellow   ctermbg=darkblue
hi DiffDelete     cterm=NONE   ctermfg=yellow   ctermbg=darkred
hi DiffAdd        cterm=NONE   ctermfg=yellow   ctermbg=darkgreen

hi Cursor         cterm=NONE   ctermfg=darkgrey   ctermbg=blue
hi lCursor        cterm=NONE   ctermfg=darkgrey   ctermbg=green
hi CursorIM       cterm=NONE   ctermfg=darkgrey   ctermbg=blue

hi Folded         cterm=NONE   ctermfg=white   ctermbg=darkblue
hi FoldColumn     cterm=NONE   ctermfg=darkblue   ctermbg=darkgrey

hi Directory      cterm=NONE   ctermfg=green   ctermbg=NONE
hi LineNr         cterm=NONE   ctermfg=blue   ctermbg=darkgrey
hi NonText        cterm=BOLD   ctermfg=blue   ctermbg=NONE
hi SpecialKey     cterm=BOLD   ctermfg=red   ctermbg=NONE
hi Title          cterm=BOLD   ctermfg=darkred   ctermbg=NONE
hi Visual         cterm=NONE   ctermfg=white   ctermbg=darkblue

hi Comment        cterm=NONE   ctermfg=darkyellow   ctermbg=NONE
hi Constant       cterm=NONE   ctermfg=yellow ctermbg=NONE
hi String         cterm=NONE    ctermfg=yellow ctermbg=darkgrey
hi Error          cterm=NONE   ctermfg=white   ctermbg=red
hi Identifier     cterm=NONE   ctermfg=magenta ctermbg=NONE
hi Ignore         cterm=NONE
hi Number         cterm=NONE   ctermfg=yellow   ctermbg=NONE
hi PreProc        cterm=NONE   ctermfg=darkgreen ctermbg=NONE
hi Special        cterm=NONE   ctermfg=darkmagenta   ctermbg=NONE
hi SpecialChar    cterm=NONE   ctermfg=darkmagenta   ctermbg=darkgrey
hi Statement      cterm=NONE   ctermfg=blue   ctermbg=NONE
hi Todo           cterm=BOLD   ctermfg=grey   ctermbg=yellow
hi Type           cterm=NONE   ctermfg=magenta   ctermbg=NONE
"hi Underlined     cterm=BOLD   ctermfg=#df9f2d   ctermbg=NONE
hi TaglistTagName cterm=BOLD   ctermfg=blue   ctermbg=NONE

"hi perlSpecialMatch   cterm=NONE ctermfg=#c080d0   ctermbg=darkgrey
"hi perlSpecialString  cterm=NONE ctermfg=#c080d0   ctermbg=darkgrey
"
"hi cSpecialCharacter  cterm=NONE ctermfg=#c080d0   ctermbg=darkgrey
"hi cFormat            cterm=NONE ctermfg=#c080d0   ctermbg=darkgrey

"hi doxygenBrief                 cterm=NONE ctermfg=#fdab60   ctermbg=NONE
"hi doxygenParam                 cterm=NONE ctermfg=#fdd090   ctermbg=NONE
"hi doxygenPrev                  cterm=NONE ctermfg=#fdd090   ctermbg=NONE
"hi doxygenSmallSpecial          cterm=NONE ctermfg=#fdd090   ctermbg=NONE
"hi doxygenSpecial               cterm=NONE ctermfg=#fdd090   ctermbg=NONE
"hi doxygenComment               cterm=NONE ctermfg=#ad7b20   ctermbg=NONE
"hi doxygenSpecial               cterm=NONE ctermfg=#fdab60   ctermbg=NONE
"hi doxygenSpecialMultilineDesc  cterm=NONE ctermfg=#ad600b   ctermbg=NONE
"hi doxygenSpecialOnelineDesc    cterm=NONE ctermfg=#ad600b   ctermbg=NONE

if v:version >= 700
  hi Pmenu          cterm=NONE  ctermfg=grey ctermbg=darkgrey
  hi PmenuSel       cterm=BOLD  ctermfg=white ctermbg=darkblue
  hi PmenuSbar      cterm=BOLD  ctermfg=darkgreen ctermbg=grey
  hi PmenuThumb     cterm=BOLD  ctermfg=darkgreen ctermbg=darkblue

  hi SpellBad     cterm=undercurl ctermbg=red
  hi SpellRare    cterm=undercurl ctermbg=green
  hi SpellLocal   cterm=undercurl ctermbg=blue 
  hi SpellCap     cterm=undercurl ctermbg=cyan

  hi MatchParen   cterm=NONE      ctermfg=darkcyan   ctermbg=darkgrey
endif
       


