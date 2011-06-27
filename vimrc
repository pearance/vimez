" Name: VimEz vimrc
" Description: A robust Vim IDE distribution.
" Maintainer: Fontaine Cook <fontaine.cook@pearance.com
" Dependencies: Requires Vim 7.2 or higher.
" Version: 0.1a



"*****************************************************************************
" GENERAL SETTINGS:
"*****************************************************************************
" "ViMproved"
set nocompatible            " Harnest the iMprovements brough by Vim.



" "Color Scheme"
set background=dark         " Use a dark background. 
set t_Co=256                " Force terminal to go into 256 color mode.
colorscheme vimez	    " Default color scheme for the VimEz distribution.
syntax on		    " Syntax highlighting on.
"-----------------------------------------------------------------------------



" "Plugin Bundles" 
filetype on                 " Turn on file type detection, required for Mac.
filetype off                " Turn it off so run time paths can be set.
source $HOME/.vim/initrc    " Include dependent plugin bundles.
"-----------------------------------------------------------------------------



" "File Types"
filetype plugin indent on   " Automatically detect file types.
au BufNewFile,BufRead initrc set filetype=vim
"-----------------------------------------------------------------------------
