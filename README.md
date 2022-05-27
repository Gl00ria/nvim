# [Neovim](https://neovim.io/) configuration using "lua".


# Take a Peek
![ 1 ](https://github.com/Gl00ria/nvim/blob/main/screenshots/1.png)
![ 3 ](https://github.com/Gl00ria/nvim/blob/main/screenshots/3.png)

[More here](https://github.com/Gl00ria/nvim/tree/main/screenshots).


# Requirements
- [Neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) >= 0.6, ain't that obvious?
- Neovim python support `$ pip install pynvim`
- Neovim node support `$ npm i -g neovim`
- [Nerd font](https://github.com/ryanoasis/nerd-fonts).
- [Codicon](https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf).
- [ripgrep](https://github.com/BurntSushi/ripgrep).
- Fuzzy finders: [FZF](https://github.com/junegunn/fzf) or [FZY](https://github.com/jhawthorn/fzy).

#### Optional
- [Lazygit](https://github.com/jesseduffield/lazygit).
- [Emoji font](https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf).

#### Notes:
- [Node](https://nodejs.org/en/download/) >= 12 is required for [Github Copilot](https://github.com/github/copilot.vim).
- For the last SS's  requirements [see](https://github.com/kevinhwang91/rnvimr).


# Installation
### Mac & Linux
- open your terminal & copy/paste...
```
# Backup your things...
$ mv ~/.config/nvim ~/.config/nvim_bak 

# Have fun!
$ git clone https://github.com/Gl00ria/nvim.git ~/.config/nvim
```
### Windows
- open PowerShell & copy/paste...
```
# Backup your things...
$ mv C:\Users\USER_NAME\AppData\Local\nvim\ C:\Users\USER_NAME\AppData\Local\nvim_bak 

# Remove old cache and config
$ rmdir -Recurse -Force $env:LOCALAPPDATA\nvim 
$ rmdir -Recurse -Force $env:LOCALAPPDATA\nvim-data

# Have fun!
$ git clone https://github.com/Gl00ria/nvim.git "$env:LOCALAPPDATA\nvim"
```
#### Notes:
- Windows users MUST have a C compiler to compile the parsers needed for nvim-treesitter [see](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support) for more info.

# Now What?
- Run `nvim` and wait...wait more... takes less than a minute to finish anyway.
- To fix Copy/paste issues install `xsel` using your fav package manager.
- Experiencing problems? :open_mouth: okay check your health `$ nvim -c checkhealth`

# How to?
### Nvim-treesitter:
- [Treesitter](https://github.com/neovim/nvim-lspconfig) is a parser generator tool, to use run `:TSInstall <parser>`, use ``Tab`` to list available parsers.

#### Examples:
      :TSInstall vim
      :TSInstall bash
      :TSInstall python
      :TSInstall c


### Language-Server Protocol "LSP":
- To levarage [LSP](https://github.com/neovim/nvim-lspconfig) auto-completions and other functionalitis, run `:LspInstall <server>`, use ``Tab`` to list available servers.

#### Examples:
      :LspInstall vimls
      :LspInstall bashls
      :LspInstall pyright
      :LspInstall clangd
- Find more [here](https://github.com/williamboman/nvim-lsp-installer#available-lsps)


### Keybindings/Keymaps or keyWhatever:
We love plugins, plugins love to have one or more keymap, but our fingers keep forgetting where to go! ...Soo...?
here how it goes to satisfy both the plugins & our fingers, press `<leader>cc` to trigger the command center, pretty C00L HuH?

NOTE: `<leader>cc` = `<space>cc`, I know you know but maybe they don't know.


# Java debugging & testing
#### Debugging:
```
$ git clone git@github.com:microsoft/java-debug.git
$ cd java-debug/
$ ./mvnw clean install
```
#### Testing:
```
$ git clone git@github.com:microsoft/vscode-java-test.git
$ cd vscode-java-test
$ npm install
$ npm run build-plugin
```

## Want to hack Neovim? ETHICALLY ofc!.... here some helpful resources
- [Neovim's doc](https://neovim.io/doc/general/), always hug the documentations.
- [@ThePrimeagen](https://www.youtube.com/c/ThePrimeagen), because WHY NOT?
- [@LunarVim](https://github.com/LunarVim/LunarVim), convinced me to migrate to Lua.
- [@ChristianChiarulli](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ), for the Blueprint.

> Big Thanks to the creator of Neovim and The Vim && Neovim Community for 
this extensible and hackable text editor.
