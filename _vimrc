"Set backgrond colour in gVim
highlight Normal guifg=white guibg=black


"Korean settings
"set encoding=utf-8
"set fileencodings=utf-8,euc-kr
"set langmenu=cp949


"Basic settings
set nu
set tabstop=6
set expandtab
set shiftwidth=6
set smartindent
set cindent
set hlsearch
set fileencodings=utf-8,euc-kr
set fencs=ucs-bom,utf-8,euc-kr
set bs=indent,eol,start
set ruler
set title
set showmatch
set bg=dark
"set guifont=D2Coding:h12:cHANGEUL:qDEFAULT
"set guifont=Fira\ Mono:h12:cANSI:qDEFAULT
"set guifont=D2Coding:h10:cHANGEUL:qDEFAULT
set guifont=Fira\ Mono:h10:cANSI:qDEFAULT
set laststatus=2
set smartcase
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
set t_Co=256        "구문강조 색 변경
set cursorline      "현재 줄 강조

if has("syntax")
 syntax on
endif

"colorscheme jellybeans

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

"F2 = Save file
map <F2> :w!<CR>

"F4 = Remove the highlight
map <F4> :nohl<CR>

"map <C-F7> :! g++ % -o %<.exe<CR>
"map <C-F5> :! .\%<.exe<<CR>
"map <F7> :! g++ % -o %<.exe<CR>
"map <F5> :! %<.exe<<CR>

au FileType python map <F5> : !python3 %


"----------------------------------- FROM THE tmwilliamlin168 (START) -----------------------------------
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

"autocmd filetype cpp nnoremap <F7> :w <bar> !g++ -std=c++14 % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F7> :w <bar> !g++ % -o %:r -W<CR>
autocmd filetype cpp nnoremap <F5> :!./%:r<CR>
"autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $

set nu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
"----------------------------------- FROM THE tmwilliamlin168 (END) -----------------------------------



"------------------------- VUNDLE -------------------------
set nocompatible
"filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
" for vim-airline
let g:airline#extensions#tabline#enabled = 1 " turn on buffer list
let g:airline_theme='hybrid'
set laststatus=2 " turn on bottom bar

Plugin 'vim-airline/vim-airline-themes'

Plugin 'The-NERD-Tree'
" The-NERD-Tree
autocmd BufEnter * lcd %:p:h
autocmd VimEnter * if !argc() | NERDTree | endif
nmap <F3> :NERDTreeToggle<cr>
let NERDTreeShowLineNumbers=1
let g:NERDTreeWinPos = "left"

"Plugin 'terryma/vim-multiple-cursors'
" vim-multiple-cursor
" Default mapping
"let g:multi_cursor_next_key='<C-n>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<Esc>'
"let g:multi_cursor_use_default_mapping=0

Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/ultisnips'				"~.vim/bundle/ultisnips/
Plugin 'honza/vim-snippets'				"~.vim/bundle/vim-snippets/snippets/


Plugin 'Syntastic'					"auto synatic
let g:syntastic_html_tidy_ignore_errors=[
    \'proprietary attribute "ng-',
    \'proprietary attribute "chart-',
    \'proprietary attribute "pdk-'
\]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_java_checkers = ['javac', 'checkstyle']
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_c_checkers = ['clang_check']
let g:syntastic_html_checkers = ['jshint']
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
"let g:syntastic_error_symbol = 'Err '
"let g:syntastic_warning_symbol = 'Wrn '
"let g:syntastic_style_error_symbol = 'Err '
"let g:syntastic_style_warning_symbol = 'Wrn '
let g:syntastic_java_checkstyle_classpath = '~/checkstyle-7.6-all.jar'
let g:syntastic_java_checkstyle_conf_file = '~/sun_checks.xml'
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

Plugin 'scrooloose/nerdcommenter'			"auto comment form
"Plugin 'MultipleSearch'
Plugin 'mtth/scratch.vim'				"temp notepad
Plugin 'jiangmiao/auto-pairs'
Plugin 'VisIncr'
Plugin 'tpope/vim-abolish'
Plugin 'xuhdev/SingleCompile'
Plugin 'Yggdroot/indentLine'
Plugin 'mhinz/vim-signify'
Plugin 'plasticboy/vim-markdown'
Plugin 'tommcdo/vim-lion'				"command: gl

