vim.cmd [[

 au BufRead,BufNewFile tsconfig.json set filetype=jsonc

 au BufRead,BufNewFile *.bicep set filetype=bicep

 au BufRead,BufNewFile *.fish set filetype=fish

 au BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

 au BufRead,BufNewFile *.jl set filetype=julia

 au BufRead,BufNewFile *.nix set filetype=nix

 au BufRead,BufNewFile *.tex set filetype=tex

 au BufRead,BufNewFile *.sol set filetype=solidity

 au BufRead,BufNewFile *.zig set filetype=zig
 
 au BufRead,BufNewFile *.zir set filetype=zir

]]
