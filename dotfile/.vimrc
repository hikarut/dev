"改行コードをLF(UNIX)にする
set notextmode
"文字コードを指定
set encoding=utf-8
"ファイルに出力する文字コードを指定
set fileencoding=utf8
set fileencodings=ucs-bom
"自動でインデント
set autoindent
"行番号を表示
set number
"バックスペースを有効にする
set backspace=indent,eol,start
set expandtab
"タブ幅を４文字にする
set tabstop=4
"cindentやautoindent時に挿入されるタブの幅（tabstop と揃えておくと良い）
set shiftwidth=4
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=4
" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap
"タイトルをウインドウ枠に表示する
set title
set whichwrap=b,s,h,l,<,>,[,]
set smartindent
"ルーラー
set ruler
" 検索結果文字列のハイライトを有効にする
set hlsearch
" 最後まで検索したら先頭へ戻る
set wrapscan
" 入力中のコマンドを表示
set showcmd
" スワップファイル作らない
set noswapfile
" コマンドラインの高さを2行に
" set cmdheight=2

" ビープ音を鳴らさない
set vb t_vb=

"マウスを有効にする
"if has('mouse')
"  set mouse=a
"endif

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" ハイライト
if &t_Co > 2 || has("gui_running")
    " シンタックスハイライトを有効にする
    syntax on
endif

"常にステータスラインを表示する
set laststatus=2
"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"閉じ括弧が入力されたとき、対応する括弧を表示
set showmatch
"カーソルがある画面上の行を強調する
"set cursorline

hi StatusLine gui=NONE guifg=Black guibg=Green cterm=NONE ctermfg=White ctermbg=Black    " アクティブなステータスライン
hi StatusLineNC gui=NONE guifg=Black guibg=Green cterm=NONE ctermfg=White ctermbg=White  " 非アクティブなステータスライン


"挿入モード時、ステータスラインの色を変更
"let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=black gui=none ctermfg=blue ctermbg=yellow cterm=none'
let g:hi_insert = 'highlight StatusLine guifg=red guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"let g:hi_insert = 'highlight statusline term=NONE cterm=NONE guifg=red ctermfg=yellow ctermbg=red'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR>

" 前回終了したカーソル行に移動 {{{2
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif


" neobundle
" Vi互換をオフ（Vimの機能を使えるようにする）
"set nocompatible               " Be iMproved

"if has('vim_starting')
"set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif

"call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
"NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
"NeoBundle 'Shougo/vimproc'

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" vim-scripts repos
"NeoBundle 'L9'
"NeoBundle 'FuzzyFinder'
"NeoBundle 'rails.vim'

" Non github repos
"NeoBundle 'git://git.wincent.com/command-t.git'

" Non git repos
"NeoBundle 'http://svn.macports.org/repository/macports/contrib/mpvim/'
"NeoBundle 'Lokaltog/vim-powerline'

"NeoBundle 'git://github.com/Shougo/vimshell.git'
"NeoBundle 'git://github.com/thinca/vim-quickrun.git'
"NeoBundle 'git://github.com/mattn/zencoding-vim.git'
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neosnippet'

" その他 {{{
"NeoBundle 'Shougo/vimproc', {
"      \ 'build' : {
"      \     'mac' : 'make -f make_mac.mak',
"      \     'unix' : 'make -f make_unix.mak',
"      \    },
"      \ }
"NeoBundleLazy 'taichouchou2/vim-endwise.git', {
"      \ 'autoload' : {
"      \   'insert' : 1,
"      \ } }
" }}}

" 補完 {{{
"NeoBundleLazy 'Shougo/neocomplcache', {
"      \ 'autoload' : {
"      \   'insert' : 1,
"      \ }}
"NeoBundleLazy 'Shougo/neosnippet', {
"      \ 'autoload' : {
"      \   'insert' : 1,
"      \ }}

"NeoBundle 'Shougo/neocomplcache-rsense', {
"      \ 'depends': 'Shougo/neocomplcache',
"      \ 'autoload': { 'filetypes': 'ruby' }}
"NeoBundleLazy 'taichouchou2/rsense-0.3', {
"      \ 'build' : {
"      \    'mac': 'ruby etc/config.rb > ~/.rsense',
"      \    'unix': 'ruby etc/config.rb > ~/.rsense',
"      \ } }
" }}}

" ...

"filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
"NeoBundleCheck
