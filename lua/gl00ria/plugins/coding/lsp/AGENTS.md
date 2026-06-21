# LSP CONFIG

**Updated:** 2026-06-21

## OVERVIEW
LSP integration: 22 per-language server configs + shared LspAttach keymaps + Mason installer.

## STRUCTURE
```
lsp/
├── lspconfig.lua        # LspAttach autocmd, keymaps (goto-def, rename, hover, etc.)
├── mason.lua            # Mason.nvim LSP installer setup
└── langs/               # One file per language
    ├── clangd.lua        # C/C++
    ├── rust.lua          # rust-analyzer
    ├── python.lua        # basedpyright
    ├── typescript.lua    # ts_ls (formerly tsserver)
    ├── go.lua, lua.lua, ...  # 22 total
    └── yaml.lua          # yaml-ls
```

## WHERE TO LOOK
| Task | File | Notes |
|------|------|-------|
| Add LSP for new language | New file in `langs/` | Follow existing single-file pattern |
| Add LSP keymap | `lspconfig.lua` | Inside LspAttach callback, prefix desc with `'LSP: '` |
| Change LSP installer | `mason.lua` | Mason ensures servers are installed |
| Tweak inlay hints | `lspconfig.lua` + `utils/snacks.lua` | Inlay hints handled via snacks |

## CONVENTIONS (LSP-specific)
- **Per-language files**: Each file in `langs/` returns a `setup {}` call. Pattern: `require('lspconfig')[server_name].setup { ... }`
- **LspAttach keymaps**: Defined inline in `lspconfig.lua` via local `map()` helper. Desc format: `'LSP: <action>'`
- **Capabilities**: Merged via `vim.lsp.protocol.make_client_capabilities()` at top of each language config
- **Server options**: Use opts table, not `on_attach` (on_attach is global in lspconfig.lua)

## ANTI-PATTERNS
- Do NOT add language-specific keymaps in individual `langs/` files — put shared keymaps in `lspconfig.lua` only
- Do NOT use `on_attach` in per-language configs — use the global LspAttach autocmd in lspconfig.lua
- Do NOT restart Mason on every config change — `MasonUpdate` refreshes
