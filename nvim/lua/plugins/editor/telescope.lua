return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  -- enabled = function() return LazyVim.pick.want() == "telescope" end,
  -- version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    { "<leader><leader>", false },
    -- Files
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files 󰱼 " },
    { "<leader>fr", "<cmd>Telescope oldfiles prompt_title=Recent<cr>", desc = "Recent Files 󱈖 " },
    -- Words
    { "<leader>lg", "<cmd>Telescope live_grep<cr>", desc = "Grep Text  " },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word Under Cursor 󰗧" },
    -- { "<leader>fw", Util.telescope("grep_string", "dropdown", { cwd = false }), desc = "Find Word Under Cursor 󰗧" },
    -- Buffers
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers 󱂬 " },
    { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Currnet Buferr 󰡴 " },
    -- Git
    { "<leader>gB", "<cmd>Telescope git_branches<cr>", desc = "Branches  " },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits  " },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status 󱖫 " },
    -- Search
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Autocommands  " },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "CMD History 󰋚 " },
    { "<leader>s:", "<cmd>Telescope search_history<cr>", desc = "History 󰋚 " },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands 󰘳 " },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics  " },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages 󰛵 " },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlights 󰸱 " },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps 󰌌 " },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages 󰮱 " },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Marks  " },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options  " },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume 󰣿 " },
    { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Doc Symbols   " },
    { "<leader>sS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols   " },
    { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers 󰀘 " },
  },
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = have_make and "make"
        or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      enabled = have_make or have_cmake,
      config = function(plugin)
        LazyVim.on_load("telescope.nvim", function()
          local ok, err = pcall(require("telescope").load_extension, "fzf")
          if not ok then
            local lib = plugin.dir .. "/build/libfzf." .. (LazyVim.is_win() and "dll" or "so")
            if not vim.uv.fs_stat(lib) then
              LazyVim.warn("`telescope-fzf-native.nvim` not built. Rebuilding...")
              require("lazy")
                .build({ plugins = { plugin }, show = false })
                :wait(
                  function() LazyVim.info("Rebuilding `telescope-fzf-native.nvim` done.\nPlease restart Neovim.") end
                )
            else
              LazyVim.error("Failed to load `telescope-fzf-native.nvim`:\n" .. err)
            end
          end
        end)
      end,
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    local open_with_trouble = function(...) return require("trouble.sources.telescope").open(...) end
    local find_files_no_ignore = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
    end
    local find_files_with_hidden = function()
      local action_state = require("telescope.actions.state")
      local line = action_state.get_current_line()
      LazyVim.pick("find_files", { hidden = true, default_text = line })()
    end

    local telescopeConfig_status, telescopeConfig = pcall(require, "telescope.config")
    if not telescopeConfig_status then
      vim.notify("[telescope.config] failed to load", vim.log.levels.WARN)
      return
    end

    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
    table.insert(vimgrep_arguments, "--hidden")
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
            ["<c-o>"] = open_with_trouble,
            ["<a-t>"] = open_with_trouble,
            -- ["<a-i>"] = find_files_no_ignore,
            -- ["<a-h>"] = find_files_with_hidden,

            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
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

            ["<TAb>"] = actions.toggle_selection + actions.move_selection_worse,
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
        prompt_prefix = table.concat { " ", " " }, -- "❯", ">", " ", "»", "➜"
        selection_caret = table.concat { " ", " " },
        entry_prefix = "  ",
        multi_icon = table.concat { "<>", " " },
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
        borderchars = {
          prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
          results = { " " },
          preview = { " " },
        },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        -- file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        path_display = {
          filename_first = {
            reverse_directories = true, -- reverse path display with highlighting
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
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
        -- buffers = {
        --   show_all_buffers = true,
        --   ignore_current_buffer = true,
        --   sort_lastused = true,
        --   sort_mru = true,
        --   theme = "dropdown", -- Available: cursor | dropdown | ivy
        --   -- require("telescope.themes").get_dropdown({
        --   -- 	-- previewer = false,
        --   -- }),
        -- },
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
