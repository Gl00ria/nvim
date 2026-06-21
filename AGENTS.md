# PROJECT KNOWLEDGE BASE

**Generated:** 2026-06-21 16:36:17
**Commit:** cd790b6
**Branch:** main

## OVERVIEW
Personal Neovim PDE config using `vim.pack` (not lazy.nvim). Lua-first, 82 active files, ~4.4k LOC. Plugin manager is `vim.pack.add` + recursive directory scanner in `lua/plugins.lua`.

## STRUCTURE
```
nvim/
├── init.lua                 # Entry: vim._core.ui2 → config → pack → plugins
├── lua/
│   ├── plugins.lua          # Recursive plugin loader (scans 6 subdirs)
│   └── gl00ria/
│       ├── config/          # Core: options, keymaps, autocmds, icons, neovide
│       └── plugins/         # Plugin configs organized by category
│           ├── 1st_load/    # Must-load-first (treesitter, which-key, plenary, etc.)
│           ├── ai/          # opencode.lua
│           ├── coding/      # LSP, treesitter, DAP, formatters, linters
│           ├── editor/      # blink-cmp, lualine, neo-tree, barbar, flash, yazi
│           ├── ui/          # themes, alpha, todo-comments, diagnostics
│           └── utils/       # snacks, render-markdown, tmux, mini.*, git
├── .stylua.toml             # StyLua formatter config
├── .neoconf.json            # LSP/neodev config
├── ginit.vim                # Neovide GUI init
├── nvim-pack-lock.json      # vim.pack lockfile
└── .archived/               # Old lazy.nvim config (not active)
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| Add/change option | `lua/gl00ria/config/options.lua` | vim.o, vim.opt, vim.g setters |
| Add keymap | `lua/gl00ria/config/keymaps.lua` | 182 lines, grouped by sections |
| Add autocmd | `lua/gl00ria/config/autocmd.lua` | Organized by augroup |
| Configure LSP for new language | `lua/gl00ria/plugins/coding/lsp/langs/` | One file per language |
| Add new plugin | New file in appropriate `plugins/*/` subdir | Auto-loaded via scanner |
| Add formatter/linter | `lua/gl00ria/plugins/coding/conform.lua` or `lint.lua` | |
| Change statusline | `lua/gl00ria/plugins/editor/lualine.lua` | |
| Change autocomplete | `lua/gl00ria/plugins/editor/autocomplete/blink-cmp.lua` | |
| Treesitter parsers | `lua/gl00ria/plugins/1st_load/treesitter.lua` | List of parsers + auto-attach |

## CONVENTIONS
- **Plugin manager**: `vim.pack.add { { src = 'https://github.com/...', version = ... } }` at top of each plugin file
- **Guard pattern**: `local ok, mod = pcall(require, 'mod')` then `if ok then mod.setup { ... } else vim.notify(...) end`
- **StyLua**: column_width=160, indent_width=2, spaces, single quotes, no call parens where possible
- **Keymap descriptions**: Always include `{ desc = '...' }` on non-trivial maps
- **Loader**: Recursive `vim.fs.dir` scanner in `plugins.lua` — plugin files are auto-required by path; each plugin file stands alone
- **LSP keymaps**: Defined in `lspconfig.lua` inside `LspAttach` autocmd, prefixed with `LSP: ` in desc

## ANTI-PATTERNS (THIS PROJECT)
- DO NOT use lazy.nvim or packer — this uses `vim.pack` exclusively
- DO NOT add to `.archived/` — that directory is read-only history
- DO NOT use `vim.api.nvim_set_keymap` — use `vim.keymap.set` instead
- DO NOT add global plugin specs files — each plugin gets its own file in the appropriate subdir
- AVOID `vim.cmd` where Lua API exists (`vim.opt` over `:set`, `vim.keymap.set` over `:map`)

## UNIQUE STYLES
- `1st_load/` dir pattern — plugins that must load before others (solves vim.pack's alphabetical loading issue)
- `vim._core.ui2` experimental UI — enabled in init.lua for cmdline/dialog enhancements
- 22 per-language LSP config files in `coding/lsp/langs/` — one per supported language
- `cmdheight=0` with autocmd to set `cmdheight=1` on CmdlineEnter — minimal UI
- `.neoconf.json` for neodev/Lua LS library routing

## COMMANDS
```bash
# No build/CI — this is a config repo
# Validate Lua syntax:
find . -name '*.lua' -not -path '*/.archived/*' -exec luac -p {} \;
# Format with StyLua:
stylua lua/
```

## NOTES
- `vim.pack` is Neovim's built-in packer (see `:help vim.pack`) — not a third-party plugin manager
- The `.archived/` directory holds the previous lazy.nvim config for reference
- Plugin load order: 1st_load → ai → coding → editor → ui → utils (defined in `plugins.lua`)