"Plugin 'KabbAmine/vCoolor.vim'
"let g:vcoolor_map = ''
"let g:vcool_ins_rgb_map = 'r'       " Insert rgb color.
"let g:vcool_ins_hsl_map = 'h'       " Insert hsl color.
"let g:vcool_ins_rgba_map = 'a'      " Insert rgba color.

Plugin 'blueyed/vim-diminactive'
let g:diminactive_enable_focus = 1

Plugin 'vim-scripts/DrawIt'
Plugin 'bad-whitespace'
Plugin 'manicmaniac/betterga'
Plugin 'chrisbra/unicode.vim'
Plugin 'will133/vim-dirdiff'

"Plugin 'sjl/gundo.vim'
"nnoremap u :GundoToggle

"Plugin 'haya14busa/incsearch.vim'
"map /  (incsearch-forward)
"map '  (incsearch-backward)
"map g/ (incsearch-stay)
"set hlsearch
"let g:incsearch#auto_nohlsearch = 1
"map N  (incsearch-nohl-N)
"map *  (incsearch-nohl-*)
"map #  (incsearch-nohl-#)
"map g* (incsearch-nohl-g*)
"map g# (incsearch-nohl-g#)
"function! s:config_easyfuzzymotion(...) abort
"return extend(copy({
""\   'converters': [incsearch#config#fuzzy#converter()],
""\   'modules': [incsearch#config#easymotion#module()],
"\   'keymap': {"\": '(easymotion)'},
""\   'is_expr': 0,
""\   'is_stay': 1
""\ }), get(a:, 1, {}))
"endfunction
"noremap  z/ incsearch#go(config_easyfuzzymotion())

Plugin 'Quramy/vim-js-pretty-template'
Plugin 'jason0x43/vim-js-indent'
Plugin 'othree/yajs.vim'


"---------------- Update ----------------
"Plugin 'bling/vim-airline'
"Plugin 'edkolev/promptline.vim'
"Plugin 'surround.vim'
"Plugin 'vcscommand.vim'
"Plugin 'textobj-user'
"Plugin 'mattn/vim-textobj-url'
"Plugin 'textobj-entire'
"Plugin 'textobj-line'
"Plugin 'vim-indent-object'
"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'iwataka/ctrlproj.vim'
"Plugin 'Quich-Filter'
"Plugin 'batch.vim'
"Plugin 'LustyExplorer'
"Plugin 'LustyJuggler'
"Plugin 'majutsushi/tagbar'
"Plugin 'LeafCage/yankround.vim'
"Plugin 'vim-jp/vital.vim'
"Plugin 'chrisbra/csv.vim'
"Plugin 'terryma/vim-expand-region'

"Plugin 'peterrincker/vim-argumentative'
"nmap [; Argumentative_Prev
"nmap ]; Argumentative_Next
"xmap [; Argumentative_XPrev
"xmap ]; Argumentative_XNext
"nmap <; Argumentative_MoveLeft
"nmap >; Argumentative_MoveRight
"xmap i; Argumentative_InnerTextObject
"xmap a; Argumentative_OuterTextObject
"omap i; Argumentative_OpPendingInnerTextObject
"omap a; Argumentative_OpPendingOuterTextObject

"Plugin 'tpope/vim-fugitive'
"Plugin 'gregsexton/gitv'
"Plugin 'dyng/ctrlsf.vim'

"Plugin 'thoughtbot/pick.vim'
"let g:pick_height = 50

"Plugin 'Valloric/YouCompleteMe'
"let g:ycm_server_python_interpreter = '/usr/bin/python'
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
"let g:ycm_key_list_select_completion = ['', '']
"let g:ycm_key_list_previous_completion = ['', '']
"let g:SuperTabDefaultCompletionType = ''
"let g:ycm_autoclose_preview_window_after_completion=1
"map g :YcmCompleter GoToDefinitionElseDeclaration
"let g:ycm_semantic_triggers =  {
"\   'c' : ['->', '.'],
"\   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
"\             're!\[.*\]\s'],
"\   'ocaml' : ['.', '#'],
"\   'cpp,objcpp' : ['->', '.', '::'],
"\   'perl' : ['->'],
"\   'php' : ['->', '::'],
"\   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
"\   'ruby' : ['.', '::'],
"\   'lua' : ['.', ':'],
"\   'erlang' : [':'],
"\ }

"Plugin 'pangloss/vim-javascript'
"let g:javascript_plugin_jsdoc = 1
"set conceallevel=1
"set concealcursor=""
"autocmd FileType javascript inoremap   @ =syntax_expand#expand("@", "this")
"autocmd FileType javascript inoremap   # =syntax_expand#expand("#", ".prototype.")
"autocmd FileType javascript inoremap   < =syntax_expand#expand_head("<", "return")
"let g:javascript_conceal_function  = "'"
"let g:javascript_conceal_prototype = "#"
"let g:javascript_conceal_return    = "<"
"let g:javascript_conceal_static    = "'"
"let g:javascript_conceal_super     = "'"
"let g:javascript_conceal_this      = "@"
"let g:javascript_conceal_undefined = "'"
"let g:javascript_conceal_null      = "'"
"map l :exec &conceallevel ' "set conceallevel=0" : "set conceallev

Plugin 'Olical/vim-syntax-expand'

"Plugin 'mvolkmann/vim-js-arrow-function'
"nmap ar :JsAnonFnToArrowFn
"nmap aR :call JsArrowFnBraceToggle()

"Plugin 'w0ng/vim-hybrid'

"Plugin 'terryma/vim-smooth-scroll'
" vim-smooth-scroll
"noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 10, 5)<CR>
"noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 10, 5)<CR>
"noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 10, 3)<CR>
"noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 10, 3)<CR>





" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic"
let g:syntastic_c_compiler_options = "-std=c11 -Wall -Wextra -Wpedantic"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
"let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips']
"let g:UltiSnipsSnippetDirectories = ['UltiSnips']

Plugin 'davidhalter/jedi-vim'   " python 자동완성 Plugin
let g:jedi#show_call_signatures=0       " 자세히 설명하는 창을 보여준다 1=활성화, 0=비>활성화
let g:jedi#popup_select_first="0"   " 자동완성시 자동팝업 등장 x
let g:jedi#force_py_version=3     " 자동완성 3 = python3 , 2 = python2

Plugin 'hynek/vim-python-pep8-indent'   " python 자동 들여쓰기 Plugin
filetype plugin indent on               " python 자동 들여쓰기 on

Plugin 'nvie/vim-flake8'                " python 문법 검사 plugin
" let g:syntastic_python_checkers=['flake8']        " ↓ 실행시 현재줄 주석
" let g:syntastic_python_flake8_args='--ignore='    " 무시하고자 하는


Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'airblade/vim-gitgutter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'nanotech/jellybeans.vim'




call vundle#end()

"NERDTree ON 단축키를 "\nt"로 설정
map <Leader>nt <ESC>:NERDTree<CR>
let NERDTreeShowHidden=1
" let NERDTreeQuitOnOpen=1
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|vendor$',
    \ 'file': '\v\.(exe|so|dll)$'
\ }
color jellybeans
" Tag List 환경설정
filetype on                                 "vim filetype on
"Source Explorer 환경설정
nmap <F8> :SrcExplToggle<CR>                "F8 Key = SrcExpl Toggling
nmap <C-H> <C-W>h                           "왼쪽 창으로 이동
nmap <C-J> <C-W>j                           "아래 창으로 이동
nmap <C-K> <C-W>k                           "윗 창으로 이동
nmap <C-L> <C-W>l                           "오른쪽 창으로 이동

" Markdown 문법 설정 (Git 에서 사용)
augroup markdown
    " remove previous autocmds
    autocmd!
    " set every new or read *.md buffer to use the markdown filetype
    autocmd BufRead,BufNew *.md setf markdown
augroup END


filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


