# PROJECT KNOWLEDGE BASE

**Updated:** 2026-07-06
**Branch:** main

## OVERVIEW
Personal Neovim PDE config. Lua-first, 83 active `.lua` files, ~4.4k LOC. Uses `vim.pack` (Neovim's built-in packer, since 0.10) — no third-party plugin managers.

`lua/pack.lua` is a **post-install hook** (not a plugin) that runs build commands after `PackChanged` events for telescope-fzf-native, LuaSnip, and nvim-treesitter.

## STRUCTURE
```
nvim/
├── init.lua                 # Entry: ui2 → options → keymaps → pack setup → autocmd → plugins
├── lua/
│   ├── pack.lua             # Post-install hooks (PackChanged autocmd)
│   ├── plugins.lua          # Recursive scanner: 6 category dirs → auto-requires each .lua file
│   └── gl00ria/
│       ├── config/          # options, keymaps, autocmds, icons, neovide, lazy-load helper
│       └── plugins/         # Plugin configs organized by category (auto-loaded)
│           ├── 1st_load/    # Must load before others (alphabetical-loading workaround)
│           ├── ai/          # opencode, avante
│           ├── coding/      # LSP, treesitter, DAP, conform, lint, trouble
│           ├── editor/      # blink-cmp, lualine, neo-tree, barbar, flash, yazi
│           ├── ui/          # themes, alpha, todo-comments, diagnostics
│           └── utils/       # snacks, tmux, mini-*, git plugins
├── .stylua.toml             # StyLua: column=160, indent=2, spaces, AutoPreferSingle
├── .neoconf.json            # neodev/Lua LS library routing
├── ginit.vim                # Neovide GUI init
├── nvim-pack-lock.json      # vim.pack lockfile
└── .archived/               # Old lazy.nvim config (read-only history)
```

## WHERE TO LOOK
| Task | Location |
|------|----------|
| Add/modify option | `lua/gl00ria/config/options.lua` |
| Add keymap | `lua/gl00ria/config/keymaps.lua` |
| Add autocmd | `lua/gl00ria/config/autocmd.lua` |
| Lazy-load a plugin | `lua/gl00ria/config/lazy.lua` |
| Configure LSP for a language | `lua/gl00ria/plugins/coding/lsp/langs/<lang>.lua` |
| Add new plugin | New `.lua` file in appropriate `plugins/*/` subdir |
| Add formatter | `lua/gl00ria/plugins/coding/conform.lua` |
| Add linter | `lua/gl00ria/plugins/coding/lint.lua` |

## CONVENTIONS
- **Plugin spec**: `vim.pack.add { { src = 'https://github.com/...', version = ... } }` at top of each plugin file
- **Guard pattern**: `local ok, mod = pcall(require, 'mod'); if ok then mod.setup { ... } end`
- **Lazy-load**: `require 'gl00ria.config.lazy'` → `lazy.on_ui_enter(fn, 'id')` or `lazy.on_event(event, fn, 'id')`
- **Keymaps**: `vim.keymap.set` only. Always `{ desc = '...' }`. `'n'` mode unless multi-mode
- **Autocmds**: Named augroup with `{ clear = true }`. Each in `autocmd.lua`
- **Modeline**: `vim: ts=2 sts=2 sw=2 et` at end of config files
- **LSP keymaps**: Defined in `lspconfig.lua` inside `LspAttach` callback, desc prefixed with `'LSP: '`

## ANTI-PATTERNS
- DO NOT use `vim.api.nvim_set_keymap` — use `vim.keymap.set`
- DO NOT use `:set` — use `vim.o` / `vim.opt`
- DO NOT add plugin specs in global files — each plugin gets its own file
- DO NOT add to `.archived/` — read-only history
- DO NOT use `on_attach` in LSP lang configs — use the global `LspAttach` in `lspconfig.lua`
- DO NOT put language-specific keymaps in `langs/` files — shared keymaps go in `lspconfig.lua`
- AVOID `vim.cmd` where Lua API exists

## UNIQUE STYLES
- `1st_load/` dir — forces plugins to load before alphabetically-sorted ones (solves dependency ordering with vim.pack)
- `vim._core.ui2` experimental UI — enabled in init.lua (doesn't play well with noice.nvim)
- `cmdheight=0` with CmdlineEnter/Leave autocmd toggling it to 1 — minimal UI, restored via `redrawstatus()`
- `.neoconf.json` for neodev/Lua LS library routing
- 22 per-language LSP configs in `coding/lsp/langs/` — use `vim.lsp.config()` + `vim.lsp.enable()`, not `lspconfig.setup()`

## COMMANDS
```bash
# Validate Lua syntax:
find . -name '*.lua' -not -path '*/.archived/*' -exec luac -p {} \;
# Format with StyLua:
stylua lua/
# Update plugins:
:lua vim.pack.update()
```

## NOTES
- Plugin load order is deterministic: `1st_load` → `ai` → `coding` → `editor` → `ui` → `utils` (defined in `plugins.lua`)
- `vim.pack` is Neovim's built-in packer — see `:help vim.pack`
- Sub-directories have their own `AGENTS.md` with deeper conventions: `lua/gl00ria/config/AGENTS.md`, `lua/gl00ria/plugins/coding/lsp/AGENTS.md`
