" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set background=dark

" ================ General Config ====================
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'tomtom/tcomment_vim'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'itchyny/lightline.vim'
Plug 'aklt/plantuml-syntax'

" Initialize plugin system
call plug#end()

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
set wildignore+=**/node_modules/**

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
colorscheme gruvbox
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

highlight Comment cterm=italic

" ================ KeyMapping =======================
noremap <C-N> :NERDTreeToggle <cr> " Ctrl+N Open/Close NERDTree

" misc
let g:NERDTreeWinSize=40
let g:ctrlp_show_hidden = 1

" ================ vimux =======================
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


" ============== ctrlp config ==================
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" Use fd for ctrlp.
if executable('fd')
    let g:ctrlp_user_command = 'fd -HI -c never "" "%s"'
    let g:ctrlp_use_caching = 0
endif

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
