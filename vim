set autoindent                    "Preserve current indent on new lines
set textwidth=78                  "Wrap at this column
set backspace=indent,eol,start    "Make backspaces delete sensibly
 
set tabstop=3                     "Indentation levels every three columns
set expandtab                     "Convert all tabs typed to spaces
set shiftwidth=3                  "Indent/outdent by three columns
set shiftround                    "Indent/outdent to nearest tabstop
 
set matchpairs+=<:>               "Allow % to bounce between angles too

set iskeyword+=:                  "Perl double colons are valid part of
                                  "identifiers.

set lines=40
set columns=85
set number

set statusline=%<%f%h%m%r%=%{&ff}\ %l,%c%V\ %P

filetype plugin on

"reread .vimrc file after editing
autocmd BufWritePost $HOME/.vimrc source $HOME/.vimrc

" use visual bell instead of beeping
set vb

" incremental search
set incsearch

" syntax highlighting
set bg=light
syntax on

" autoindent
autocmd FileType perl set autoindent|set smartindent

" show matching brackets
autocmd FileType perl set showmatch

" check perl code with :make
"autocmd FileType perl set makeprg=perl\ -c\ %\ $*
"autocmd FileType perl set errorformat=%f:%l:%m
"autocmd FileType perl set autowrite

" dont use Q for Ex mode
map Q :q

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F11>

" Tlist Config
nnoremap <silent> <F8> :TlistToggle<CR>

" perltidy mappings
map <F2> <ESC>:%! perltidy<CR>
map <F3> <ESC>:'<,'>! perltidy<CR>

" Perl test files as Perl code
au BufRead,BufNewFile *.t set ft=perl

“perl-support plugin info
let g:Perl_AuthorName   = ''
let g:Perl_AutherRef    = ''
let g:Perl_Email        = ''



Example .perltidyrc file:

-l=78   # Max line width is 78 cols
-i=3    # Indent level is 4 cols
-ci=3   # Continuation indent is 4 cols
-st     # Output to STDOUT
-se     # Errors to STDERR
-vt=2   # Maximal vertical tightness
-cti=0  # No extra indentation for closing brackets
-pt=1   # Medium parenthesis tightness
-bt=1   # Medium brace tightness
-sbt=1  # Medium square bracket tightness
-bbt=1  # Medium block brace tightness
-nsfs   # No space before semicolons
-nolq   # Don't outdent long quoted strings
-wbb="% + - * / x != == >= <= =~ !~ < > | & >= < = **= += *= &= <<= &&= -= /= |= >>= ||= .= %= ^= x="   

PerlTidy usually does a good job, but sometimes it's a little too strict. 
Use your best judgment in accordance with the dog book. Try for beautiful, sexy code. 



if ( $foo ) {
   print "ok\n";
}
else {
   print "ok\n";
}

$foo = $val == 1 ? 'RED'
     : $val == 2 ? 'BLUE'
     :             'GREEN';

$query =~ s{
   (\bIN\s*\()    # The opening of an IN list
   ([^\)]+)       # Contents of the list, assuming no item contains paren
   (?=\))         # Close of the list
}
{
   $1 . __shorten($2)
}gexsi;

















一、多行
dd
删除一行
ndd
删除以当前行开始的n行
dw
删除以当前字符开始的一个字符
ndw
删除以当前字符开始的n个字符
d$、D
删除以当前字符开始的一行字符
d)
删除到下一句的开始
d}
删除到下一段的开始
d回车
删除2行
二、复制多行
任务：将第9行至第15行的数据，复制到第16行
方法1：（强烈推荐）
：9，15 copy 16 或 ：9，15 co 16
由此可有：
：9，15 move 16 或 :9,15 m 16 将第9行到第15行的文本内容到第16行的后面

方法2：
光标移动到结束行，ma
光标移动到起始行,输入y’a
光标移动到需要复制的行，输入p,行前复制则输入大写P

方法3：
把光标移到第9行 shift + v
再把光标移动到第15行 ctrl + c
再把光标死去到第16行 p mysql

方法4：
光标移动到起始行，输入ma
光标移动到结束行，输入mb
光标移动到粘贴行，输入mc
然后输入:’a,’b, co ‘c 把co换成m就是剪切
若要删除多行，则输入：’a,’b de

vi设置自动缩进：set smartindent
vi设置显示行号：set number 或 set nu
linux
