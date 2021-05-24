" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
" play nicely with tmux
map <Esc>[B <Down>
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" pathogen. install all plugins in ~/.vim/bundle using git clone
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set clipboard=unnamed

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " au FileType python source ~/python.vim

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

endif " has("autocmd")

if has("mouse")
    set mouse=a
endif

"--------------------------------------------------
" I don't undestand this
"-------------------------------------------------- 
map <M-Esc>[62~ <MouseDown>
map! <M-Esc>[62~ <MouseDown>
map <M-Esc>[63~ <MouseUp>
map! <M-Esc>[63~ <MouseUp>
map <M-Esc>[64~ <S-MouseDown>
map! <M-Esc>[64~ <S-MouseDown>
map <M-Esc>[65~ <S-MouseUp>
map! <M-Esc>[65~ <S-MouseUp>

"--------------------------------------------------
" Tab key bindings
"-------------------------------------------------- 
map <C-right> :tabnext<cr> 
map <C-l> :tabnext<cr> 
map <C-left> :tabprevious<cr> 
map <C-h> :tabprevious<cr> 
map <C-n> :tabnew<cr> 
"--------------------------------------------------
" I would have bound this to <C-q> but for some strange reason it doesn't work.
"-------------------------------------------------- 
map <C-x> :q<cr> 
map <C-s> :q<cr> 
map <C-s> :w<cr> 
if has("gui_running")
	  " If the current buffer has never been saved, it will have no name,
	  "   " call the file browser to save it, otherwise just save it.
	  :map <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
  endif 
"--------------------------------------------------
" Saving in insert mode without returning to insert mode
"-------------------------------------------------- 
imap <c-s> <esc><c-s>

"--------------------------------------------------
" C support stuff
"-------------------------------------------------- 
let g:C_AuthorName      = 'Nikolas Pontikos'     
let g:C_AuthorRef       = ''                         
let g:C_Email           = ''            
let g:C_Company         = ''    


set list
set listchars:tab:``

set expandtab
set ts=4
set sw=4


set autoindent    " always set autoindenting on
map <;-j> echo 'blahhhhhhh'
set nohlsearch
set scrolloff=4

"
" R support
"
au BufNewFile,BufRead *.R     setf r
au BufNewFile,BufRead *.R     set syntax=r 

" template for filetype
autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e

"
" I don't know who is responsible for setting
" these imaps but they obviously don't work so
" well with latex
"
"iunmap \c
"iunmap \x

" disable annoying visual bell sounds
"set visualbell t_vb=   
set vb t_vb=

map Y y$

" my prefered colorscheme
" colorscheme desert

set guifont=Menlo:h9

" stop creating annoying tilde files
set nobackup

colorscheme darkblue

cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))


fixdel
imap <Del> <BS>

" nerdtree
nmap \e :NERDTreeToggle<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" colour
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

colors zenburn

" fzf
set rtp+=/cluster/project8/vyp/JingYu/git/fzf
