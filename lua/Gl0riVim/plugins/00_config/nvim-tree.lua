local nvim_tree_status, nvimtree = pcall(require, "nvim-tree")
if not nvim_tree_status then
  vim.notify("Plugin [nvim-tree] failed to load", vim.log.levels.WARN)
  return
end

local api_status, api = pcall(require, "nvim-tree.api")
if not api_status then
  vim.notify("[nvimtree's api] failed to load", vim.log.levels.WARN)
  return
end

local icons_status, icons = pcall(require, "icons")
if not icons_status then
  vim.notify("[icons] failed to load within (nvim-tree)", vim.log.levels.WARN)
  return
end

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
  vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
  vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
  vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
  vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
  vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
  vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
  vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
  vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
  vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
  vim.keymap.set("n", "a", api.fs.create, opts("Create"))
  vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
  vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
  vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
  vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
  vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
  vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
  vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
  vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
  vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
  vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
  vim.keymap.set("n", "q", api.tree.close, opts("Close"))
  vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
  vim.keymap.set("n", "S", api.tree.search_node, opts("Search"))
end

nvimtree.setup({
  on_attach = on_attach,
  auto_reload_on_write = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  view = {
    number = true,
    relativenumber = true,
    side = "left",
    adaptive_size = true,
    float = {
      enable = false,
      quit_on_focus_loss = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  renderer = {
    indent_width = 2,
    add_trailing = true,
    group_empty = false,
    highlight_git = true,
    highlight_opened_files = "all",
    root_folder_label = ":~",
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
      modified_placement = "after",
      diagnostics_placement = "signcolumn",
      bookmarks_placement = "signcolumn",
      symlink_arrow = " -> ",
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "󰆤",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = icons.misc.folder,
          open = icons.misc.folderOpen,
          empty = icons.misc.folderNoBg,
          empty_open = icons.misc.folderOpenNoBg,
          symlink = icons.misc.symlink,
          symlink_open = icons.misc.symlinkOpen,
        },
        git = {
          unstaged = icons.git.unstaged,
          staged = icons.git.staged,
          unmerged = icons.git.unmarged,
          renamed = icons.git.renamed,
          untracked = icons.git.untracked,
          deleted = icons.git.deleted,
          ignored = icons.git.ignored,
        },
      },
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
        diagnostics = true,
        bookmarks = true,
      },
    },
    special_files = {
      "Cargo.toml",
      "Makefile",
      "README.md",
      "readme.md",
      "environment.yml",
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = icons.diagnostics.Hint,
      info = icons.diagnostics.Info,
      warning = icons.diagnostics.Warn,
      error = icons.diagnostics.error,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  filters = {
    dotfiles = false,
    custom = {},
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
})

-- Auto close when 'nvim-tree' is the last window
-- (https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close)
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
      vim.cmd("quit")
    end
  end,
})
