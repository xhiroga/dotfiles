" 作者:
"	@xhiroga


""""""一般""""""
set history=500
"set autoread

"ex mode遷移を無効化
nnoremap Q <Nop>

command! Q q!
command! BD bd!

command! R source ~/vimrc/.vimrc

""""""表示""""""
syntax on
set number
set ruler
set cmdheight=2

set display=lastline "長い行を行末まで表示
set pumheight=10 "補完候補の表示の高さ上限
set statusline=%F "ステータスラインにファイル名


""""""ファイル関連""""""
set clipboard+=unnamed
set encoding=utf-8 "バッファ
set fileencoding=utf-8 "書き込み時


""""""テキスト関連""""""
set autoindent
set smartindent
set wrap

" \tと行末を表示 # Winのgvimでは無効化すること.
set list
set listchars=tab:»･,trail:･,eol:↲,extends:»,precedes:«,nbsp:%

" \tの表示幅, インデントの幅, タブを空白何文字にするか
set tabstop=4
set softtabstop=0
set shiftwidth=4

" ファイルタイプによってインデントを変える
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END


""""""バッファ・ウィンドウ関連""""""
" 未保存でもバッファ切替可能
set hidden

nnoremap <S-Tab> :bprevious<CR>
nnoremap <Tab> :bnext<CR>


""""""検索""""""
set incsearch
map <space> /
map <S-space> ?
map <C-space> *


""""""移動""""""
set nocompatible "vi互換を無効化(=INSERT中にカーソルを有効化) brew install に伴って設定
set backspace=indent,eol,start "削除対象=インデント、改行およびINSERT開始位置より手前の文字 brew install に伴って設定
set whichwrap=b,s,h,l,<,>,~,[,]
" 見かけの桁を移動
noremap j gj
noremap k gk
noremap OB gj
noremap OA gk
" 行頭行末: Command + ←↓↑→
noremap <C-h> ^
noremap <C-j> G
noremap <C-k> gg
noremap <C-l> $
" 単語/段落ごとの移動: Alt + ←↓↑→
noremap ˙ b
noremap ∆ }
noremap ˚ {
noremap ¬ w
noremap ∂ dw
noremap ç cw
noremap <A-h> b
noremap <A-j> }
noremap <A-k> {
noremap <A-l> w
noremap <A-d> dw
noremap <A-c> cw
noremap b b
noremap f w
" その他
noremap <S-p> %
noremap Y y$

""""""Nomal mode""""""
noremap <ESC><ESC> :noh<CR>
nnoremap + <C-a>
nnoremap - <C-x>


""""""Visual mode""""""


""""""Insert mode""""""
set autoindent
set showmatch "対応するかっこに一瞬カーソルを飛ばす
set matchtime=1 "↑を0.1秒にする
set smartindent

""""""Meta""""""
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
