"Set Vim's starting directory to there
cd C:\Users\Administrator

"Set backgrond colour in gVim
highlight Normal guifg=white guibg=black


"Korean settings
"set encoding=utf-8
"set fileencodings=utf-8,euc-kr
"set langmenu=cp949


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
"set guifont=나눔고딕코딩:h12:cHANGEUL:qDEFAULT
"set guifont=Consolas:h12:cANSI:qDEFAULT
set guifont=나눔고딕코딩:h10:cHANGEUL:qDEFAULT
set guifont=Fira\ Mono:h10:cANSI:qDEFAULT
set laststatus=2
set smartcase
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

"syntax on
if has("syntax")
 syntax on
endif

"colorscheme jellybeans

au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

map <F2> :w!<CR>
"map <C-F7> :! g++ % -o %<.exe<CR>
"map <C-F5> :! .\%<.exe<<CR>
"map <F7> :! g++ % -o %<.exe<CR>
"map <F5> :! %<.exe<<CR>



"----------------------------------- FROM THE tmwilliamlin168 -----------------------------------
inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

autocmd filetype cpp nnoremap <F7> :w <bar> !g++ -std=c++14 % -o %:r -Wl,--stack,268435456<CR>
autocmd filetype cpp nnoremap <F5> :!%:r<CR>
autocmd filetype cpp nnoremap <C-C> :s/^\(\s*\)/\1\/\/<CR> :s/^\(\s*\)\/\/\/\//\1<CR> $

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



"------------------------- VUNDLE -------------------------
