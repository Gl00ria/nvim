local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (git.lua)", vim.log.levels.WARN)
  return
end

local git_signs_opts = settings.utils_plugins.git_signs
local gitsigns = {}

local git_blame_opts = settings.utils_plugins.git_blame
local gitblame = {}

local git_dev_opts = settings.utils_plugins.git_dev
local gitdev = {}

if git_signs_opts.enable then
  gitsigns = {
    event = git_signs_opts.event,
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
        map("n", git_signs_opts.keymaps.next_hunk, function()
          if vim.wo.diff then
            return git_signs_opts.keymaps.next_hunk
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { desc = "Next Hunk 󰮰 " })

        map("n", git_signs_opts.keymaps.prev_hunk, function()
          if vim.wo.diff then
            return git_signs_opts.keymaps.prev_hunk
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { desc = "Prev Hunk 󰮲 " })

        -- Actions
        map({ "n", "v" }, git_signs_opts.keymaps.reset_hunk, gs.reset_hunk, { desc = "Reset Hunk 󱄍 " })

        map({ "n", "v" }, git_signs_opts.keymaps.stage_hunk, gs.stage_hunk, { desc = "Stage Hunk 󰼬 " })
        map("n", git_signs_opts.keymaps.stage_buffer, gs.stage_buffer, { desc = "Stage Buffer 󰼬 " })

        map("n", git_signs_opts.keymaps.undo_stage_hunk, gs.undo_stage_hunk, { desc = "Undo Stage 󰕌 " })
        map("n", git_signs_opts.keymaps.reset_buffer, gs.reset_buffer, { desc = "Reset Buffer 󱄍 " })
        map("n", git_signs_opts.keymaps.preview_hunk, gs.preview_hunk, { desc = "Preview Hunk  " })

        map("n", git_signs_opts.keymaps.blame_line, function()
          gs.blame_line({ full = true })
        end, { desc = "Blame  " })

        map("n", git_signs_opts.keymaps.diff_this, gs.diffthis, { desc = "Diff Hunk  " })
        map("n", git_signs_opts.keymaps.toggle_deleted, gs.toggle_deleted, { desc = "Toggle Deleted  " })

        -- Text object
        map({ "o", "x" }, git_signs_opts.keymaps.text_object, ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  }
end

if git_blame_opts.enable then
  gitblame = {
    "FabijanZulj/blame.nvim",
    cmd = git_blame_opts.cmd,
    event = git_blame_opts.event,
    keys = git_blame_opts.keys,
    opts = {
      date_format = git_blame_opts.date_format,
      virtual_style = git_blame_opts.virtual_style,
      views = {
        -- window = window_view,
        -- virtual = virtual_view,
        -- default = window_view,
      },
      merge_consecutive = false,
      max_summary_width = 30,
      colors = nil,
      commit_detail_view = git_blame_opts.commit_detail_view,
      -- format_fn = formats.commit_date_author_fn,
      mappings = {
        commit_info = git_blame_opts.mappings.commit_info,
        stack_push = git_blame_opts.mappings.stack_push,
        stack_pop = git_blame_opts.mappings.stack_pop,
        show_commit = git_blame_opts.mappings.show_commit,
        close = git_blame_opts.mappings.close,
      },
    },
  }
end

if git_dev_opts.enable then
  gitdev = {
    "moyiz/git-dev.nvim",
    keys = git_dev_opts.keys,
    opts = {
      ephemeral = git_dev_opts.ephemeral, -- delete opened repo when exiting nvim, use `GitDevCleanAll` to clean
      read_only = git_dev_opts.read_only, -- open repositories to be read-only
      cd_type = git_dev_opts.cd_type, -- Available: global|tab|window|none
      repositories_dir = git_dev_opts.repositories_dir,
      base_uri_format = git_dev_opts.base_uri_format,
      clone_args = git_dev_opts.clone_args,
      fetch_args = git_dev_opts.fetch_args,
      checkout_args = git_dev_opts.checkout_args,
      -- opener = function(dir, _, selected_path)
      --   vim.cmd("tabnew")
      --   vim.cmd("Neotree " .. dir)
      --   if selected_path then
      --     vim.cmd("edit " .. selected_path)
      --   end
      -- end,
      opener = function(dir, _, selected_path)
        local file_explorer_opts = settings.editor_plugins.file_explorer
        if file_explorer_opts.strategy == "nvim-tree" then
          vim.cmd("tabnew")
          vim.cmd("NvimTreeOpen " .. vim.fn.fnameescape(dir))
        elseif file_explorer_opts.strategy == "neo-tree" then
          vim.cmd("tabnew")
          vim.cmd("Neotree " .. dir)
        end
        if selected_path then
          vim.cmd("edit " .. selected_path)
        end
      end,
    },
  }
end

local git_treesitter = {}
if git_signs_opts.ts_git then
  git_treesitter = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "diff", "gitcommit" })
      end
    end,
  }
end

return { gitblame, gitsigns, gitdev, git_treesitter }
