local neo_tree_status, neotree = pcall(require, "neo-tree")
if not neo_tree_status then
  vim.notify("Plugin [neo-tree] failed to load", vim.log.levels.WARN)
  return
end

local icons_status, icons = pcall(require, "icons")
if not icons_status then
  vim.notify("[icons] failed to load within (neo-tree.lua)", vim.log.levels.WARN)
  return
end

neotree.setup({
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  sort_case_insensitive = true, -- used when sorting files and directories in the tree

  sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline", "edgy" },

  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreceIndentMarker",
      -- expander config, needed for nesting files
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = icons.misc.folder,
      folder_open = icons.misc.folderOpen,
      folder_empty = icons.misc.folderNoBg,
      highlight = "NeoTreeFileIcon",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added = icons.git.add,
        modified = icons.git.modified,
        deleted = icons.git.deleted,
        renamed = icons.git.renamed,
        -- Status type
        untracked = icons.git.untracked,
        ignored = icons.git.ignored,
        unstaged = icons.git.unstaged,
        staged = icons.git.staged,
        conflict = icons.git.conflict,
      },
    },
  },
  window = {
    position = "left",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = "none",
      ["<2-LeftMouse>"] = "open",
      ["l"] = "open",
      ["<esc>"] = "revert_preview",
      ["P"] = { "toggle_preview", config = { use_float = true } },
      ["S"] = "open_split",
      ["s"] = "open_vsplit",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["z"] = "close_all_nodes",
      ["a"] = {
        "add",
        -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
          show_path = "none", -- "none", "relative", "absolute"
        },
      },
      ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
      ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
      ["q"] = "close_window",
      ["R"] = "refresh",
      ["?"] = "show_help",
      ["<"] = "prev_source",
      [">"] = "next_source",
    },
  },
  filesystem = {
    filtered_items = {
      visible = true, -- when true, they will just be displayed differently than normal items
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = true, -- only works on Windows for hidden files/directories
      bind_to_cwd = true,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    follow_current_file = {
      enabled = true,
    },
    group_empty_dirs = false, -- when true, empty folders will be grouped together
    window = {
      mappings = {
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
      },
    },
  },
})

-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function(data)
--         -- buffer is a directory
--         local directory = vim.fn.isdirectory(data.file) == 1

--         -- change to the directory
--         if directory then
--             vim.cmd.cd(data.file)
--             -- open the tree
--             vim.cmd("NeoTreeFloatToggle")
--         end
--     end,
-- })

vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
