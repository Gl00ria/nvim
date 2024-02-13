local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (git.lua)", vim.log.levels.WARN)
  return
end

local git_opts = settings.utils_plugins.git

local gitsigns = {}

if git_opts.enable then
  gitsigns = {
    event = git_opts.event,
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = {
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "▁", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        untracked = { hl = "GitSignsAdd", text = "┆", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        interval = 700,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 700,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000,
      preview_config = {
        -- Options passed to nvim_open_win
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- ╭──────────────────────────────────────────────────────────╮
        -- │ Keymappings                                              │
        -- ╰──────────────────────────────────────────────────────────╯
        local gs = package.loaded.gitsigns
        -- Navigation
        map("n", git_opts.keymaps.next_hunk, function()
          if vim.wo.diff then
            return git_opts.keymaps.next_hunk
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { desc = "Next Hunk 󰮰 " })

        map("n", git_opts.keymaps.prev_hunk, function()
          if vim.wo.diff then
            return git_opts.keymaps.prev_hunk
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { desc = "Prev Hunk 󰮲 " })

        -- Actions
        map({ "n", "v" }, git_opts.keymaps.reset_hunk, gs.reset_hunk, { desc = "Reset Hunk 󱄍 " })

        map({ "n", "v" }, git_opts.keymaps.stage_hunk, gs.stage_hunk, { desc = "Stage Hunk 󰼬 " })
        map("n", git_opts.keymaps.stage_buffer, gs.stage_buffer, { desc = "Stage Buffer 󰼬 " })

        map("n", git_opts.keymaps.undo_stage_hunk, gs.undo_stage_hunk, { desc = "Undo Stage 󰕌 " })
        map("n", git_opts.keymaps.reset_buffer, gs.reset_buffer, { desc = "Reset Buffer 󱄍 " })
        map("n", git_opts.keymaps.preview_hunk, gs.preview_hunk, { desc = "Preview Hunk  " })

        map("n", git_opts.keymaps.blame_line, function()
          gs.blame_line({ full = true })
        end, { desc = "Blame  " })

        map("n", git_opts.keymaps.diff_this, gs.diffthis, { desc = "Diff Hunk  " })
        map("n", git_opts.keymaps.toggle_deleted, gs.toggle_deleted, { desc = "Toggle Deleted  " })

        -- Text object
        map({ "o", "x" }, git_opts.keymaps.text_object, ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  }
end

local git_treesitter = {}
if git_opts.ts_git then
  git_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "diff", "gitcommit" })
      end
    end,
  }
end

return { gitsigns, git_treesitter }
