-- use a protected call so we don't error out on first use
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- local m_opts = {
--   mode = "n", -- NORMAL mode
--   prefix = "m",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }

-- local m_mappings = {
-- }

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<cr>', "Comment" },
  s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
}


local mappings = {
  a = {
    name = "Telescope",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    f = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files" },
    l = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    o = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
    r = { "<cmd>Telescope resume<cr>", "Last Search" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    h = { "<cmd>Telescope help_tags<cr>", "Help" },
  },

  b = {
    name = "Bookmarks",
    a = { "<cmd>BookmarkAnnotate<cr>", "Annotate" },
    c = { "<cmd>BookmarkClear<cr>", "Clear" },
    m = { "<cmd>BookmarkToggle<cr>", "Toggle" },
    h = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
    j = { "<cmd>BookmarkNext<cr>", "Next" },
    k = { "<cmd>BookmarkPrev<cr>", "Prev" },
    s = {
      "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
      "Show" },
  x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
  u = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
  },

  -- ["c"] =

  d = {
    name = "Diffview",
    c = { "<cmd>DiffviewClose<cr>", "Close" },
    h = { "<cmd>DiffviewFileHistory<cr>", "File History" },
    f = { "<cmd>DiffviewFocusFiles<cr>", "Focus Files" },
    l = { "<cmd>DiffviewLog<cr>", "View Log" },
    o = { "<cmd>DiffviewOpen<cr>", "Open" },
    r = { "<cmd>DiffviewRefresh<cr>", "Refresh" },
    t = { "<cmd>DiffviewToggleFiles<cr>", "Toggle Files"},
  },


  e = {
    name = "Explorer",
    b = { "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", "Buffer Explorer" },
    f = { "<cmd>NeoTreeShowToggle<cr>", "File Explorer" },
  },

-- { "<cmd>NvimTreeToggle<cr>", "Explorer" },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>GitBlameToggle<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk"},
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff"},

    G = {
      name = "Gist",
      a = { "<cmd>Gist -b -a<cr>", "create Anon" },
      d = { "<cmd>Gist -d<cr>", "Delete" },
      f = { "<cmd>Gist -f<cr>", "Fork" },
      g = { "<cmd>Gist -b<cr>", "create" },
      l = { "<cmd>Gist -l<cr>", "List" },
      p = { "<cmd>Gist -b -p<cr>", "create Private" },
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", "Add Workspace" },
    c = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    D = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics"},
    d = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    i = { "<cmd>LspInfo<cr>", "LSP Info" },
    I = { "<cmd>LspInstallInfo<cr>", "LSP Installer Info" },
    L = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "List Diagnostics"},
    l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", "List Workspace" },
    P = { "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", "Preview Definition" },
    p = { "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", "Preview Implementation" },
    R = { "<cmd>lua require('goto-preview').goto_preview_references()<cr>", "Preview Reference"},
    r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", "Remove Workspace" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    w = { "<cmdTroubleToggle workspace_diagnostics<cr>", "Wrokspace Diagnostics" },
    v = { "<cmd>Lspsaga toggle_virtual_text<cr>", "Toggle Virtual Text" },
  },


  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  S = {
    name = "SnipRun",
    c = { "<cmd>SnipClose<cr>", "Close" },
    f = { "<cmd>%SnipRun<cr>", "Run File" },
    i = { "<cmd>SnipInfo<cr>", "Info" },
    m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
    r = { "<cmd>SnipReset<cr>", "Reset" },
    t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
    x = { "<cmd>SnipTerminate<cr>", "Terminate" },
  },

  -- s = {
  --   s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  --   S = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>","Workspace Symbols"},
  --   o = { "<cmd>SymbolsOutline<cr>", "Outline" },
  -- },


  t = {
    name = "Terminal",
    ["1"] = { ":1ToggleTerm<cr>", "1" },
    ["2"] = { ":2ToggleTerm<cr>", "2" },
    ["3"] = { ":3ToggleTerm<cr>", "3" },
    ["4"] = { ":4ToggleTerm<cr>", "4" },
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=90 direction=vertical<cr>", "Vertical" },
  },

  T = {
    name = "Treesitter",
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
  },

  -- ["f"] =
  -- ["F"] =
  -- ["h"] =
  -- ["w"] =
  -- ["q"] =
  -- ["r"] =
  -- ["R"] =
  -- ["/"] =
  P = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
  z = { "<cmd>ZenMode<cr>", "Zen" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
-- which_key.register(m_mappings, m_opts)
