" !important (ctrl-x ctrl-o) tags dir
if has("win32") || has("win64")
  map! <buffer> <F5> <ESC>:update<CR>:!ruby<Space>-Eutf-8<Space>"%"<Space>2>&1<Bar>iconv<Space>-f<Space>utf-8//ignore<Space>-t<Space>gbk//ignore<CR>
  nmap <buffer> <F5> :update<CR>:!ruby<Space>-Eutf-8<Space>"%"<Space>2>&1<Bar>iconv<Space>-f<Space>utf-8//ignore<Space>-t<Space>gbk//ignore<CR>
else
  map! <buffer> <F5> <ESC>:update<CR>:!ruby<Space>"%"
  nmap <buffer> <F5> :update<CR>:!ruby<Space>"%"
endif

set expandtab
set ts=2
set shiftwidth=2 softtabstop=2  " indent 2 spaces
set sta
