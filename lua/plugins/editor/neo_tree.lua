return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    { "<leader>fe", false },
    { "<leader>fE", false },
    { "<leader>ge", false },
    { "<leader>be", false },
    {
      "<leader>e",
      function() require("neo-tree.command").execute { toggle = true, dir = LazyVim.root() } end,
      desc = "File Explorer   (Root Dir)",
      remap = true,
    },
    {
      "<leader>E",
      function() require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() } end,
      desc = "File Explorer  (cwd)",
      remap = true,
    },
  },
  deactivate = function() vim.cmd([[Neotree close]]) end,
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
      desc = "Start Neo-tree with directory",
      once = true,
      callback = function()
        if package.loaded["neo-tree"] then
          return
        else
          local stats = vim.uv.fs_stat(vim.fn.argv(0))
          if stats and stats.type == "directory" then require("neo-tree") end
        end
      end,
    })
  end,
  opts = {
    close_if_last_window = true,
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
    filesystem = {
      --
      -- use move deleted to 'trash'
      -- no more 'rm' accidents
      -- credits (https://github.com/nvim-neo-tree/neo-tree.nvim/issues/202#issuecomment-1428278234)
      --
      -- commands = {
      --   delete = function(state)
      --     local inputs = require("neo-tree.ui.inputs")
      --     local path = state.tree:get_node().path
      --     local msg = "Are you sure you want to trash " .. path
      --     inputs.confirm(msg, function(confirmed)
      --       if not confirmed then return end
      --
      --       vim.fn.system { "trash", vim.fn.fnameescape(path) }
      --       require("neo-tree.sources.manager").refresh(state.name)
      --     end)
      --   end,
      --   -- over write default 'delete_visual' command to 'trash' x n.
      --   delete_visual = function(state, selected_nodes)
      --     local inputs = require("neo-tree.ui.inputs")
      --     -- get table items count
      --     function GetTableLen(tbl)
      --       local len = 0
      --       for n in pairs(tbl) do
      --         len = len + 1
      --       end
      --       return len
      --     end
      --
      --     local count = GetTableLen(selected_nodes)
      --     local msg = "Are you sure you want to trash " .. count .. " files ?"
      --     inputs.confirm(msg, function(confirmed)
      --       if not confirmed then return end
      --       for _, node in ipairs(selected_nodes) do
      --         vim.fn.system { "trash", vim.fn.fnameescape(node.path) }
      --       end
      --       require("neo-tree.sources.manager").refresh(state.name)
      --     end)
      --   end,
      -- },
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<space>"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        ["O"] = {
          function(state) require("lazy.util").open(state.tree:get_node().path, { system = true }) end,
          desc = "Open with System Application",
        },
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      git_status = {
        symbols = {
          unstaged = "󰄱",
          staged = "󰱒",
        },
      },
    },
  },
  config = function(_, opts)
    local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end

    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
    require("neo-tree").setup(opts)
    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then require("neo-tree.sources.git_status").refresh() end
      end,
    })
  end,
}
