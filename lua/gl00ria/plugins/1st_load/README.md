
```vim
vim.pack.add
```
Designed to load 'Alphabetically'.
Problems:
- A plugins that depends on other plugin will throw an error if it loaded 1st
- You won't be able to call 'which-key.add' to add a keybind in another file since that file loaded before 'which-key'


Solved by this dir '1st_load', throw any dep or any plugin you want it to load before everything
