# CORE CONFIG

**Updated:** 2026-06-21

## OVERVIEW
Neovim options, keymaps, autocmds, icons — the foundation loaded before any plugins.

## STRUCTURE
```
config/
├── options.lua       # vim.o, vim.opt, vim.g setters (143 lines)
├── keymaps.lua       # All keymaps by category (182 lines)
├── autocmd.lua       # Organized by augroup (158 lines)
├── icons.lua         # Icon definitions for lualine, dap, etc.
├── neovide.lua       # Neovide GUI configuration
└── lazy.lua          # Lazy-load helper (on_ui_enter / on_event)
```

## WHERE TO LOOK
| Task | File | Notes |
|------|------|-------|
| Add/modify option | `options.lua` | Use `vim.o.` for scalar, `vim.opt.` for lists |
| Add keymap | `keymaps.lua` | Add to correct section, always include `{ desc = '...' }` |
| Add autocmd | `autocmd.lua` | Create named augroup via `vim.api.nvim_create_augroup` |
| Change icons | `icons.lua` | Keys organized by plugin/context |

## CONVENTIONS (config-specific)
- **keymaps**: Grouped by section headers (`-- Custom`, `-- Lines`, `-- Windows`, etc.). Always `{ desc = '...' }`. Use `'n'` mode unless multi-mode.
- **autocmds**: Each autocmd uses a named augroup with `{ clear = true }` for re-sourcing safety
- **options**: `vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)` pattern for late-set options
- **modeline**: `vim: ts=2 sts=2 sw=2 et` at end of each config file

## CONVENTIONS (config-specific)
- **keymaps**: Grouped by section headers (`-- Custom`, `-- Lines`, `-- Windows`, etc.). Always `{ desc = '...' }`. Use `'n'` mode unless multi-mode.
- **autocmds**: Each autocmd uses a named augroup with `{ clear = true }` for re-sourcing safety
- **options**: `vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)` pattern for late-set options
- **modeline**: `vim: ts=2 sts=2 sw=2 et` at end of each config file
- **lazy-load**: Use `lazy.lua` helper (`require 'gl00ria.config.lazy'`) for deferred plugin loading

## ANTI-PATTERNS
- Do NOT use `vim.api.nvim_set_keymap` — use `vim.keymap.set`
- Do NOT use `:set` — use `vim.o` / `vim.opt` Lua equivalents
- Do NOT add plugin-specific options here — put them in the plugin config file
