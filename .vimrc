set nocompatible               " be iMproved

set winwidth=79
set winheight=999
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=40
"set winminheight=5

" Settings stolen from Gary Bernhardt
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" If a file is changed outside of vim, automatically reload it without asking
set autoread
" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable
" Fix slow O inserts
:set timeout timeoutlen=1000 ttimeoutlen=100
" Don't make backups at all
set nobackup
set nowritebackup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" 1 tab to 2 space for ruby
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" number line show
set nu

set noswapfile
"in order to switch between buffers with unsaved change
set hidden

" hightlight column and line
set cursorline
"set cursorcolumn
filetype plugin indent on
syntax on

" support css word with -
autocmd FileType css,scss,slim,html,eruby,coffee,javascript setlocal iskeyword+=-
autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4

" vim 7.4 backspace fix
set backspace=indent,eol,start
set t_Co=256
" colorscheme, read here: http://vim.wikia.com/wiki/Change_the_color_scheme
" colorscheme solo_dark
autocmd BufWritePre * :%s/\s\+$//e

:command NE NERDTree
:command NF NERDTreeFind
":command RC RuboCop

" Show Bookmarks by default
let NERDTreeShowBookmarks=1
" Auto open nerdtree in vim
autocmd VimEnter * NERDTree
" Open developmen bookmark
autocmd VimEnter * OpenBookmark dev
" Set focus to primary window
autocmd VimEnter * wincmd l
" Find current file in nerdtree
autocmd VimEnter * NERDTreeFind
" Set focus to primary window
autocmd VimEnter * wincmd l

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Status-Line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Linting
Plugin 'ngmy/vim-rubocop'
Plugin 'w0rp/ale'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-h> :ALEFix<CR>
nmap <silent> <C-l> :ALEToggle<CR>
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}
" Auto-fixes lint errors on save
let g:ale_fix_on_save = 0
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
" Ignore the following lint issues
let b:ale_warn_about_frozen_string_literal = 0

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Searching with Silver Searcher
Plugin 'rking/ag.vim'
" Custom function for runnign AG while ignoring specs and tags
function! s:AgIgnore(myParam)
  execute ":Ag " a:myParam " --ignore spec --ignore tags"
endfunction
command! -nargs=1 AG call s:AgIgnore(<f-args>)
map <C-f> :AG <C-R><C-W><CR>

Plugin 'tpope/vim-projectionist'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
" power vim plugin for rails
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rbenv'
Plugin 'tpope/vim-bundler'
" ruby command for rvm
Plugin 'tpope/vim-rvm'

" gitgutter -- shows differences in git in the left column
Plugin 'airblade/vim-gitgutter'

Plugin 'majutsushi/tagbar'
let g:tagbar_ctags_bin='/usr/local/bin/ctags'

"nnoremap <C-[> :execute "horizontal ptag " . expand("<cword>")<CR>
"nnoremap <C-\> :execute "vertical ptag " . expand("<cword>")<CR>
map <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

if has("gui_running")
  colorscheme desert
  set bs=2
  set ruler
  set gfn=Monaco:h16
  set shell=/bin/bash
endif

let mapleader= ","
" EasyMotion_leader_key .
" Plugin Plugin here for Ruby on Rails
" git
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

Plugin 'benmills/vimux'
" auto run tests plugin
Plugin 'janko-m/vim-test'
nmap <Leader>n :TestNearest<CR>
nmap <Leader>f :TestFile<CR>
nmap <Leader>s :TestSuite<CR>
nmap <Leader>l :TestLast<CR>
nmap <Leader>g :TestVisit<CR>

" quickly move cursor, try ,,w
"Plugin 'Lokaltog/vim-easymotion'
" quickly write HTML, just like zencoding but simple engough
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"let g:sparkupNextMapping= "<c-m>"
Plugin 'mattn/emmet-vim'
let g:user_emmet_install_global = 0
let g:user_emmet_mode='iv'
autocmd FileType html,css,eruby EmmetInstall

" vim rails syntax complete, try ctrl+x ctrl+u
set completefunc=syntaxcomplete#Complete
" quickly comment your code, try ,cc on selected line
Plugin 'vim-scripts/The-NERD-Commenter'
" indent guides
let g:indent_guides_guide_size = 1
Plugin 'nathanaelkane/vim-indent-guides'
" indent guides shortcut
map <silent><F7>  <leader>ig

" markdown support
let g:indent_guides_guide_size = 1
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" file tree like something called IDE
Plugin 'scrooloose/nerdtree'
map <silent><F8> :NERDTree<CR>
map <leader>r :NERDTreeFind<cr>
map <leader>e :NERDTreeToggle<cr>
map <leader>y "+y<cr>
map <leader>p "+p<cr>
" coffeescript
Plugin 'kchmck/vim-coffee-script'
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
" basic dependence
Plugin 'L9'
" slim template support
Plugin 'slim-template/vim-slim.git'
" hack filetype for slim
autocmd BufNewFile,BufRead *.slim set filetype=slim
autocmd BufNewFile,BufRead *.es6 set filetype=javascript

" Ctrlp and using the Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" quickly search file(s), use ctrl+p, F5 refresh
Plugin 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = '\v[\/]\.(DS_Store|git|hg|svn)|(optimized|compiled|node_modules|bower_compenents)$'
let g:ctrlp_max_files=0

" automcomplete
Plugin 'ajh17/VimCompletesMe'
" tag manager
Plugin 'ludovicchabant/vim-gutentags'

" sass highlight
Plugin 'JulesWang/css.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'isRuslan/vim-es6'

call vundle#end()
