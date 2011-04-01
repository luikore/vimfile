" NOTE: set GHC_HOME for haskell plugin

" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


" Enable plugins 
" ----------------------------------------------------------------
set nocompatible                " We're running Vim, not Vi! 
filetype plugin indent on       " Enable filetype detection,plugin,indent
"compiler ruby                  " let the ftplugin set it


" Display
" ----------------------------------------------------------------
"set co=95			" Columns
"set lines=28

set nu				" Show line number
colorscheme pvividchalk
syntax on
set ch=2			" commandline height

" window title
if has('title') && (has('gui_running') || &title)
  set titlestring=%F\ -\ %{v:progname}
endif

" status bar
set statusline=[%l,%v]\ %Llines\ [%{&ff}]\ [%{GetFencForStatus()}]\ 
set statusline+=%m%r%h%w "flags
function GetFencForStatus()
  let fencstr = (&fenc == '' ? &enc : &fenc) . (&bomb ? '.BOM' : '')
  return fencstr
endfunction

set laststatus=2              " permanently show status bar
set guifont=Menlo\ Regular:h16	" cool Monaco like textmate
set guioptions=egmrhbt    " see :h 'guioptions'			
set nowrap
set fileformats=unix,dos


" Key bindings
" ----------------------------------------------------------------

" Buff and window
map! <C-w>e <ESC><C-w>o
nmap <C-w>e <C-w>o
map! <F2> <ESC>:Explore<CR>
nmap <F2> :Explore<CR>
map! <C-F2> <ESC>:BufExplorer<CR>
nmap <C-F2> :BufExplorer<CR>

" Go to next matched tag
noremap <C-F3> :tnext<CR>
inoremap <C-F3> <ESC>:tnext<CR>
cnoremap <C-F3> <ESC>:tnext<CR>
onoremap <C-F3> <ESC>:tnext<CR>

" indent and un-indent
vmap <Tab> >gv
vmap <S-Tab> <gv

" Search
set ic
nmap <F3> n
map! <F3> <ESC>wn
nmap <S-F3> N
map! <S-F3> <ESC>N

" Debug and quick fix
map! <F4> <ESC>:cnext<CR>
nmap <F4> :cnext<CR>
map! <S-F4> <ESC>:cprevious<CR>
nmap <S-F4> :cprevious<CR>
" F5, C-F5, F6, F7 see ftplugin

" toggle comment (<A-c> comment, <A-v> decomment)
let g:EnhCommentifyUseAltKeys = 'yes'
let g:EnhCommentifyTraditionalMode = 'N'

" sudo
command W w !sudo tee % >/dev/null

let mapleader = ","


" Ruby
" ----------------------------------------------------------------
" load faster
let g:ruby_path=".,,"


" Haskell
" ----------------------------------------------------------------

au Bufenter *.hs compiler ghc
if has("win32") || has("win64")
  let g:haddock_browser=$HOME . "/AppData/Local/Google/Chrome/Application/chrome.exe"
  " haddock path should end with html/
  let g:haddock_docdir=$GHC_HOME . "/doc/html/"
  let g:ghc=$GHC_HOME . "/bin/ghc"
endif


" Tab 
" ----------------------------------------------------------------

" set expandtab
set ts=4
set sw=4
set ai
"set shiftwidth=2 softtabstop=2  " indent 2 spaces


" Encoding and files
" ----------------------------------------------------------------

" set encoding=utf-8            " will cause display problem of gvim
set fenc=utf-8
set fencs=utf-8
set encoding=prc
" set fencs=utf-8,gb18030,gbk,gb2312  " let fenc plugin do it
set nobackup			" no *~ files
set noswf			" no *.swap files
let $FENCVIEW_TELLENC='tellenc' "use external tellenc.exe to decide encoding


" Auto complete 
" ----------------------------------------------------------------

set completeopt=longest,menu	          " auto complete on
let g:rubycomplete_buffer_loading = 1     " use vim +ruby module for omni complete
let g:rubycomplete_classes_in_global = 1  " parse buffer to find classes
let g:rubycomplet_rails = 1		  " enable omni complete with rails


" Search
" ----------------------------------------------------------------

set smartcase			" when in one case,ignore, otherwise sensitive
set hls           " highlight search
set is            " incremental search-show match for partly typed string


" Netrw 
" ----------------------------------------------------------------

let g:netrw_hide=1		" use hiding list
let g:netrw_keepdir=0		" keep the current dir the same as netrw
let g:netrw_list_hide='\.swp$'  " hide *.swp
let g:netrw_liststyle=1	        " long list
" switch to next buffer
nnoremap <F8> :buffers<CR>:buffer<Space>
" let g:netrw_liststyle=3	" tree list


" Mswin behaviors (mostly like mswin.vim, without <C-Tab> and <C-Y>)
" ----------------------------------------------------------------

" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
behave mswin

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X Cut
vnoremap <C-X> "+x

" CTRL-C Copy
vnoremap <C-C> "+y

" CTRL-V Paste
map <C-V>	"+gP
cmap <C-V> <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" Use CTRL-Q to do what CTRL-V used to do
noremap <C-Q>	<C-V>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>	:update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" CTRL-Z is Undo; not in cmdline though (CTRL-R is Redo)
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-F4 is Close window
noremap <C-F4> <C-W>c
inoremap <C-F4> <C-O><C-W>c
cnoremap <C-F4> <C-C><C-W>c
onoremap <C-F4> <C-C><C-W>c


" Custom diff behavior (generated by vim installer)
" ----------------------------------------------------------------

" :h diffexpr
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
