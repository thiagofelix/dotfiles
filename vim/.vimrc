" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" ========================================
" Vim plugin configuration
" ========================================
"
" This file contains the list of plugin installed using vundle plugin manager.
" Once you've updated the list of plugin, you can run vundle update by issuing
" the command :BundleInstall from within vim or directly invoking it from the
" command line with the following syntax:
" vim --noplugin -u vim/vundles.vim -N "+set hidden" "+syntax on" +BundleClean! +BundleInstall +qall
" Filetype off is required by vundle
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'groenewege/vim-less'
Plugin 'Yggdroot/indentLine'
Plugin 'crosbymichael/vim-cfmt'
Plugin 'cespare/vim-toml'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'moll/vim-bbye'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'chriskempson/base16-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'janko-m/vim-test'
Plugin 'benmills/vimux'
Plugin 'christoomey/vim-tmux-navigator'

" let Vundle manage Vundle (required)
Bundle "gmarik/vundle"

" All of your Plugins must be added before the following line
call vundle#end()

"Filetype plugin indent on is required by vundle
filetype plugin indent on

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=12       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=**vendor/rails/**
set wildignore+=**vendor/cache/**
set wildignore+=**node_modules/**
set wildignore+=**tmp/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Theming =======================

let g:lightline = {
      \ 'colorscheme': '16color',
      \ }

" ================ KeyMapping =======================

noremap <C-N> :NERDTreeToggle <cr> " Ctrl+N Open/Close NERDTree

" ================ AutoCMD =======================
" autocmd BufEnter * EnableStripWhitespaceOnSave


" Shortcuts/Remaps
inoremap jj <Esc>

" misc
let g:NERDTreeWinSize=40
let g:ctrlp_show_hidden = 1

" vim-test
" make test commands execute using dispatch.vim
let test#strategy = "vimux"
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" vimux
function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction

" Open Prompt for a command to run
nmap <Leader>vo :call VimuxOpenRunner()<CR>

" Prompt for a command to run
nmap <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
nmap <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
nmap <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
nmap <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
nmap <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
nmap <Leader>vz :call VimuxZoomRunner()<CR>

" If text is selected, save it in the v buffer and send that buffer it to tmux
map <Leader>vs "vy :call VimuxSlime()<CR>

" Shortcut to open current file in new tab
nmap <leader>tt :tabnew %<cr>
au TabLeave * let g:lasttab = tabpagenr()
" Return to last tab - tr - tab return
nmap <silent> <leader>tr :exe "tabn ".g:lasttab<cr>
vmap <silent> <leader>tr :exe "tabn ".g:lasttab<cr>
