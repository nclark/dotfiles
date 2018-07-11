if system("elixir --version|tail -1") =~ "1.6.5"
  autocmd BufWritePost *.exs silent call RunElixirFormatter()
  autocmd BufWritePost *.ex silent call RunElixirFormatter()

  function RunElixirFormatter()
    :!mix format %
    :e
  endfunction
endif
