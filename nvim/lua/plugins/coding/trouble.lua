return {
  "folke/trouble.nvim",
  cmd = { "Trouble" },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
    {
      "<leader>cS",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP references/definitions/... (Trouble)",
    },
    { "<leader>u1", "<cmd>Trouble loclist toggle<cr>", desc = "Toggle Location List (Trouble)" },
    { "<leader>uq", "<cmd>Trouble qflist toggle<cr>", desc = "Toggle Quickfix (Trouble)" },
    -- { "gd", "<cmd>Trouble lsp_definitions<cr>", desc = "GoTo Definition 󰡸 " },
    -- { "gt", "<cmd>Trouble lsp_type_definitions<cr>", desc = "GoTo Type Definition  " },
    -- { "gi", "<cmd>Trouble lsp_implementations<cr>", desc = "GoTo Implementation 󰝮 " },
    -- { "gbd", "<cmd>Trouble lsp_buf_definitions<cr>", desc = "GoTo Buffer Definition 󰡸 " },
    -- { "gD", "<cmd>Trouble lsp_declerations<cr>", desc = "GoTo Declaration 󰦻 " },
    -- { "gr", "<cmd>Trouble lsp_references<cr>", desc = "Show references 󱘭 " },
    -- { "gbr", "<cmd>Trouble lsp_buf_references<cr>", desc = "Show Buffer references 󱘭 " },
    { "<F6>", "<cmd>Trouble buffer_dignostics<cr>", desc = "Show Current Buffer Diagnostics  " },
    { "<F7>", "<cmd>Trouble workspace_dignostics<cr>", desc = "Show Workspace Diagnostics  " },
    { "<F8>", "<cmd>Trouble preview_symbols<cr>", desc = "Open Symbols  " },
    -- (definitions, type definition, sreferences, implementations, declarations, in-calls, out-calls)
    { "<F9>", "<cmd>Trouble lsp_all<cr>", desc = "LSP ALL in 1 󰹯 " },
    { "<F10>", "<cmd>Trouble<cr>", desc = "Open Trouble  " },
    -- {
    --   "[q",
    --   function()
    --     if require("trouble").is_open() then
    --       require("trouble").prev { skip_groups = true, jump = true }
    --     else
    --       local ok, err = pcall(vim.cmd.cprev)
    --       if not ok then vim.notify(err, vim.log.levels.ERROR) end
    --     end
    --   end,
    --   desc = "Previous Trouble/Quickfix Item",
    -- },
    -- {
    --   "]q",
    --   function()
    --     if require("trouble").is_open() then
    --       require("trouble").next { skip_groups = true, jump = true }
    --     else
    --       local ok, err = pcall(vim.cmd.cnext)
    --       if not ok then vim.notify(err, vim.log.levels.ERROR) end
    --     end
    --   end,
    --   desc = "Next Trouble/Quickfix Item",
    -- },
  },
  opts = {
    auto_close = false,
    auto_open = false,
    auto_preview = true,
    auto_refresh = true,
    auto_jump = false,
    focus = false,
    restore = true, -- restores the last location in the list when opening
    follow = true, -- Follow the current item
    indent_guides = true,
    max_items = 400,
    multiline = true,
    pinned = false, -- the opened trouble window will be bound to the current buffer
    warn_no_results = true, -- show a warning when there are no results
    open_no_results = false, -- open the trouble window when there are no results
    keys = {
      r = "refresh",
      R = "toggle_refresh",
      q = "close",
      o = "jump_close",
      i = "inspect",
      p = "preview",
      P = "toggle_preview",
    },
    modes = {
      -- source (https://github.com/folke/trouble.nvim/blob/e2969409cf3f38f69913cc8fd9aa13137aabe760/lua/trouble/sources/lsp.lua#L73)
      -- LSP (definitions, references, implementations, type definitions, & declarations)
      lsp_all = {
        -- desc = "LSP 5 in 1",
        desc = "LSP ALL in 1",
        sections = {
          "lsp_definitions",
          "lsp_references",
          "lsp_implementations",
          "lsp_type_definitions",
          "lsp_declarations",
          "lsp_incoming_calls",
          "lsp_outgoing_calls",
        },
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "LSP (def, type-def, ref, imp, dec, in-calls, out-calls )",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.7, height = 0.5 },
          zindex = 200,
        },
      },
      lsp_goto_definition = {
        -- mode = "lsp_definitions",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Buffer Diagnostics",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.7, height = 0.5 },
          zindex = 200,
        },
      },
      lsp_buf_definitions = {
        mode = "lsp_definitions",
        filter = { buf = 0 },
      },
      lsp_buf_references = {
        mode = "lsp_references",
        filter = { buf = 0 },
      },
      buffer_dignostics = {
        mode = "diagnostics",
        filter = { buf = 0 },
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Buffer Diagnostics",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.7, height = 0.5 },
          zindex = 200,
        },
      },
      workspace_dignostics = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Workspace Diagnostics",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.7, height = 0.5 },
          zindex = 200,
        },
      },
      preview_symbols = {
        mode = "symbols",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Symbols",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.7, height = 0.5 },
          zindex = 200,
        },
      },
    },
  },
}
