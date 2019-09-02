" General Stuff
syntax on
colorscheme monokai
set nocp
filetype plugin on

" Vundle
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/Vundle.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/ListToggle'
Bundle 'scrooloose/syntastic'
Bundle 'elzr/vim-json'
Bundle 'vim-scripts/searchfold.vim'
Bundle 'pbrisbin/html-template-syntax'
Bundle 'mattn/emmet-vim'
Bundle 'Shougo/vimproc'
Bundle 'eagletmt/ghcmod-vim'
" Tabs and stuff
Bundle 'vim-airline/vim-airline'
" Buffer kill without losing split window
Bundle 'qpkorr/vim-bufkill'
Bundle 'eagletmt/neco-ghc'
Bundle 'dkprice/vim-easygrep'
" Alternate between .h .c usage -> :A
Bundle 'vim-scripts/a.vim'
" pep8 python indenting
Bundle 'vim-scripts/indentpython.vim'
" Support for C++11 syntax
Bundle 'vim-jp/cpp-vim'
" Support for puppet
Bundle 'rodjek/vim-puppet'
" Support for JavaScript
Bundle 'pangloss/vim-javascript'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'mxw/vim-jsx'
" Support for node
Bundle 'moll/vim-node'
" Support for GoLang
Bundle 'fatih/vim-go'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on     " required!

" Configure syntastic python
let g:syntastic_python_flake8_args="--max-line-length=120"
let g:syntastic_python_pylint_args="--max-line-length=120"
let python_highlight_all=1
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_html_tidy_exec = '/usr/bin/tidy'

"
"" YouCompleteMe options
let g:ycm_register_as_syntastic_checker = 1 "default 1
let g:Show_diagnostics_ui = 1 "default 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleMe/cpp/ycm/.ycm_extra_conf.py'
" NertTree
map <silent> <C-n> :NERDTreeToggle<CR>

" Mediawiki
augroup filetypedetect
au BufNewFile,BufRead *.wiki setf Wikipedia
augroup END

" Highlight search
:set hlsearch

" Set linenumber
:set number

" Status bar
set laststatus=2
set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]

" vim-airline tabs
let g:airline#extensions#tabline#enabled = 1
" buffkill C+space
map <C-b> :BD<cr>

" List buffers and cycle
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Switch window mappings /*{{{*/
nnoremap <A-Up> :normal <c-r>=SwitchWindow('+')<CR><CR>
nnoremap <A-Down> :normal <c-r>=SwitchWindow('-')<CR><CR>
nnoremap <A-Left> :normal <c-r>=SwitchWindow('<')<CR><CR>
nnoremap <A-Right> :normal <c-r>=SwitchWindow('>')<CR><CR>

function! SwitchWindow(dir)
  let this = winnr()
  if '+' == a:dir
    execute "normal \<c-w>k"
    elseif '-' == a:dir
    execute "normal \<c-w>j"
    elseif '>' == a:dir
    execute "normal \<c-w>l"
    elseif '<' == a:dir
    execute "normal \<c-w>h"
  else
    echo "oops. check your ~/.vimrc"
    return ""
  endif
endfunction
" /*}}}*/


set wildmode=longest:full
set wildmenu
set wildignore+=external/boost,*.o,*.obj,*.git,*.pyc

" Python indenting
"set tabstop=4
"set softtabstop=0 expandtab shiftwidth=4 smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set colorcolumn=120
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*js,*.html,*.css match BadWhitespace /\s\+$/
autocmd BufWritePre * %s/\s\+$//e

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

" If you prefer the Omni-Completion tip window to close when a selection is
" " made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


" SCons
au BufNewFile,BufRead SCons* set filetype=scons

set synmaxcol=500

" enable filetype detection, plus loading of filetype plugins
filetype plugin on

set backspace=indent,eol,start

" FN Mappings
" key mappings for YCM
map <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>
" F4 Find current word on file
nnoremap <F4> :let @/.='\\|\<'.expand("<cword>").'\>'<CR>
" Refresh some file edited by external resource
nnoremap <F5> :edit!
" F6 switch windows
map <F6> <C-W>w
" pastemode
nnoremap <F10> :set invpaste paste?<CR>
set pastetoggle=<F10>
set showmode
" emmet C-Y
let g:user_emmet_leader_key='<C-Y>'

set encoding=utf-8
set fileencoding=utf-8
" let g:ycm_server_use_vim_stdout = 1
" let g:ycm_server_log_level = 'debug'
" let g:ycm_server_keep_logfiles = 1

" colored current line and column
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" EasyGrep tools
let g:EasyGrepRecursive = 1
let g:EasyGrepCommand = 1
let g:EasyGrepFilesToExclude = ".git,node_modules,bower_components"

"ctrlP tools
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|bower_components)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Map Copy to clipboard
map <C-c> "+y<CR>

" Emmet only available on html css files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" show hidden files NerdTree
let NERDTreeShowHidden=1
