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
set hidden                      "Switch buffer without saving
set showtabline=1               "Show tabline only when more than 1

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=","

" Initialize plugin system
call plug#begin()
Plug 'morhetz/gruvbox' "Theme
Plug 'preservim/nerdtree'  "Navigation
Plug 'Yggdroot/indentLine' "Code identation line
Plug 'ctrlpvim/ctrlp.vim' "Navigation
Plug 'rking/ag.vim' "Fuzzy search
Plug 'tomtom/tcomment_vim' "Quick comment
Plug 'benmills/vimux' "tmux interaction
Plug 'christoomey/vim-tmux-navigator' "tmux panel navigation
Plug 'tpope/vim-fugitive' "Git
Plug 'vim-airline/vim-airline' "airline statusline
Plug 'vim-airline/vim-airline-themes'  "airline theme
Plug 'aklt/plantuml-syntax' "plantuml support
Plug 'dense-analysis/ale' "Linting and LSP
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

" ================ Mappgins ======================
nnoremap <Leader>l :ls<CR>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>

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
set wildmode=full
set wildoptions=pum
" set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=**vendor/rails/**
set wildignore+=**vendor/cache/**
set wildignore+=**node_modules**
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
colorscheme gruvbox
" let g:lightline = {
"       \ 'colorscheme': 'gruvbox',
"       \ }
"
highlight Comment cterm=italic

" ================ NERDTree =======================
noremap <C-N> :NERDTreeToggle <cr>
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeWinSize=30

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
" use git for ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
" Use fd for ctrlp.
if executable('fd')
  let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
  let g:ctrlp_use_caching = 0
endif

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'

if stridx(&runtimepath, expand(vimDir)) == -1
  " vimDir is not on runtimepath, add it
  let &runtimepath.=','.vimDir
endif

" ============== ALE ==================
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_open_list = 0
let g:ale_list_window_size = 5
nmap <silent> ]g :lnext<cr>
nmap <silent> [g :lprev<cr>

" Airline 
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 0


" ============== COC ==================
let g:coc_disable_transparent_cursor=1
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set signcolumn=number "Show errors in the line number column

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call CocActionAsync('doHover')<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>do <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif


" ============== jsonc ==================

" https://github.com/microsoft/TypeScript/pull/5450
autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
