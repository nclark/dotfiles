if has("gui_running")
  setlocal balloonexpr=
endif

nmap <Leader>bb irequire 'byebug' ; byebug<CR><Esc>
imap <Leader>bb require 'byebug' ; byebug<CR>
