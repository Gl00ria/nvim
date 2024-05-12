local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (telescope.lua)", vim.log.levels.WARN)
  return
end

local telescope_opts = settings.editor_plugins.trelescope

-- local util_status, Util = pcall(require, "util")
-- if not util_status then
--   vim.notify("[util] failed to load within (telescope)", vim.log.levels.WARN)
--   return
-- end

local telescope = {}

if telescope_opts.enable then
  telescope = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = telescope_opts.keys,
    opts = function()
      local telescopeConfig_status, telescopeConfig = pcall(require, "telescope.config")
      if not telescopeConfig_status then
        vim.notify("[telescope.config] failed to load", vim.log.levels.WARN)
        return
      end

      local actions_status, actions = pcall(require, "telescope.actions")
      if not actions_status then
        vim.notify("[telescope.actions] failed to load", vim.log.levels.WARN)
        return
      end

      local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
      if telescope_opts.nvchad_borderchars then
        borderchars = {
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
          preview = { " " },
        }
      end

      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
      if telescope_opts.grep_hidden then
        table.insert(vimgrep_arguments, "--hidden")
      end
      -- trim the indentation at the beginning of presented line
      table.insert(vimgrep_arguments, "--trim")

      return {
        defaults = {
          -- which patterns to ignore in file switcher
          file_ignore_patterns = {
            "%.7z",
            "%.MOV",
            "%.RAF",
            "%.burp",
            "%.bz2",
            "%.cache",
            "%.class",
            "%.dll",
            "%.docx",
            "%.dylib",
            "%.epub",
            "%.exe",
            "%.flac",
            "%.ico",
            "%.ipynb",
            "%.jar",
            "%.lock",
            "%.mkv",
            "%.mov",
            "%.mp4",
            "%.otf",
            "%.pdb",
            "%.rar",
            "%.sqlite3",
            "%.svg",
            "%.tar",
            "%.tar.gz",
            "%.zip",
            ".git/",
            ".gradle/",
            ".idea/",
            ".settings/",
            ".vale/",
            ".vscode/",
            "__pycache__/*",
            "build/",
            "env/",
            "gradle/",
            "node_modules/",
            "smalljre_*/*",
            "target/",
            "vendor/*",
          },
          -- used for grep_string and live_grep
          vimgrep_arguments = vimgrep_arguments,
          -- vimgrep_arguments = {
          --   "rg",
          --   "--follow",
          --   "--color=never",
          --   "--no-heading",
          --   "--with-filename",
          --   "--line-number",
          --   "--column",
          --   "--smart-case",
          --   "--no-ignore",
          --   "--trim",
          --     -- },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,

              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,

              ["<C-c>"] = actions.close,

              ["<cr>"] = actions.select_default,
              -- ["oh"] = actions.select_horizontal,
              -- ["ov"] = actions.select_vertical,
              -- ["ot"] = actions.select_tab,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["tq"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["ct"] = actions.complete_tag,
              -- ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
              ["<C-c>"] = actions.close,
              -- ["<esc>"] = actions.close,
              ["<cr>"] = actions.select_default,
              -- ["oh"] = actions.select_horizontal,
              -- ["ov"] = actions.select_vertical,
              -- ["ot"] = actions.select_tab,

              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["tq"] = actions.send_selected_to_qflist + actions.open_qflist,

              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
              ["M"] = actions.move_to_middle,

              ["<Down>"] = actions.move_selection_next,
              ["<Up>"] = actions.move_selection_previous,
              ["gg"] = actions.move_to_top,
              ["G"] = actions.move_to_bottom,

              ["<C-u>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.preview_scrolling_down,

              ["<PageUp>"] = actions.results_scrolling_up,
              ["<PageDown>"] = actions.results_scrolling_down,

              ["?"] = actions.which_key,
            },
          },
          prompt_prefix = table.concat({ " ", " " }), -- "❯", ">", " ", "»", "➜"
          selection_caret = table.concat({ " ", " " }),
          entry_prefix = "  ",
          multi_icon = table.concat({ "<>", " " }),
          initial_mode = "insert",
          layout_config = {
            width = 0.99,
            height = 0.85,
            preview_cutoff = 120,
            prompt_position = "top",
            horizontal = {
              preview_width = function(_, cols, _)
                if cols > 200 then
                  return math.floor(cols * 0.4)
                else
                  return math.floor(cols * 0.6)
                end
              end,
            },
            vertical = { width = 0.99, height = 0.95, preview_height = 0.5 },
            flex = { horizontal = { preview_width = 0.99 } },
          },
          winblend = 0,
          borderchars = borderchars,
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          path_display = {
            filename_first = {
              reverse_directories = telescope_opts.reverse_directories,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = telescope_opts.find_files_show_hidden,
            -- theme = "",
            mappings = {
              n = {
                ["cd"] = function(prompt_bufnr)
                  local selection = require("telescope.actions.state").get_selected_entry()
                  local dir = vim.fn.fnamemodify(selection.path, ":p:h")
                  require("telescope.actions").close(prompt_bufnr)
                  -- Depending on what you want put `cd`, `lcd`, `tcd`
                  vim.cmd(string.format("silent lcd %s", dir))
                end,
              },
            },
          },
          buffers = {
            show_all_buffers = true,
            ignore_current_buffer = true,
            sort_lastused = true,
            sort_mru = true,
            theme = "dropdown", -- Available: cursor | dropdown | ivy
            -- require("telescope.themes").get_dropdown({
            -- 	-- previewer = false,
            -- }),
          },
          -- find_command = { "fd", "--hidden", "--type", "file", "--follow", "--strip-cwd-prefix" },
          -- find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
          find_command = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        },
      }
    end,
  }
end

return telescope
