--   ┣━━━━━━━━━━━━━━━━━━━┫ Control Center ┣━━━━━━━━━━━━━━━━━━━━┫
--   ▲                                                         ▲
--   █          Here you can Control the following:            █
--   █                                                         █
--   █        1- Neovide                                       █
--   █        2- Edit editor's OPTTIONS (conf.options)         █
--   █        3- Edit KEYMAPS:                                 █
--   █            -- Custom keymaps (conf.custom_keys)         █
--   █            -- LSP keymaps    (conf.lsp_keys)            █
--   █            -- Eeach & Every Plugin's keymaps            █
--   █               (Located in every plugin spec)            █
--   █                                                         █
--   █        3- Enable/Disable Pluigns:                       █
--   █            -- Coding  (conf.coding_plugins)             █
--   █                  &    (conf.langs_control)              █
--   █            -- Editor  (conf.editor_plugins)             █
--   █            -- UI      (conf.ui_plugins)                 █
--   █            -- Themes  (conf.theme_plugins)              █
--   █            -- Utils   (conf.utils_plugins)              █
--   █            -- AI      (conf.ai_plugins)                 █
--   █            -- Games   (conf.games_plugins)              █
--   ▼                                                         ▼
--   ┣━━━━━━━━━━━━━━━━━━━━━━━━━━┫┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
local conf = {}
--
-- ╞═════════╡ YOU ARE RESPONSIBLE OF YOUR ACTIONS (: ╞════════╡
--
-- ~/.config/nvim/Gl0riVim/init.lua
conf.make_me_nacked = false
--   ╒═════════════════════════════════════════════════════════╕
--
--                             NEOVIDE
--            ~/.config/nvim/Gl0riVim/config/neovid.lua
--   ╘═════════════════════════════════════════════════════════╛
conf.neovide = {

  remember_window_size = true,
  remember_window_position = true,
  neovide_refresh_rate = 60,
  neovide_fullscreen = false,
  neovide_profiler = false,

  neovide_transparency = 0.8,
  neovide_scroll_animation_length = 0.9,
  neovide_cursor_animate_in_insert_mode = true,
  neovide_cursor_vfx_mode = "railgun", -- Available: railgun, torpedo, pixiedust, sonicboom ,ripple ,wireframe
  neovide_hide_mouse_when_typing = false,

  t_neovide_transparency = "<leader>tv", -- toggle transparency
  zoom_key = "<C-=>",
  dezoom_key = "<C-->",
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                             OPTIONS
--            ~/.config/nvim/Gl0riVim/config/options.lua
--   ╘═════════════════════════════════════════════════════════╛
conf.options = {
  mapleader = " ",
  local_mapleader = " ",

  clipboard = "unnamedplus", -- Copy-paste between vim and everything else
  confirm = true, -- Confirm to save changes before exiting modified buffer
  cmdheight = 0, -- Give more space for displaying messages
  completeopt = "menu,menuone,noselect", --- Better autocompletion
  cursorline = true, -- Highlight of current line
  emoji = false, -- Fix emoji display
  expandtab = true, -- Use spaces instead of tabs

  foldlevel = 99999, -- Using ufo provider need a large value
  foldtext = "v:lua.require'lazyvim.util.ui'.foldtext()",
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
  -- foldcolumn = "0",
  -- foldnestmax = 0,
  -- foldlevelstart = 99, -- Expand all folds by default

  -- use "set guifont=*" to see available fonts on your system
  -- guifont = "FiraCode Nerd Font",
  -- guifont = "Iosevka\\ NF:h18",
  -- guifont = "VictorMono\\ NF:h18",
  -- guifont = "FantasqueSansMono\\ Nerd\\ Font\\ Mono:h18",
  -- guifont = "CaskaydiaCove Nerd Font Mono:h16",
  -- guifont = "CaskaydiaCove Nerd Font:h16",
  -- guifont = "JetBrainsMono\\ Nerd\\ Font:h16",
  -- guifont = "Hack:h16",
  -- guifont = "Maple Mono:h18",

  -- Right To Left Fonts
  guifont = "DejaVu Sans Mono:h18",
  -- guifont = "Vazir Code Hack:h18",
  -- guifont = "Kawkab Mono:h18",

  ignorecase = true, -- Needed for smartcase
  laststatus = 3, -- Global statusline at the bottom
  list = true,
  -- which list chars to show
  listchars = {
    --    eol = "⤶",
    tab = ">.",
    --    trail = "~",
    extends = "◀",
    precedes = "▶",
  },
  mouse = "nv",
  number = true, -- Shows current line number
  relativenumber = true, -- Relative line numbers
  pumheight = 10, -- Max num of items in completion menu
  scrolloff = 8, -- Always keep space when scrolling to bottom/top edge
  shiftwidth = 2, -- Number of space characters inserted for indentation
  showtabline = 2,
  signcolumn = "yes:2", -- Add extra sign column next to line number
  smartcase = true, -- Uses case in search
  smartindent = true, -- Makes indenting smart
  smarttab = true, -- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop = 2, -- Insert 2 spaces for a tab
  splitright = true, -- Vertical splits will automatically be to the right
  swapfile = false, -- Swap not needed
  tabstop = 2, -- Insert 2 spaces for a tab
  -- NOTE: enabled by default on v(0.10.0)
  termguicolors = true, -- Correct terminal colors
  timeoutlen = 300, -- Faster completion (cannot be lower than 200)
  ttimeoutlen = 0, -- Time to wait for a key code sequence to complete
  undofile = true, -- Sets undo to file
  updatetime = 100, -- Faster completion
  viminfo = "'1000", -- Increase the size of file history
  wildignore = "*node_modules/**", -- Don't search inside Node.js modules (works for gutentag)
  wrap = true, -- Display long lines as just one line
  writebackup = false, -- Not needed
  autoindent = true, -- Good auto indent
  backspace = "indent,eol,start", -- Making sure backspace works
  backup = false, -- Recommended by coc
  -- Concealed text is completely hidden unless it has a custom replacement
  -- character defined (needed for dynamically showing tailwind classes)
  conceallevel = 2,
  concealcursor = "", -- Set to an empty string to expand tailwind class when on cursorline
  encoding = "utf-8", -- The encoding displayed
  errorbells = false, -- Disables sound effect for errors
  fileencoding = "utf-8", -- The encoding written to file
  incsearch = true, -- Start searching before pressing enter
  showmode = false, -- Don't show things like -- INSERT -- anymore
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                         CUSTOM KEYAMPS
--            ~/.config/nvim/Gl0riVim/config/keymaps.lua
--   ╘═════════════════════════════════════════════════════════╛
conf.custom_keys = {
  -- keymaps which are not related to plugins, expect the plugin manager 'Lazy'
  -- leave insert mode
  key_1 = "jk",
  key_2 = "kj",
  key_3 = "JK",
  key_4 = "KJ",

  del_in_n_mode = "<BS>", -- detele in normal mode
  paste_over_selection = "<leader>p",
  remove_highlights = "<ESC>",
  highlights_under_cursor = "<leader>sg",
  lines_from_history = "<leader>Fq",
  options = "<leader>oo",
  save_file = "<C-S>", -- n & i mode
  select_all = "<C-A>", -- n-mode
  paste_in_i_mode = "<C-V>", -- paste in 'i-mode'

  -- Lazy plugin manager
  lazy_dashboard = "<leader>Pd",
  lazy_update = "<leader>Pu",
  lazy_debug = "<leader>PD",
  lazy_build = "<leader>Pb",
  lazy_clean = "<leader>Px",
  lazy_check = "<leader>PC",
  lazy_help = "<leader>PH",
  lazy_health = "<leader>Ph",
  lazy_load = "<leader>Pl",
  lazy_log = "<leader>PL",
  lazy_profile = "<leader>Pp",
  lazy_reload = "<leader>Pr",
  lazy_restore = "<leader>PR",
  lazy_sync = "<leader>Ps",

  -- windows navigating
  w_nav_left = "<C-h>",
  w_nav_down = "<C-j>",
  w_nav_up = "<C-k>",
  w_nav_right = "<C-l>",
  w_goto_other = "<leader>wo", -- goto other window
  w_delete = "<leader>wd", -- delete a window
  -- window resizing
  w_resize_up = "<C-UP>",
  w_resize_down = "<C-DOWN>",
  w_resize_right = "<C-RIGHT>",
  w_resize_left = "<C-LEFT>",
  -- window splitting
  w_split_below = "<leader>wj", -- "<leader>-"
  w_split_right = "<leader>wl", -- "<leader>|"

  -- buffers
  next_buffer = "<TAB>",
  prev_buffer = "<S-TAB>",
  close_all = "<leader>bca", -- close all buffers except current

  -- tabs
  new_tab = "<leader><Tab>n",
  next_tab = "<leader><Tab>l",
  prev_tab = "<leader><Tab>h",
  close_tab = "<leader><tab>c",

  -- Toggle keymaps
  t_spelling = "<leader>ts",
  t_statusline = "<leader>tS",

  t_wrap = "<leader>tW",

  t_line_num = "<leader>tn", -- toggle line number
  t_number = "<leader>tN", -- local to winodw

  t_conceallevel = "<leader>tc",
  t_signcolumn = "<leader>tC",

  t_tabline = "<leader>tt",
  t_colorcolumn = "<leader>tT",

  t_mouse = "<leader>tm",

  t_quicklist = "<leader>tq",
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                             CODING
--
--   ╘═════════════════════════════════════════════════════════╛
-- ~/.config/nvim/Gl0riVim/00_config/lsp/lspkeymaps.lua
conf.lsp_keys = {
  lsp_def = "gd", -- goto definition
  lsp_dec = "gD", -- gogo deceleration
  lsp_imp = "gi", -- goto implementation
  lsp_type_def = "gt", -- goto type definition
  lsp_buf_def = "<leader>bd", -- buffer definition
  lsp_signatrue_h = "gs", -- signature help
  lsp_hover = "K", -- hover
  lsp_rename = "<leader>cr", -- rename
  lsp_show_ref = "gr", -- show references
  lsp_float_diag = "<leader>df", -- float diagnostics
  lsp_toggle_diag = "<leader>dt", -- toggole diagnostics
  lsp_next_diag = "]d", -- goto next diagnostic
  lsp_prev_diag = "[d", -- goto prev diagnostic
  lsp_next_err = "]e", -- goto next err
  lsp_prev_err = "[e", -- goto prev error
  lsp_next_warn = "]w", -- goto next warn
  lsp_prev_warn = "[w", -- goto prev warn
  lsp_next_hint = "]h", -- goto next hint
  lsp_prev_hint = "[h", -- goto prev hint
  lsp_code_act = "ca", -- code action
  lsp_src_code_act = "cA", -- source code action
  lsp_win_diag_qf = "<leader>qw", -- send window diagnostics to qf
  lsp_buf_diag_qf = "<leader>qb", -- Send buffer diagnostics to qf
  lsp_diag_loc_list = "<leader>qd", -- diagnostics location list
  lsp_add_wp = "<leader>cwa", -- add workspace
  lsp_rm_wp = "<leader>cwr", -- remove workspace
  lsp_ls_wp = "<leader>cwl", -- list workspaces
  lsp_format = "<leader>f",
}

conf.coding_plugins = {
  -- ~/.config/nvim/Gl0riVim/coding/lsp/lspconfig.lua
  lspconfig = {
    enable = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = {
      { "<leader>cLi", "<cmd>LspInfo<cr>", desc = "Info  " },
      { "<leader>cLI", "<cmd>LspInstall<cr>", desc = "Install 󰅢 " },
      { "<leader>cLo", "<cmd>LspLog<cr>", desc = "Log  " },
      { "<leader>cLr", "<cmd>LspRestart<cr>", desc = "Restart 󰜉 " },
      { "<leader>cLs", "<cmd>LspStart<cr>", "Start 󰐥 " },
      { "<leader>cLS", "<cmd>LspStop<cr>", desc = "Stop 󰓛 " },
      { "<leader>cLu", "<cmd>LspUninstall<cr>", desc = "Uninstall  " },
    },
  },
  -- ~/.config/nvim/Gl0riVim/coding/lsp/mason.lua
  mason = {
    enable = true,
    cmd = "Mason",
    keys = {
      { "<leader>cM", "<cmd>Mason<cr>", desc = "Mason 󰫑 " },
    },
  },
  -- stop idle servers & restart upon focus; keep your RAM usage low
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lsp_timeout.lua
  lsp_timeout = {
    enable = true,
    event = "LspAttach",
    -- wait 5 minutes before stopping all LSP servers
    stopTimeout = 1000 * 60 * 5,
    startTimeout = 1000 * 10,
    silent = true,
  },
  -- Syntax Highlighting
  treesitter = {
    enable = true,
    -- event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    ensure_installed = {
      "lua",
      "luadoc",
      "luap",
      "regex",
    },
    -- enhanced %
    -- ~/.config/nvim/Gl0riVim/plugins/coding/treesitter/tree_pairs.lua
    -- HACK: Disabled: 08/05/2024
    tree_pair = {
      enable = false,
    },
    extensions = {
      -- Commentstring options based on cursor location
      -- ~/.config/nvim/Gl0riVim/plugins/coding/treesitter/comment_string.lua
      commentstring = {
        enable = true,
        lazy = true,
        event = nil,
      },
      -- Syntax aware text-objects, select, move, swap, and peek support
      -- ~/.config/nvim/Gl0riVim/plugins/coding/treesitter/text_objects.lua
      text_objects = {
        enable = true,
        event = "VeryLazy",
      },
      RRethy_text_objects = {
        -- HACK: Disabled: 2024-02-03
        enable = false,
        event = "VeryLazy",
      },
      -- Show code context, Note: It's the lil window under the winbar
      --  ~/.config/nvim/Gl0riVim/plugins/coding/treesitter/context.lua
      context = {
        -- HACK:Disabled: 2024-02-03
        enable = false,
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      },
      -- Automatically add closing tags for HTML and JSX
      --  ~/.config/nvim/Gl0riVim/plugins/coding/treesitter/autotag.lua
      autotag = {
        enable = true,
        event = nil, -- { "BufReadPost", "BufNewFile", "BufWritePre" }
        ft = {
          "astro",
          "html",
          "htm",
          "php",
          "asp",
          "aspx",
          "jsp",
          "gjs",
          "gts",
          "JavaScript",
          "js",
          "jsx",
          "handlebars",
          "md",
          "mdown",
          "mkdn",
          "mkd",
          "mdwn",
          "resi",
          "res",
          "svelte",
          "cjs",
          "ts",
          "tsx",
          "vue",
          "hbs",
          "xml",
        },
      },
    },
  },
  -- Formatter
  -- ~/.config/nvim/Gl0riVim/plugins/coding/formaaters_linters/conform.lua
  conform = {
    enable = true,
    lazy = true,
    event = "VeryLazy", -- { "BufReadPre", "BufNewFile" },
    keymaps = {
      key = "<leader>CC",
      cmd = "<cmd>ConformInfo<cr>",
      desc = "Conform 󰝕 ",
    },
  },
  -- Linter
  -- ~/.config/nvim/Gl0riVim/plugins/coding/formaaters_linters/linter.lua
  nvim_lint = {
    enable = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  },
  -- completion source
  -- ~/.config/nvim/Gl0riVim/plugins/coding/cmp.lua
  -- ~/.config/nvim/Gl0riVim/plugins/00_config/cmp.lua
  cmp = {
    event = { "InsertEnter", "CmdlineEnter" },
  },
  -- snippets engine
  -- config  = ~/.config/nvim/Gl0riVim/plugins/coding/snippets_engine.lua
  luasnip = {
    enable = true,
    keymaps = {
      jump_next_snippet = {
        key = "<Tab>",
        desc = "Jumb to NEXT snippet",
      },
      jump_prev_snippet = {
        key = "<S-Tab>",
        desc = "Jumb to PREV snippet",
      },
    },
  },
  -- auto-close parentheses
  -- ~/.config/nvim/Gl0riVim/plugins/coding/autopairs.lua
  autopairs = {
    enable = true,
    event = "VeryLazy",
  },
  -- when you the mapped key and the line to the left of the cursor isn't all whitespace,
  -- the cursor will jump to the end of the syntax tree's parent node
  -- ~/.config/nvim/Gl0riVim/plugins/coding/autopairs.lua
  smart_tab = {
    enable = true,
    event = "VeryLazy",
    key = "<C-t>",
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/inlayhints.lua
  --  ~/.config/nvim/Gl0riVim/plugins/00_config/lsp/inlayhints.lua
  -- HACK:Disabled: 2024-02-03
  -- wait for the builtin inlayhints
  -- see autocmds.lua for the current autocommand
  inlayhints = {
    enable = false,
    event = nil,
  },
  -- comment utility
  -- ~/.config/nvim/Gl0riVim/plugins/coding/comment.lua
  -- HACK: wait for the bulitin comment (gcc)
  comment = {
    enable = true,
    event = nil,
    keymaps = {
      line_wise = {
        key = "<leader>cc",
        desc = "Comment toggle current Line",
        mode = { "n", "v" },
      },
      block_wise = {
        key = "<leader>cb",
        desc = "Comment toggle current Line",
        mode = { "n", "v" },
      },
      add_comment_above = {
        key = "<leader>ak",
        desc = "Comment Above 󰁝 ",
        mode = "n",
      },
      add_comment_below = {
        key = "<leader>aj",
        desc = "Comment Below 󰁅 ",
        mode = "n",
      },
      add_comment_eol = { -- end of line
        key = "<leader>al",
        desc = "Comment @EOL  ",
        mode = "n",
      },
    },
  },
  -- winbar
  -- ~/.config/nvim/Gl0riVim/plugins/coding/barbecue.lua
  barbecue = {
    enable = true,
    event = "LspAttach",
  },
  -- symbol usage
  -- ~/.config/nvim/Gl0riVim/plugins/coding/symbol_usage.lua
  symbol_usage = {
    enable = true,
    event = "LspAttach",
  },
  -- noicer LSP UI
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lspsaga.lua
  -- HACK: Disabled: 2024-05-07
  -- this plugin is amazing, BUT TOO HEAVY
  lspsaga = {
    enable = false,
    event = "LspAttach",
    cmd = "Lspsaga",
    keys = {
      { "<leader>cS", "<cmd>Lspsaga outline<cr>", desc = "Symbol Outline  " },
      { "<leader>cO", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing Calls  " },
      { "<leader>cI", "<cmd>Lspsaga incoming_calls<cr>", desc = "Ingoing Calls   " },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/trouble.lua
  trouble = {
    enable = true,
    event = nil,
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      { "<F7>", "<cmd>TroubleToggle<cr>", desc = "Show Current Buffer Diagnostics  " },
      { "<F8>", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Show Workspace Diagnostics  " },
    },
  },
  -- Split/Join Blocks of code ( arrays, hashes, statements...etc )
  --  ~/.config/nvim/Gl0riVim/plugins/coding/split_join.lua
  -- HACK: Visit after a while to disable 2024-05-07
  split_join = {
    enable = true,
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
      {
        "<leader>tj",
        "<cmd>TSJToggle<CR>",
        desc = "Toggle Split/Join 󱤗 ",
      },
    },
  },
  -- window for previewing, navigating and editing LSP locations
  --  ~/.config/nvim/Gl0riVim/plugins/coding/glance.lua
  glance = {
    -- HACK: Disabled: 2024-02-03
    enable = false,
    cmd = "Glance",
    keys = {
      { "gd", "<cmd>Glance definitions<CR>", desc = "GoTo Definition 󰡸 " },
      { "gr", "<cmd>Glance references<CR>", desc = "Show references 󱘭 " },
      { "gi", "<cmd>Glance implementations<CR>", desc = "GoTo Implementation 󰝮 " },
      { "gt", "<cmd>Glance type_definitions<CR>", desc = "GoTo Type Definition  " },
    },
  },
  -- highlight sections of code which might have security or quality issues
  --  ~/.config/nvim/Gl0riVim/plugins/coding/secureitree.lua
  secureitree = {
    -- HACK: Disabled: 2024-02-03
    enable = false,
  },
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                          LANGS CONTROL
--      ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/*.lua
--
--   ╘═════════════════════════════════════════════════════════╛
--   ╞══════════════╡ Configured (langs/servers): ╞════════════╡
--  Clangd
--  CMake
--  Docker
--  Elixir
--  Go
--  Eslint
--  Graphql
--  Emmetls
--  Tailwind
--  CSS
--  HTML
--  Hypr
--  Json
--  Java
--  Markdown
--  Prisma
--  Python
--  Ruby
--  Rust
--  Fish
--  ZSH
--  Bash
--  Svelte
--  Terraform
--  Typescript
--  Vim
--  Vue
--  Yaml
conf.langs_control = {
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/c.lua
  clangd = {
    enable = true,
    ft = { "c", "cpp" },
    ts_clangd = true, -- treesitter: clangd
    extension = true, -- installs: (https://github.com/p00f/clangd_extensions.nvim)
    keys = {
      { "<leader>clca", "<cmd>ClangdAST<cr>", desc = "AST " },
      { "<leader>clch", "<cmd>ClangdTypeHierarchy<cr>", desc = "Type Hierarchy  " },
      { "<leader>clcS", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source Header  " },
      { "<leader>clcs", "<cmd>ClangdSymbolInfo<cr>", desc = "Symbol Info  " },
      { "<leader>clct", "<cmd>ClangdToggleInlayHints<cr>", desc = "Toggle InlayHints 󰔡 " },
      { "<leader>clcm", "<cmd>ClangdMemoryUsage<cr>", desc = "Memory Usage 󰍛 " },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/langs/cmake.lua
  cmake = {
    enable = false, -- mason: "cmakelang", "cmakelint", "neocmakelsp": Note: "neomakelsp" requires "rust" to be installed
    cmake_tools = true, -- installs: ( https://github.com/Civitasv/cmake-tools.nvim )
    ts_cmake = true, -- treesitter: cmake
    lint_cmake = false, -- (optional, with nvim_lint): uses "cmakelint"
    nonels_cmake = false, --(optional, with none-ls): uses "cmake_lint"
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/database.lua
  database = {
    enable = false,
    keys = {
      { "<leader>cldt", "<cmd>DBUIToggle<cr>", desc = "Toggle UI  " },
      { "<leader>cldf", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer  " },
      { "<leader>cldr", "<cmd>DBUIRenameBuffer<cr>", desc = "Rename Buffer 󰑕 " },
      { "<leader>cldq", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Info 󰑆 " },
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/langs/docker.lua
  docker = {
    enable = false, -- mason: "hadolint"
    ts_docker = true, -- treesitter: "dockerfile"
    lint_docker = false,
    nonels_docer = false,
  },
  --~/.config/nvim/Gl0riVim/plugins/coding/langs/elixir.lua
  elixir = {
    enable = false, -- mason: "elixir-ls"
    ts_elixir = true, -- treesitter: "elixir", "heex", "eex"
    neotest_elixir = true,
    nonels_elixir = true, -- uses "credo" if executable
    lint_elixir = true, -- uses "credo" if executable
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/langs/go.lua
  go = {
    enable = false, -- mason: "gomodifytags", "impl", "goimports", "gofumpt", "delve"
    ts_go = true, -- treesitter:  "go", "gomod", "gowork", "gosum"
    neotest_go = true,
    nonels_go = false,
    conform_go = true,
    keys = {
      { "<leader>td", "<cmd>lua require('dap-go').debug_test()<CR>", desc = "Debug Nearest (Go)" },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/eslint.lua
  -- conf.enable_langs_eslint = false -- js
  -- conf.enable_esclintd_mason = false -- Mason installs --> "eslint_d"
  eslint = {
    enable = false, -- lspconfig js
    mason_eslint = true, -- mason: "eslint_d"
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/graphql.lua
  graphql = {
    enable = false,
    conform_graphql = true, -- uses: "graphql"
    mason_sqlls = true, -- mason: "sqlls"
    ts_graphql = true, -- treesitter: "graphql"
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/html_css.lua
  html_css = {
    enable_emmetls = true, -- lspconfig
    mason_emmitls = true, -- mason: "emmitls"
    ts_html_css = true, -- treesitter: "html", "css"
    enable_html = true, -- lspconfig
    enable_htmx = true,
    enable_css = true, -- lspconfig
    conform_css = true, -- uses "prettier"
    mason_tailwind = true, -- mason: "tailwindcss-language-server"

    conform_html = true, -- uses "prettier"
    mason_cssmodules = true, -- mason: "cssmodules_ls"
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/langs/hypr.lua
  hypr = {
    enable = true, -- installs --> https://github.com/luckasRanarison/tree-sitter-hypr
    event = "BufRead */hypr/*.conf",
  },
  --~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/jsonls.lua
  json = {
    enable = true, -- lspconfig
    mason_json = true, -- mason: json-lsp
    conform_json = false, -- uses: "prettier"
    ts_json = true, -- treesitter:  "json", "json5", "jsonc"
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/java.lua
  -- Note: uses 'jdtls' as a formatter
  java = {
    enable = true, -- installs (https://github.com/nvim-java/nvim-java)
    jdtls = false,
    ts_java = true,
    keys = {
      { "<leader>cljd", "<cmd>JavaDapConfig<cr>", desc = "DAP Config  " },
      { "<leader>cljc", "<cmd>JavaTestDebugCurrentClass<cr>", desc = "Test Current Class  " },
      { "<leader>cljC", "<cmd>JavaTestRunCurrentClass<cr>", desc = "Run Current Class  " },
      { "<leader>cljm", "<cmd>JavaTestDebugCurrentMethod<cr>", desc = "Test Current Method  " },
      { "<leader>cljM", "<cmd>JavaTestRunCurrentMethod<cr>", desc = "Run Current Method  " },
      { "<leader>cljl", "<cmd>JavaTestViewLastReport<cr>", desc = "View Last Report  " },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/markdown.lua
  markdwon = {
    enable = true,
    conform_markdown = true, -- uses: "prettier"
    ts_markdwon = true, -- treesitter: "markdown", "markdown_inline"
    --  ~/.config/nvim/Gl0riVim/plugins/utils/markdown.lua
    markdown_preview = {
      enable = true, -- installs (https://github.com/iamcco/markdown-preview.nvim)
      keys = {
        { "<leader>clm", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview  ", ft = "markdown" },
      },
    },
    markdown_headlines = false, -- installs (https://github.com/lukas-reineke/headlines.nvim)
    md_better_headlines = {
      enable = true, -- installs (https://github.com/MeanderingProgrammer/markdown.nvim)
      ft = { "markdown", "org", "norg" },
      headings = { " ", "  ", "   ", "    ", "     ", "      " },
      -- headings = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
      dash = "—",
      -- bullets = { "●", "○", "◆", "◇" },
      bullets = { "◉", "○", "✸", "✿" },
      unchecked = "󰄱 ",
      checked = " ",
      quote = "┃",
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/prisma.lua
  prisma = {
    enable = false,
    mason_prsima = true, -- mason: "prisma-languga-server"
    conform_prisma = true,
    ts_prisma = true, -- treesitter: "prisma"
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/python.lua
  python = {
    enable = true,
    mason_pyright = true, -- mason: "pyright"
    ts_python = true, -- treesitter: "ninja", "python", "rst", "toml"
    env_select = true, -- installs (https://github.com/linux-cultist/venv-selector.nvim)
    conform_python = true, -- uses: "black", "isort"
    dap_python = true, -- installs: (https://github.com/mfussenegger/nvim-dap-python)
    -- HACK: Disabled: 2024-02-03
    semshi_python = false, -- semantic highlighting for python
    neotest_python = true,
    keys = {
      select_venv = { "<leader>clps", "<cmd>VenvSelect<cr>", desc = "Select Virtual Env  " },
      dap_python_keys = {
        {
          "<leader>clpc",
          function()
            require("dap-python").test_method()
          end,
          desc = "Test Class  ",
          ft = "python",
        },
        {
          "<leader>clpm",
          function()
            require("dap-python").test_class()
          end,
          desc = "Test Method  ",
          ft = "python",
        },
      },
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/ruby.lua
  ruby = {
    enable = false,
    mason_ruby = true, -- mason: "solargraph"
    ts_ruby = true, -- treesitter: "ruby"
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/rust.lua
  rust = {
    enable = true, -- installs(https://github.com/Saecki/crates.nvim & https://github.com/simrat39/rust-tools.nvim)
    ts_rust = true, -- treesitter: "ron", "rust", "toml"
    mason_rust = true, -- , "codelldb"
    keys = {
      { "<leader>clrh", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
      { "<leader>clra", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
      { "<leader>clrd", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
    },
  },
  -- Bash, ZSH, Fish
  -- ~/.config/nvim/Gl0riVim/plugins/coding/langs/shells.lua
  shells = {
    enable = true,
    mason_bash = true, -- mason: "bashls", "shellcheck", "shfmt"
    conform_shells = true, -- uses: "shfmt", "fish_indent"
    ts_bash = true, -- treesitter: "bash"
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/langs/svelte.lua
  svelte = {
    enable = false,
    mason_svelte = true, -- mason:  "svelte-language-server"
    ts_svelte = true, -- treesitter: "svelte"
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/langs/terraform.lua
  terraform = {
    enable = false, -- mason: "terraformls"
    ts_terraform = true, -- treesitter: "terraform", "hcl"
    nonels_terraform = false,
    lint_terraform = false,
    conform_terraform = false,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/typescript.lua
  typescript = {
    typescript_type = "tsserver", -- Available: tsserver | tools | none
    mason_ts = true, -- mason: "typescript-language-server"
    ts_error_translator = true,
    conform_typescript = true, -- uses --> "prettier" for "javascript", "javascriptreact", "typescript", "typescriptreact"
    ts_typscript = true, -- treesitter: "typescript", "javascript", "svelte", "tsx"
    --  Asynchronous interface to run project-wide TypeScript type-checking using the compiler (tsc)
    enable_tsc = true, -- installs (https://github.com/dmmulroy/tsc.nvim)
    enable_template_string = true, -- installs (https://github.com/axelvc/template-string.nvim)
    keys = {
      ts_organize = "<leader>clto",
      ts_reaname_file = "<leader>cltr",
      ts_import_all = "<leader>clti",
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/vimls.lua
  vimls = {
    enable = true,
    mason_vim = true, -- mason: "vimls"
    ts_vim = true, -- treesitter: "vim", "vimdoc"
  },
  -- ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/vuels.lua
  vue = {
    enable = true,
    conform_vue = true, -- uses; "prettier"
    mason_vue = true, -- mason: "vue-language-server"
    ts_vue = true, -- treesitter: "vue"
  },
  --  ~/.config/nvim/Gl0riVim/plugins/coding/lsp/langs/yamlls.lua
  yaml = {
    enable = true,
    conform_yaml = true, -- uses: "prettier"
    mason_yaml = true, -- installs: "yaml-language-server", "yamllint"
    ts_yaml = true, -- treesitter: "yaml"
  },
}
--  ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--  ┃                                                          ┃
--  ┃                       DIAGNOSTICS                        ┃
--  ┃                                                          ┃
--  ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
-- Available: none | icons | popup
--   "none":  diagnostics are disabled but still underlined
--   "icons": only an icon will show
--   "popup": an icon will show and a popup with the diagnostic will appear
conf.show_diagnostics = "popup"
conf.update_in_insert = false
conf.virtual_text = true
--   ╒═════════════════════════════════════════════════════════╕
--
--                             EDITOR
--
--   ╘═════════════════════════════════════════════════════════╛
conf.editor_plugins = {
  -- Note: which-key is also configured
  -- ~/.config/nvim/Gl0riVim/plugins/editor/keymap_helper.lua
  legendary = {
    enable = true,
    cmd = "Legendary",
    keys = {
      { "<leader><leader>", "<cmd>Legendary<cr>", desc = "Search Keymaps " },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/editor/keymap_helper.lua
  hawtkeys = { -- finding & suggesting memorable and easy-to-press keys
    -- HACK: Disabled: 2024-02-03
    enable = false,
    cmd = { "Hawtkeys", "HawtkeysAll", "HawtkeysDupes" },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/editor/telescope.lua
  trelescope = {
    enable = true,
    cmd = "Telescope",
    nvchad_borderchars = false,
    find_files_show_hidden = true,
    grep_hidden = true, -- enable grepping in hidden files
    reverse_directories = true, -- reverse path display with highlighting
    keys = {
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
    --  ~/.config/nvim/Gl0riVim/plugins/editor/telescope_extentions.lua
    extensions = {
      zoxide = { -- smart directory picker
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>tvz", "<cmd>Telescope zoxide list<cr>", desc = "Zoxide" },
      },
      file_browser = { -- creation, deletion, renaming, and moving of files and folders
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>fb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      },
      fzf_native = { -- fzf current buffer
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "FZF (Current Buffer)" },
      },
      markdwon_heading = { -- Switch between document's headings (Markdown, AsciiDoc, rst, org, latex, and Vim Help)
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>tvh", "<cmd>Telescope heading<cr>", desc = "Search Headings" },
      },
      make = { -- run GNU Make targets
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>tm", "<cmd>Telescope make<cr>", desc = "Run make" },
      },
      freq_search = { -- (F)recency sorting for all Telescope pickers
        -- HACK:Disabled: 2024-02-03
        enable = false,
      },
      http = { -- investigate HTTP status codes
        -- HACK:Disabled: 2024-02-03
        enable = false,
      },
      license = { --  view & paste common softwre licenses
        -- HACK:Disabled: 2024-02-03
        enable = false,
      },
      tabs = { -- view & close tabs
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>tvt", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "View Tabs" },
      },
      undo = { -- view UNDOs
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>tvu", "<cmd>Telescope undo<cr>", desc = "View UNDOs" },
      },
      docker = { --  manage docker(containers, images, networks, volumes, contexts,
        -- HACK:Disabled: 2024-02-03
        enable = false,
        keys = { "<leader>tvd", "<cmd>Telescope docker<cr>", desc = "View Dockers" },
      },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/editor/bufferline.lua
  bufferline = {
    enable = true,
    event = "VeryLazy",
    keys = {
      { "<leader>bb", "<cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Back   " },
      { "<leader>bn", "<cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Next   " },
      { "<leader>bcl", "<cmd>BufferLineCloseLeft<CR>", desc = "Buffer to the LEFT  " },
      { "<leader>bcr", "<cmd>BufferLineCloseRight<CR>", desc = "Buffer to the RIGHT  " },
      { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "Pick A Buffer  " },
      { "<leader>bP", "<cmd>BufferLineTogglePin<CR>", desc = "Pin A Buffer 󰐃 " },
      { "<leader>bsd", "<cmd>BufferLineSortByDirectory<CR>", desc = "Sort By Directory  " },
      { "<leader>bsr", "<cmd>BufferLineSortByExtension<CR>", desc = "Sort By Relative Directory 󰑒 " },
      { "<leader>bse", "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort By Extension  " },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/editor/buffremove.lua
  buff_remove = { -- Remove a buffer without a punch on my face :)
    enable = true,
    keys = {
      {
        "Q",
        function()
          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end
        end,
        desc = "Remove Current Buffer ",
      },
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/editor/todo_comments.lua
  todo_comments = { -- Highlight TODOsss
    enable = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = "TodoTelescope",
    keys = {
      -- stylua: ignore start
      {
        "<leader>//",
        "<cmd>TodoTelescope keywords=FIX,FIXME,FIXES,FIXIT,BUG,BUGS,ISSUE,ISSUES,TODO,TIP,TIPS,HACK,WARN,WARNING,PERF,PERFORMANCE,OPTIMIZE,HINT,HINTS,NOTE,NOTES,INFO,INFOS<cr>",
        desc = "All 󱨰 ",
      },
      { "<leader>/b", "<cmd>TodoTelescope keywords=BUG,BUGS<cr>", desc = "BUG 󰃤 " },
      { "<leader>/f", "<cmd>TodoTelescope keywords=FIX,FIXME,FIXES,FIXIT<cr>", desc = "FIX 󰁨 " },
      { "<leader>/H", "<cmd>TodoTelescope keywords=HINT,HINTS<cr>", desc = "HINT 󱠃 " },
      { "<leader>/h", "<cmd>TodoTelescope keywords=HACK<cr>", desc = "HACK 󰈸 " },
      { "<leader>/I", "<cmd>TodoTelescope keywords=INFO,INFOS<cr>", desc = "INFO  " },
      { "<leader>/i", "<cmd>TodoTelescope keywords=ISSUE,ISSUES<cr>", desc = "ISSUE  " },
      { "<leader>/n", "<cmd>TodoTelescope keywords=NOTE,NOTES<cr>", desc = "NOTE 󰠮 " },
      { "<leader>/p", "<cmd>TodoTelescope keywords=PERF,PERFORMANCE,OPTIMIZE<cr>", desc = "PERFORMANCE 󰥔 " },
      { "<leader>/t", "<cmd>TodoTelescope keywords=TODO<cr>", desc = "TODO  " },
      { "<leader>/T", "<cmd>TodoTelescope keywords=TIP,TIPS<cr>", desc = "TIP 󰴓 " },
      { "<leader>/w", "<cmd>TodoTelescope keywords=WARN,WARNING<cr>", desc = "WARN  " },
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO  " },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO  " },
      -- stylua: ignore end
    },
  },
  -- = ~/.config/nvim/Gl0riVim/plugins/editor/nvim_surround.lua
  nvim_surround = { -- Add, delete, change surroundings
    enable = true,
    event = "BufReadPost",
    keymaps = {
      add_surround = "<leader>as",
      delete_surrond = "<leader>ds",
      change_surround = "<leader>cs",
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/editor/focus.lua
  focus = {
    zenmode = { -- Distraction-free coding
      enable = true,
      keys = { { "<leader>tz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode 󱧐 " } },
      terminal_support = {
        kitty = { enable = true, font = "+4" },
        alacritty = { enabled = false, font = "14" },
        wezterm = { enabled = false, font = "+4" },
      },
    },
    twilight = { -- dim inactive portions of the code
      enable = true,
      keys = { { "<leader>tw", "<cmd>Twilight<cr>", desc = "Toggle Twilight 󰱌 " } },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/editor/motion.lua
  motion = {
    strategy = "flash", -- Available: hop | flash | leap | none,
    flash_opts = {
      event = nil,
      search_enable = false, -- enable flash in search mode
      rainbow = {
        enabled = true,
        shade = 5,
      },
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            require("flash").jump()
          end,
          desc = "Flash  ",
        },
        {
          "S",
          mode = { "n", "o", "x" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter  ",
        },
        {
          "r",
          mode = "o",
          function()
            require("flash").remote()
          end,
          desc = "Remote FLASH  ",
        },
        {
          "<leader>EF",
          mode = { "n" },
          function()
            require("flash").toggle(true)
          end,
          desc = "Enable Flash",
        },
        {
          "<leader>Ef",
          mode = { "n" },
          function()
            require("flash").toggle(false)
          end,
          desc = "Disable Flash",
        },
      },
    },
    leap_opts = {
      event = nil,
      keys = {
        { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
        { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
        { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
      },
    },
    hop_opts = {
      event = nil,
      cmd = {
        "HopAnywhere",
        "HopChar1",
        "HopChar2",
        "HopLine",
        "HopLineStart",
        "HopVertical",
        "HopPattern",
        "HopWord",
      },
      -- see --> ~/.config/nvim/Gl0riVim/plugins/00_config/motion_hop.lua
      keys = {},
    },
  },
  -- = ~/.config/nvim/Gl0riVim/plugins/editor/file_explorer.lua
  -- = ~/.config/nvim/Gl0riVim/plugins/00_config/neo-tree.lua
  -- = ~/.config/nvim/Gl0riVim/plugins/00_config/nvim-tree.lua
  file_explorer = {
    strategy = "neo-tree", -- Available: neo-tree, nvim-tree, ranger or none
    nvim_tree_opts = {
      keys = {
        { "<leader>e", "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>", desc = "File Explorer  " },
      },
      cmd = {
        "NvimTreeOpen",
        "NvimTreeClose",
        "NvimTreeToggle",
        "NvimTreeFindFile",
        "NvimTreeFindFileToggle",
      },
    },
    neo_tree_opts = {
      cmd = "Neotree",
      keys = {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = require("util").get_root() })
          end,
          desc = "File Explorer  ",
          remap = true,
        },
      },
    },
    ranger_opts = {
      cmd = "RnvimrToggle",
      keys = { "<leader>e", "<cmd>RnvimrToggle<cr>", desc = "File Explorer  " },
    },
  },
  -- better text objects
  -- ~/.config/nvim/Gl0riVim/plugins/editor/mini_ai.lua
  mini_ai = {
    enable = true,
    event = "BufReadPre",
  },
  -- Rainbow Parentheses
  --  ~/.config/nvim/Gl0riVim/plugins/editor/rainbow_delimiters.lua
  rainbow_delimiters = {
    enable = true,
    event = "VeryLazy",
  },
  -- Prevent the cursor from moving when using shift and filter actions
  -- ~/.config/nvim/Gl0riVim/plugins/editor/stay_in_place.lua
  stay_in_place = {
    -- HACK: Disabled: 2024-02-03
    enable = false,
    event = "VeryLazy",
  },
  -- Betuify your comments with Boxes
  -- ~/.config/nvim/Gl0riVim/plugins/coding/comment.lua
  comment_box = {
    enable = true,
    keys = {}, -- see the plugin's file
  },
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                               UI
--
--   ╘═════════════════════════════════════════════════════════╛
conf.ui_plugins = {
  fidget = {
    enable = false,
    event = "LspAttach",
    normal_hl = "Comment", -- Base highlight group in the notification window
    winblend = 100, -- Background color opacity in the notification window
    border = "none", -- Border around the notification window
    align = "top", -- How to align the notification window
  },
  -- highlight cursor and visual selections in 'cmd mode'
  --  ~/.config/nvim/Gl0riVim/plugins/ui/cmd_and_cursor.lua
  cmd_and_cursor = {
    enable = false,
    event = "VeryLazy",
  },
  -- noicer (vim.ui.select)
  --  ~/.config/nvim/Gl0riVim/plugins/ui/dressing.lua
  dressing = {
    enable = true,
    lazy = true,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/ui/dashboard.lua
  dashboard = {
    strategy = "alpha", -- Available: "alpha" | "none"
    event = "VimEnter",
  },
  --  ~/.config/nvim/Gl0riVim/plugins/ui/indentline.lua
  indent_guide = {
    indent_blank_line = {
      enable = true,
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      list_chars = false,
      indent_style = "colored", -- Available: background | colored | context | listchars | simple | none
      indent_char = "▎", --  "▏"
    },
    mini_inden_scope = {
      enable = true,
      event = { "BufReadPost", "BufNewFile", "BufWritePre" },
      indent_char = "╎", -- "▎", "▏"
    },
  },
  -- Window animations
  --  ~/.config/nvim/Gl0riVim/plugins/ui/flirt.lua
  flirt = {
    -- HACK: Disabled: 2024-02-03
    enable = false,
  },
  -- Pretty fold
  --  ~/.config/nvim/Gl0riVim/plugins/ui/fold.lua
  -- HACK: Disabled: 2024-05-08 16:16
  foldding = {
    enable = true,
    keys = { "zM", "zm", "zO", "zo", "zR", "zr" },
    preview_border = "shadow", -- Available: "none" | "single" | "double" | "rounded" | "solid" | "shadow" | string
  },
  -- color cursur while jumping
  -- ~/.config/nvim/Gl0riVim/plugins/ui/beacon.lua
  -- HACK: Disabled: 2024-05-08 16:16
  beacon = {
    enable = false,
    event = "VeryLazy",
  },
  -- ~/.config/nvim/Gl0riVim/plugins/ui/lspkind.lua
  lspkind = {
    enable = true,
    event = "LspAttach",
  },
  -- ~/.config/nvim/Gl0riVim/plugins/ui/lualine.lua
  lauline = {
    enable = true,
    event = "VeryLazy",
  },
  -- smooth scrolling with neoscroll plugin
  -- ~/.config/nvim/Gl0riVim/plugins/ui/neo_scroll.lua
  neo_scroll = {
    enable = true,
    keys = { "<C-E>", "<C-Y>", "<C-D>", "<C-U>", "<C-B>", "<C-F>", "zb", "zt", "zz" },
  },
  -- Fancy notifications
  -- ~/.config/nvim/Gl0riVim/plugins/ui/notify.lua
  -- HACK: Disabled: 2024-05-08 16:16
  notify = {
    enable = false,
    event = "VeryLazy",
    stages = "fade", -- Available: fade | fade_in_slide_out | slide | static
    keys = {
      {
        "<leader>Nc",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Clear All Notifications 󰂛 ",
      },
    },
  },
  -- noicer nvim UI
  --  ~/.config/nvim/Gl0riVim/plugins/ui/noice.lua
  -- HACK: Disabled: 2024-05-08 16:16
  noice = {
    enable = true,
    event = "VeryLazy",
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline  ",
      },
      {
        "<leader>Nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Last Notifications 󰂝 ",
      },
      {
        "<leader>Nh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Notification History  ",
      },
      {
        "<leader>Na",
        function()
          require("noice").cmd("all")
        end,
        desc = "All Notifications 󰁁 ",
      },
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/ui/colorcolumn.lua
  colorcolumn = {
    smart_column = { -- hiding colorcolumn when unneeded
      enable = true,
      event = { "BufEnter", "TextChanged", "TextChangedI" },
      colorcolumn = { "80", "100" },
      -- Available:
      -- "line": current line
      -- "window": visible part of current window
      -- "file": current file
      scope = "line",
      custom_colorcolumn = {
        python = "79",
      },
    },
  },
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                              UTILS
--
--   ╘═════════════════════════════════════════════════════════╛
conf.utils_plugins = {
  -- highlight chunk
  -- HACK: Disabled: 2024-05-08 19:32
  -- ~/.config/nvim/Gl0riVim/plugins/utils/hl_chunk.lua
  hl_chunk = {
    enable = false,
    event = { "CursorHold", "CursorHoldI" },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/utils/precognition.lua
  -- HACK: Disabled: 2024-05-08 19:32
  -- discovering motions
  precognition = {
    enable = false,
    startVisible = true,
    showBlankVirtLine = true,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/utils/screenkey.lua
  screenkey = {
    enable = true,
    cmd = "Screenkey",
    keys = {
      { "<leader>Es", "<cmd>Screenkey<cr>", desc = "Enable Screenkey 󰧹 " },
    },
    width = 40,
    height = 3,
    border = "rounded",
    compress_after = 4,
    clear_after = 4,
    group_mappings = false,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/utils/track.lua
  -- track files 'harpoon' like
  track = {
    enable = true,
    keys = {
      { "<leader>mm", "<cmd>Track views<cr>", desc = "View Marked Files 󰈈  " },
      { "<leader>mf", "<cmd>Mark<cr>", desc = "Mark File  " },
      { "<leader>mo", "<cmd>MarkOpened<cr>", desc = "Mark Opened Files   " },
      { "<leader>mu", "<cmd>Unmark<cr>", desc = "Unmark File  " },
    },
    cmd = {
      "Mark",
      "Unmark",
      "Track",
      "MarkOpened",
      "SelectMark",
      "StashBundle",
      "RestoreBundle",
      "DeleteBundle",
      "AlternateBundle",
    },
    save_path = vim.fn.expand("$HOME") .. "/.custom_db/nvim/plugins/track/track.json",
    root_path = false,
    disable_history = true, -- save deleted marks
    maximum_history = 20, -- limit history
    border = "rounded",
    width = 60,
    height = 10,
    title_pos = "left", -- row and col will be overridden
    exclude = {
      ["^%.git/.*$"] = false,
      ["^%.git$"] = false,
      ["^LICENSE$"] = false,
    },
    action_keys = {
      close = "q",
      select_all = "v",
      delete_current = "dd",
      delete_all = "D",
      change_mark_view = "s",
      delete_buffer = "<C-b>",
      move_view_next = "<C-j>",
      move_view_previous = "<C-k>",
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/utils/yanky.lua
  yanky = { -- yank history
    enable = true,
    keys = {
      {
        "<leader>y",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Open Yank History 󰋚 ",
      },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" } },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" } },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" } },
    },
    history_length = 100,
    storage = "sqlite", -- Available: "sqlite", "shada"
    storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
    sync_with_ring = true, -- sys clipboard
    highlight = {
      on_put = false,
      on_yank = false,
      timer = 0, -- default '500'
    },
    preserve_cursor_position = true,
    textobj = true,
  },
  -- create tables
  -- ~/.config/nvim/Gl0riVim/plugins/utils/table_mode.lua
  table_mode = {
    enable = true,
    cmd = "TableModeToggle",
    keys = {
      { "<leader>Et", "<cmd>TableModeToggle<cr>", desc = "Toggle Table Mode 󰓫 " },
    },
  },
  -- undo tree "my fav"
  -- ~/.config/nvim/Gl0riVim/plugins/utils/undotree.lua
  undo_tree = {
    enable = true,
    event = "VeryLazy",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree 󰣜 " },
    },
  },
  -- Color Picker
  --  ~/.config/nvim/Gl0riVim/plugins/utils/ccc.lua
  color_picker = {
    enable = true,
    -- cmd = { "CccPick", "CccHighlighterToggle" },
    cmd = nil,
    keys = {
      { "<leader>Cp", "<cmd>CccPick<cr>", desc = "Pick Color  " },
      { "<leader>Ch", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle Color Highlight 󰸱 " },
    },
  },
  -- Enable 'StartupTime' command
  --  ~/.config/nvim/Gl0riVim/plugins/utils/startuptime.lua
  startuptime = {
    -- HACK: Disabled: 2024-05-08 16:16
    enable = false,
    cmd = "StartupTime",
  },
  -- increment/decrement
  --  ~/.config/nvim/Gl0riVim/plugins/utils/dial.lua
  dial = {
    enable = true,
    cmd = {
      "DialIncrement",
      "DialDecrement",
    },
    keys = {
      { "<leader>K", "<cmd>DialIncrement<cr>", desc = "Dial Increment  " },
      { "<leader>J", "<cmd>DialDecrement<cr>", desc = "Dial Decrement  " },
    },
  },
  tmux = {
    -- Navigate between tmux & nvim
    -- ~/.config/nvim/Gl0riVim/plugins/utils/tmux.lua
    tmux_navigator = {
      enable = true,
      event = "VeryLazy",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "Tmux Nav LEFT " } },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "Tmux Nav DOWN " } },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "Tmux Nav UP " } },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "Tmux Nav RIGHT " } },
      },
    },
    -- Create, manage, and switch between tmux sessions
    -- ~/.config/nvim/Gl0riVim/plugins/utils/tmux.lua
    -- HACK: Disabled: 09/05/2024
    tmux_sessionizer = {
      enable = false,
      keys = {
        -- stylua: ignore
        { "<leader>Ts", function() require("workspace") end, desc = "Available Sessions 󱃻 " },
        { "<leader>Tc", desc = "Add Contribute Session 󰊤 " },
        { "<leader>Tm", desc = "Add Mine Session  " },
        { "<leader>Tr", desc = "Add Rice Session 󰈸 " },
      },
      workspaces = {
        -- Warn: visit "tmux.lua"
        { name = "Contribute", path = "~/projects/repos/contribute/", keymap = { "<leader>Tc" } },
        { name = "Mine", path = "~/projects/repos/mine/", keymap = { "<leader>Tm" } },
        { name = "Rice", path = "~/projects/repos/rice/", keymap = { "<leader>Tr" } },
      },
    },
  },
  -- Terminal
  -- ~/.config/nvim/Gl0riVim/plugins/utils/toggleterm.lua
  -- HACK: Disabled: 2024-05-08 16:16
  toggleterm = {
    enable = false,
    cmd = "ToggleTerm",
    open_mapping = [[<c-\>]],
    keys = {
      { "<leader>\\", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal  " },
      { "<leader>t1", "<cmd>:1ToggleTerm<cr>", desc = "Toggle 1st Terminal 󰎤 " },
      { "<leader>t2", "<cmd>:2ToggleTerm<cr>", desc = "Toggle 2nd Terminal 󰎧  " },
      { "<leader>t3", "<cmd>:3ToggleTerm<cr>", desc = "Toggle 3rd Terminal 󰎪  " },
      { "<leader>t4", "<cmd>:34oggleTerm<cr>", desc = "Toggle 4th Terminal 󰎭 " },
      { "<leader>tl", "<cmd>lua _LAZYGIT_TOGGLE()<cr>", desc = "Toggle LazyGit  " },
      -- { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Toggle Node 󰎙 " },
      { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Toggle Python 󰌠 " },
      -- { "<leader>tc", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "Toggle NCDU 󰋊 " },
      { "<leader>tb", "<cmd>lua _BTOP_TOGGLE()<cr>", desc = "Toggle Btop 󱑟 " },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Float Terminal 󱁁 " },
      {
        "<leader>,",
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        desc = "Toggle Horizontal Terminal 󱃧 ",
      },
    },
  },
  -- Multi Replace
  --  ~/.config/nvim/Gl0riVim/plugins/utils/multi_replace.lua
  muren = {
    enable = true,
    cmd = { "MurenToggle", "MurenOpen", "MurenClose", "MurenFresh", "MurenUnique" },
    keys = {
      {
        "<F5>",
        "<cmd>MurenToggle<cr>",
        desc = "Toggle Multi Replace  ",
      },
    },
  },
  git_blame = {
    enable = true,
    cmd = { "BlameToggle" },
    event = nil,
    -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = {
      {
        "<leader>gv",
        "<cmd>BlameToggle virtual<cr>",
        desc = "Toggle Blame 'Virtual' ",
      },
      {
        "<leader>gw",
        "<cmd>BlameToggle window<cr>",
        desc = "Toggle Blame 'Window' ",
      },
    },
    date_format = "%d-%m-%Y",
    virtual_style = "right",
    commit_detail_view = "vsplit",
    mappings = {
      commit_info = "i",
      stack_push = "<TAB>",
      stack_pop = "<BS>",
      show_commit = "<CR>",
      close = { "<esc>", "q" },
    },
  },
  -- Note: slows down the startuptime
  git_signs = {
    enable = true,
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    ts_git = true, -- Treesitter: "diff", "gitcommit"
    keymaps = {
      next_hunk = "<leader>ghj",
      prev_hunk = "<leader>ghk",
      stage_hunk = "<leader>ghS",
      stage_buffer = "<leader>ghs",
      reset_hunk = "<leader>ghr",
      preview_hunk = "<leader>ghp",
      undo_stage_hunk = "<leader>ghu",
      reset_buffer = "<leader>ghR",
      diff_this = "<leader>ghd",
      toggle_deleted = "<leader>ght",
      blame_line = "<leader>gb",
      text_object = "<leader>ghi",
    },
  },
  git_dev = {
    enable = true,
    keys = {
      {
        "<leader>go",
        function()
          local repo = vim.fn.input("Repository name / URI: ")
          if repo ~= "" then
            require("git-dev").open(repo)
          end
        end,
        desc = "Open a remote git repository 󰊢 ",
      },
      {
        "<leader>gx",
        "<cmd>GitDevCleanAll<cr>",
        desc = "Clean a cloned git repository 󰊢 ",
      },
    },
    ephemeral = false, -- delete opened repo when exiting nvim, use `GitDevCleanAll` to clean
    read_only = true, -- open repositories to be read-only
    cd_type = "tab", -- Available: global|tab|window|none
    -- repositories_dir = vim.fn.stdpath("cache") .. "/git-dev",
    repositories_dir = vim.fn.expand("$HOME") .. "/.custom_db/nvim/plugins/git_dev/cloned/",
    base_uri_format = "https://github.com/%s.git",
    clone_args = "--jobs=2 --single-branch --recurse-submodules " .. "--shallow-submodules",
    fetch_args = "--jobs=2 --no-all --update-shallow -f --prune --no-tags",
    checkout_args = "-f --recurse-submodules", -- Arguments for `git checkout`.
  },
  -- Emojies picker
  -- ~/.config/nvim/Gl0riVim/plugins/utils/emoji_picker.lua
  emojies_picker = {
    nerd_emojies = {
      enable = true,
      cmd = "Nerdy",
      keys = {
        { "<leader>fen", "<cmd>Nerdy<cr>", desc = "Nerd Fonts Emoji 󰱸 " },
      },
    },
  },
  pomodoro = {
    nomodoro = { -- (https://github.com/dbinagi/nomodoro)
      -- HACK: Disabled: 2024-02-03
      enable = false,
      cmd = { "NomoWork", "NomoBreak", "NomoStop", "NomoStatus", "NomoMenu" },
      keys = {
        { "<F4>", "<cmd>NomoMenu<cr>", desc = "Pomodoro Start  " },
        { "<F16>", "<cmd>NomoStatus<cr>", desc = "Pomodoro Menu 󰍜 " }, -- Shift + <F4>
      },
      on_startup = true,
      work_time = 25,
      break_time = 5,
    },
  },
  code_snap = {
    -- ~/.config/nvim/Gl0riVim/plugins/utils/code_snap.lua
    enable = true,
    cmd = { "CodeSnap", "CodeSnapSave" },
    code_font_family = "CaskaydiaCove Nerd Font",
    save_path = "~/Pictures/Screenshots/",
    parsed = "~/Pictures/y-m-d_at_h:m:s.png",
    bg_theme = "default", -- Available: "default" | "bamboo" | "sea" | "beach" | "grape" | "dusk" | "summer"
    has_breadcrumbs = true,
    breadcrumbs_separator = "/",
    watermark_font_family = "Pacifico",
    watermark = "Gl00ria",
  },
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                            AI thingy
--
--   ╘═════════════════════════════════════════════════════════╛
conf.ai_plugins = {
  -- Codeium Source for 'CMP'
  -- ~/.config/nvim/Gl0riVim/plugins/coding/AIs.lua
  codeium = {
    -- HACK: Disabled: 2024-02-03
    enable = false,
    event = "InsertEnter",
    cmd = "Codeium",
  },
  -- TabNine Source for 'CMP'
  tabnine = {
    -- HACK: Disabled: 2024-02-03
    enable = false,
    event = "InsertEnter",
  },
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                              GAMES
--
--   ╘═════════════════════════════════════════════════════════╛
conf.games_plugins = {
  --  ~/.config/nvim/Gl0riVim/plugins/games/black_jack.lua
  -- HACK:
  black_jack = {
    enable = false,
    cmd = "BlackJackNewGame",
    keys = { { "<leader>Gb", "<cmd>BlackJackNewGame<CR>", desc = "Black Jack 󰘸 " } },
    card_style = "large", -- Available: "mini" | "large".
    suit_style = "black", -- Available: "black" | "white".
  },
  --  ~/.config/nvim/Gl0riVim/plugins/games/cellular_automation.lua
  -- HACK:
  cellular_automation = {
    enable = false,
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>G1", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain  " },
      { "<leader>G2", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Game of Life  " },
      { "<leader>G3", "<cmd>CellularAutomaton scramble<CR>", desc = "Scramble 󰣄 " },
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/games/duck.lua
  -- HACK:
  duck = {
    enable = false,
    keys = {}, -- see --> duck.lua
  },
  -- ~/.config/nvim/Gl0riVim/plugins/games/hack.lua
  -- HACK:
  hack = {
    enable = false,
    cmd = { "HackAuto", "Hack", "HackFollow", "HackFollowAuto" },
    keys = {
      { "<leder>G4", "<cmd>HackFollow<cr>", desc = "Manual Current Buffer  " },
      { "<leder>G5", "<cmd>HackFollowAuto<cr>", desc = "Auto Current Buffer  " },
      { "<leder>G6", "<cmd>HackAuto<cr>", desc = "Auto  " },
    },
  },
  -- ~/.config/nvim/Gl0riVim/plugins/games/hardtime.lua
  hardtime = {
    enable = true,
    event = "VeryLazy",
    keys = {
      { "<leader>Gf", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime  " },
    },
    max_count = 4,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/games/speed_typer.lua
  -- HACK: Disabled: 2024-05-08 16:21
  speed_typer = {
    enable = true,
    cmd = "Speedtyper",
    keys = {
      { "<leader>Gt", "<cmd>Speedtyper<cr>", desc = "Typing Practise 󰌌 " },
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/games/sudoku.lua
  -- HACK:
  sudoku = {
    enable = false,
    cmd = "Sudoku",
    keys = {
      { "<leader>Gs", "<cmd>Sudoku<cr>", desc = "Sudoku  " },
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/games/vim_be_good.lua
  -- HACK: Disabled: 2024-05-08 16:22
  vim_be_good = {
    enable = false,
    cmd = "VimBeGood",
    keys = { { "<leader>Gv", "<cmd>VimBeGood<CR>", desc = "Vim Be Good 󰕷 " } },
  },
}
--   ╒═════════════════════════════════════════════════════════╕
--
--                             THEMES
--
--   ╘═════════════════════════════════════════════════════════╛
conf.theme_plugins = {
  -- see --> ~/.config/nvim/Gl0riVim/plugins/themes/00_rando_scheme.lua
  rando_scheme = {
    enable = true,
    keymap = "<leader>r",
    random_startup = true,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/neofusion.lua
  northern = {
    enable = true,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/neofusion.lua
  neofusion = {
    enable = true,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/ariake.lua
  ariake = {
    enable = true,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/monet.lua
  monet = {
    enable = true,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/neon.lua
  neon = {
    enable = true,
    style = "default", -- Available: default | doom | dark | light
    transparency = false,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/nightfox.lua
  nightfox = {
    enable = true,
    transparency = false,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/catppuccin.lua
  catppuccin = {
    enable = true,
    style = "mocha", -- Available: latte | frappe | macchiato | mocha
    transparency = false,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/cyberdream.lua
  cyberdream = {
    enable = true,
    transparency = true,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/doom_one.lua
  doom = {
    enable = true,
    transparency = false,
  },
  -- ~/.config/nvim/Gl0riVim/plugins/themes/gruvbox.lua
  gruvbox = {
    gruvbox_main = {
      enable = true,
    },
    gruvbox_baby = {
      enable = true,
      transparency = 0,
    },
    gruvbox_material = {
      enable = true,
      transparency = 0,
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/min_theme.lua
  min = {
    enable = true,
    style = "dark", -- Available: dark | light
    transparency = false,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/moonlight.lua
  moonlight = {
    enable = true,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/nightcity.lua
  nightcity = {
    enable = false,
    style = "afterlife", -- Available: kabuki | afterlife
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/nord.lua
  nord = {
    enable = true,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/onedark.lua
  ondedark = {
    ondedark_main = {
      enable = true,
      style = "darker", -- Available: dark | darker | cool | deep | warm | warmer | light
      transparency = false,
    },
    ondedark_pro = {
      enable = true,
    },
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/palenightfall.lua
  palenightfall = {
    enable = true,
  },
  --  ~/.config/nvim/Gl0riVim/plugins/themes/tokyo.lua
  tokyo = {
    tokyonight = {
      enable = true,
      style = "moon", -- Available: storm | moon | night | day
      transparency = false,
    },
    tokyohogh = {
      enable = true,
      style = "storm", -- Available: night | storm
    },
    tokydark = {
      enable = true,
      transparency = false,
    },
  },
}

return conf
