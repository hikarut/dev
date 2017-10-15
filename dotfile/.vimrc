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

set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

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

" ペースト時にインデントをずらさない
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" NeoBundle
if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    " NeoBundleが未インストールであればgit cloneする
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))
" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
"NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する

" カラースキームmolokai
"NeoBundle 'tomasr/molokai'
" ステータスラインの表示内容強化
"NeoBundle 'itchyny/lightline.vim'

"Goをvimで使うよう
" https://github.com/fatih/vim-go
NeoBundle 'fatih/vim-go'

if has('lua') " lua機能が有効になっている場合・・・・・・①
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle "Shougo/neosnippet"
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif
"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

"----------------------------------------------------------
call neobundle#end()
" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on
" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck
