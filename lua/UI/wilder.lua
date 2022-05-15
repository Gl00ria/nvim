vim.cmd [[

" activate modes
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<tab>',
      \ 'previous_key': '<s-tab>',
      \ 'accept_key': '<down>',
      \ })


call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'pumblend': 20,
      \ 'highlighter': wilder#basic_highlighter(),
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

]]
