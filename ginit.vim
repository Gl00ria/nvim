" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont DejaVu Sans Mono:h18
else
    set guifont=DejaVu\ Sans\ Mono:h18
endif

" Tabline
if exists(':GuiTabline')
    GuiTabline 1
endif

" GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

" ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv

nmap <leader>ke :set norightleft <cr>
nmap <leader>ka :set rightleft <cr>
