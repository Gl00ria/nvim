-- in the eara of plugins you most definitely to have a dublicate keymap,
-- so since I am using which-key, why not:
-- 1. control the description of each one of them
-- 2. find duplicate when setting-up a new one
-- 3. know exactly what/where my keymaps are
--  ╒══════════════════════════════════════════════════════════╕
--  │                                                          │
--  │                    Register Keymaps                      │
--  │                                                          │
--  ╘══════════════════════════════════════════════════════════╛
local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  vim.notify("Plugin [whick-key] failed to load within (plugins/00_config/rg_whichkey)", vim.log.levels.WARN)
end

local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (rg_whichkey.lua)", vim.log.levels.WARN)
  return
end

local coding_keymap = settings.coding_plugins

local whichkey_registered = {
  --            ╒═════════════════════════════════════════════════════════╕
  --            │                                                         │
  --            │                  Coding Plugins                         │
  --            │                                                         │
  --            ╘═════════════════════════════════════════════════════════╛
  -- ~/.config/nvim/Gl0riVim/coding/lsp/lspconfig.lua
  ["<leader>cL"] = {
    name = "+LSP 󰒋 ",
    i = "Info  ",
    I = "Install 󰅢 ",
    o = "Log  ",
    r = "Restart 󰜉 ",
    s = "Start 󰐥 ",
    S = "Stop 󰓛 ",
    u = "Uninstall  ",
  },

  -- ~/.config/nvim/Gl0riVim/coding/lsp/mason.lua
  ["<leader>cM"] = "Mason 󰫑 ",

  -- ~/.config/nvim/Gl0riVim/00_config/lsp/lspkeymaps.lua
  ["K"] = "LSP Hover  ",

  ["<leader>d"] = { name = "+Diagnostics" },
  ["<leader>df"] = "Float Diagnostics  ",
  ["<leader>dt"] = "Toggle Current Line Diagnostics  ",

  ["g"] = {
    name = "+GoTo 󱆤 ",
    b = "Buffer Definition  ",
    d = "GoTo Definition 󰡸 ",
    D = "GoTo Declaration 󰦻 ",
    i = "GoTo Implementation 󰝮 ",
    r = "Show references 󱘭 ",
    s = "Signature Help 󱧃 ",
    t = "GoTo Type Definition  ",
  },
  ["]"] = {
    name = "+Diagnostics Next 󰨮 ",
    d = "Next Diagnostics  ",
    e = "Next Error  ",
    h = "Next Hint  ",
    i = "GoTo indent scope BOTTOM",
    M = "Next Method END  ",
    m = "Next Method START  ",
    w = "Next Warning  ",
  },
  ["["] = {
    name = "+Diagnostics Prev 󰨮 ",
    d = "Prev Diagnostics  ",
    e = "Prev Error  ",
    f = "Float Diagnostics  ",
    h = "Prev Hint  ",
    i = "GoTo indent scope TOP",
    M = "Prev Method END  ",
    m = "Prev Method START  ",
    w = "Prev Warning  ",
  },

  ["<leader>c"] = {
    name = "+Coding 󰘦 ",
    A = "Source Code Action  ",
    a = "LSP code Action  ",
    f = {
      -- ~/.config/nvim/Gl0riVim/coding/formatters_linters/conform.lua
      function()
        require("conform").format({ lsp_fallback = "always" })
        vim.cmd.update()
      end,
      "LSP Format 󰉨 (Conform)",
      mode = { "n", "x" },
    },

    d = "Display symbol info in floating window  ",
    r = "Rename Variable 󰑕 ",

    -- ~/.config/nvim/Gl0riVim/plugins/coding/treesitter/treesitter.lua
    t = {
      name = "+Treesitter 󰐅 ",
      c = { "<cmd>TSConfigInfo<cr>", "Config Info  " },
      i = { "<cmd>TSInstallInfo<cr>", "Install Info  " },
      j = { "<cmd>TSJJoin<cr>", "Join  " },
      m = { "<cmd>TSModuleInfo<cr>", "Module Info 󱄧 " },
      s = { "<cmd>TSJSplit<cr>", "Split 󰃻 " },
    },
    w = {
      name = "+Workspace 󰢩 ",
      a = "Add workspace folder  ",
      r = "Remove workspace folder  ",
      l = "List workspace folders  ",
    },
  },

  ["<leader>q"] = {
    name = "+QuickFix 󰨮 ",
    b = "Send buffer diagnostic to qf  ",
    d = "Diagnostics location list  ",
    w = "Send window diagnostic to qf  ",
  },

  -- ~/.config/nvim/Gl0riVim/plugins/coding/autopairs.lua
  ["<C-T>"] = "Node Jumping",

  -- ~/.config/nvim/Gl0riVim/plugins/coding/comment.lua
  ["<leader>a"] = {
    name = "+Add  ",
    mode = { "n", "v" },
    -- j = coding_keymap.comment.keymaps.add_comment_below.desc,
    -- k = coding_keymap.comment.keymaps.add_comment_above.desc,
    -- l = coding_keymap.comment.keymaps.add_comment_eol.desc,
    x = "Remove Box Comment",
  },
  ["<leader>ab"] = {
    name = "+Box Comment",
    mode = "v",
    a = { "ASCII", mode = "v" },
    b = { "Rounded", mode = "v" },
    c = { "Mix (Double/Single) A", mode = "v" },
    d = { "Double", mode = "v" },
    e = { "Classic Heavy", mode = "v" },
    f = { "Classic", mode = "v" },
    g = { "Dashed Heavy", mode = "v" },
    h = { "Dashed", mode = "v" },
    i = { "Mix (Double/Sinble) B", mode = "v" },
    j = { "Quote A", mode = "v" },
    k = { "Quote B", mode = "v" },
    l = { "Quote C", mode = "v" },
    m = { "Marked A", mode = "v" },
    n = { "Marked B", mode = "v" },
    o = { "Marked C", mode = "v" },
    p = { "Vertically Enclosed A", mode = "v" },
    q = { "Vertically Enclosed B", mode = "v" },
    r = { "Vertically Enclosed C", mode = "v" },
    s = { "Horizontally Enclosed A", mode = "v" },
    t = { "Horizontally Enclosed B", mode = "v" },
    u = { "Horizontally Enclosed C", mode = "v" },
    v = { "Mix (Heavy/Light)", mode = "v" },
  },
  ["<leader>al"] = {
    name = "+Line Comment",
    mode = "v",
    a = "Simple",
    b = "Rounded corner DOWN",
    c = "Rounded corner UP",
    d = "Squared corner DOWN",
    e = "Squared corner UP",
    f = "Squared title",
    g = "Rounded Title",
    h = "Spiked Title",
    i = "Simple Heavy",
    j = "Confined",
    k = "Confined Heavy",
    l = "Simple Weighted",
    m = "Double",
    n = "Double Confined",
    o = "ASCII (A)",
    p = "ASCII (B)",
    q = "ASCII (C)",
  },

  -- ~/.config/nvim/Gl0riVim/plugins/coding/lspsaga.lua
  ["<leader>cS"] = "Symbol Outline  ",
  ["<leader>cO"] = "Outgoing Calls  ",
  ["<leader>cI"] = "Ingoing Calls   ",

  -- ~/.config/nvim/Gl0riVim/plugins/coding/formaaters_linters/conform.lua
  ["<leader>cC"] = { coding_keymap.conform.keymaps.cmd, coding_keymap.conform.keymaps.desc },

  -- ~/.config/nvim/Gl0riVim/plugins/coding/trouble.lua
  ["<F7>"] = "Show Current Buffer Diagnostics  ",
  ["<F8>"] = "Show Workspace Diagnostics  ",

  --  ~/.config/nvim/Gl0riVim/plugins/lsp/langs/*.lua
  ["<leader>cl"] = { name = "+Langs 󱌲" },
  ["<leader>clc"] = { name = "+Clangd 󰙱" }, -- langs/c.lua
  ["<leader>clg"] = { name = "+Go 󰟓 " }, -- langs/go.lua
  ["<leader>clp"] = { name = "+Ptyhon 󰌠 " }, -- langs/python.lua
  ["<leader>clr"] = { name = "+Rust  " }, -- langs/rust.lua
  ["<leader>clt"] = { name = "+Typescript  " }, -- langs/typescript.lua
  ["<leader>clm"] = { name = "+Markdown 󰍔 " }, -- utils/markdown.lua
  ["<leader>clj"] = { name = "+Java  " }, -- langs/java.lua
  ["<leader>cld"] = { name = "+Database  " }, -- coding/database.lua

  -- ~/.config/nvim/Gl0riVim/plugins/editor/split_join.lua
  ["<leader>tj"] = "Toggle Split/Join 󱤗 ",
  --            ╒═════════════════════════════════════════════════════════╕
  --            │                                                         │
  --            │                  Editor Plugins                         │
  --            │                                                         │
  --            ╘═════════════════════════════════════════════════════════╛
  --  ~/.config/nvim/Gl0riVim/plugins/editor/telescope.lua
  ["<leader>f"] = { name = "+Find 󰛔 " },
  ["<leader>l"] = { name = "+Live/List 󰈞 " },
  ["<leader>s"] = { name = "+Search  " },

  -- ~/.config/nvim/Gl0riVim/plugins/editor/bufferline.lua
  ["<leader>b"] = { name = "+Buffer  " },
  ["<leader>bc"] = "Close  ",
  ["<leader>bs"] = { name = "+Sort 󰒿 " },

  -- ~/.config/nvim/Gl0riVim/plugins/editor/buffremove.lua
  ["Q"] = "Remove Current Buffer  ",

  -- ~/.config/nvim/Gl0riVim/editor/keymap_helper.lua,
  ["<leader><leader>"] = "Search Keymaps ",

  -- ~/.config/nvim/Gl0riVim/plugins/editor/todo_comments.lua
  ["<leader>/"] = { name = "Find TODOss 󱨰 " },
  ["<leder>//"] = "All 󱨰 ",
  ["<leader>/b"] = "BUG 󰃤 ",
  ["<leder>/f"] = "FIX 󰁨 ",
  ["<leader>/H"] = "HINT 󱠃 ",
  ["<leader>/h"] = "HACK 󰈸 ",
  ["<leader>/I"] = "INFO  ",
  ["<leader>/i"] = "ISSUE  ",
  ["<leader>/n"] = "NOTE 󰠮 ",
  ["<leader>/p"] = "PERFORMANCE 󰥔 ",
  ["<leader>/t"] = "TODO  ",
  ["<leader>/w"] = "WARN  ",
  ["]t"] = { "Next TODO  " },
  ["[t"] = { "Next TODO  " },

  -- ~/.config/nvim/Gl0riVim/plugins/editor/focus.lua},
  ["<leader>tz"] = "Toggle Zen Mode 󱧐 ",
  ["<leader>tw"] = "Toggle Twilight 󰱌 ",

  -- ~/.config/nvim/Gl0riVim/plugins/editor/motion.lua
  ["<leader>E"] = { name = "+Enable/Disable 󰯟 " },
  ["<leader>EF"] = "Enable Flash  ",
  ["<leader>Ef"] = "Disable Flash 󰉃 ",
  ["s"] = "Flash  ",
  ["S"] = "Flash Treesitter  ",
  ["d<leader>"] = "  ", -- Disabled, will forward u to enable/disable flash
  ["dr"] = "Remote FLASH  ",
  ["ds"] = "Flash  ",
  ["dS"] = "Flash Treesitter  ",
  ["y<leader>"] = "  ", -- Disabled, will forward u to enable/disable flash
  ["yr"] = "Remote FLASH  ",
  ["ys"] = "Flash  ",
  ["yS"] = "Flash Treesitter  ",
  ["vr"] = "Remote FLASH  ",
  ["vs"] = "Flash  ",
  ["vS"] = "Flash Treesitter  ",
  ["<leader>e"] = "File Explorer  ", -- ~/.config/nvim/Gl0riVim/plugins/editro/file_explorer.lua

  --            ╒═════════════════════════════════════════════════════════╕
  --            │                                                         │
  --            │                    Ui Plugins                           │
  --            │                                                         │
  --            ╘═════════════════════════════════════════════════════════╛
  -- ~/.config/nvim/Gl0riVim/plugins/ui/neo_scroll.lua},
  ["<C-E>"] = "Move Screen DOWN one-line (without moving cursor) 󰹯 ",
  ["<C-Y>"] = "Move Screen UP one-line (without moving cursor) 󰹯 ",
  ["<C-D>"] = "Move Screen DOWN 1/2 page 󰹯 ",
  ["<C-U>"] = "Move Screen UP 1/2 page 󰹯 ",
  ["<C-B>"] = "Move Screen UP one page (cursor to LAST LINE) 󰹯 ",
  ["<C-F>"] = "Move Screen DOWN one page (cursor to FIRST LINE) 󰹯 ",

  -- ~/.config/nvim/Gl0riVim/plugins/ui/noice.lua
  ["<S-Enter>"] = { mode = "c", desc = "Redirect Cmdline  " },
  ["<leader>N"] = { name = "+Notifications 󰂞 " },
  ["<leader>Na"] = { "All Notifications 󰁁 " },
  ["<leader>Nl"] = { "Last Notifications 󰂝 " },
  ["<leader>Nh"] = { "Notification History  " },
  -- ~/.config/nvim/Gl0riVim/plugins/ui/notify.lua
  ["<leader>Nc"] = { "Clear All Notifications 󰂛 " },

  -- ~/.config/nvim/Gl0riVim/plugins/utils/dial.lua
  ["<leader>J"] = { "Dial Increment  " },
  ["<leader>K"] = { "Dial Decrement  " },

  --            ╒═════════════════════════════════════════════════════════╕
  --            │                                                         │
  --            │                   Utils Plugins                         │
  --            │                                                         │
  --            ╘═════════════════════════════════════════════════════════╛

  -- ~/.config/nvim/Gl0riVim/plugins/utils/track.lua
  ["<leader>m"] = { name = "+Mark  " },

  -- ~/.config/nvim/Gl0riVim/plugins/utils/undotree.lua
  ["<leader>U"] = { "Toggle UndoTree 󰣜 " },

  -- ~/.config/nvim/Gl0riVim/plugins/utils/ccc.lua
  ["<leader>C"] = {
    name = "+Color  ",
    h = "Toggle Color Highlight 󰸱 ",
    p = "Pick Color  ",
  },

  -- ~/.config/nvim/Gl0riVim/plugins/utils/tmux.lua
  ["<C-H>"] = "Tmux Nav LEFT ",
  ["<C-J>"] = "Tmux Nav DOWN ",
  ["<C-K>"] = "Tmux Nav UP ",
  ["<C-l>"] = "Tmux Nav RIGHT ",
  ["<leader>T"] = {
    name = "+Tmux  ",
    c = "Add Contribute Session 󰊤 ",
    m = "Add Mine Session  ",
    r = "Add Rice Session 󰈸 ",
    s = "Available Sessions 󱃻 ",
  },

  -- ~/.config/nvim/Gl0riVim/plugins/utils/toggleterm.lua
  ["<leader>,"] = "Toggle Terminal  ",
  ["<leader>t1"] = "Toggle 1st Terminal 󰎤 ",
  ["<leader>t2"] = "Toggle 2nd Terminal 󰎧  ",
  ["<leader>t3"] = "Toggle 3rd Terminal 󰎪  ",
  ["<leader>t4"] = "Toggle 4th Terminal 󰎭 ",
  ["<leader>tl"] = "Toggle LazyGit  ",
  ["<leader>tn"] = "Toggle Node 󰎙 ",
  ["<leader>tp"] = "Toggle Python 󰌠 ",
  ["<leader>tc"] = "Toggle NCDU 󰋊 ",
  ["<leader>tb"] = "Toggle Btop 󱑟 ",
  ["<leader>tf"] = "Toggle Float Terminal 󱁁 ",
  ["<leader>th"] = "Toggle Horizontal Terminal 󱃧 ",

  -- ~/.config/nvim/Gl0riVim/00_config/signs.lua
  ["<leader>g"] = {
    name = "+Git ",
    b = "Blame  ",
    v = { "<cmd>BlameToggle virtual<cr>", "Toggle Blame 'Virtual' " },
    w = { "<cmd>BlameToggle window<cr>", "Toggle Blame 'Window' " },
    -- s = "Status 󱖫 ",
  },
  ["<leader>gh"] = {
    name = "+Hunks 󱃴",
    d = "Diff Hunk  ",
    i = { "Text Object 󱃴 ", mode = { "o", "x" } },
    j = "Next Hunk 󰮰 ",
    k = "Prev Hunk 󰮲 ",
    p = "Preview Hunk  ",
    r = { "Reset Hunk 󱄍 ", mode = { "n", "v" } },
    R = "Reset Buffer 󱄍 ",
    S = { "Stage Hunk 󰼬 ", mode = { "n", "v" } },
    s = "Stage Buffer 󰼬 ",
    t = "Toggle Deleted  ",
    u = "Undo Stage 󰕌 ",
  },

  -- ~/.config/nvim/Gl0riVim/plugins/utils/emoji_picker.lua
  ["<leader>fe"] = { name = "+Emojis 😃  " },
  ["<leader>fen"] = "Nerd Fonts Emoji 󰱸 ",

  -- ~/.config/nvim/Gl0riVim/plugins/themes/00_rando_scheme.lua
  ["<leader>r"] = "Rando Scheme  ",

  -- ~/.config/nvim/Gl0riVim/plugins/utils/pomodoro.lua
  ["<F4>"] = "Pomodoro Start  ",
  ["<F16"] = "Pomodoro Menu 󰍜 ",

  -- ~/.config/nvim/Gl0riVim/plugins/utils/multi_replace.lua
  ["<F6>"] = "Toggle Multi Replace  ",

  -- ~/.config/nvim/Gl0riVim/plugins/editor/nvim_surround.lua
  ["<leader>ds"] = "Delete Surround  ",

  -- ~/.config/nvim/Gl0riVim/plugins/utils/screenkey.lua
  ["<leader>Es"] = "Enable Screenkey 󰧹 ",
  --            ╒═════════════════════════════════════════════════════════╕
  --            │                                                         │
  --            │                   Games Plugins                         │
  --            │                                                         │
  --            ╘═════════════════════════════════════════════════════════╛
  ["<leader>F"] = {
    name = "+Fun 󰐔 ",
  },
  -- ~/.config/nvim/Gl0riVim/plugins/games/black_jack.lua
  ["<leader>Gb"] = "Black Jack 󰘸 ",

  -- ~/.config/nvim/Gl0riVim/plugins/games/cellular_automation.lua
  ["<leader>G1"] = "Make it rain  ",
  ["<leader>G2"] = "Game of Life  ",
  ["<leader>G3"] = "Scramble 󰣄 ",

  -- ~/.config/nvim/Gl0riVim/plugins/games/duck.lua
  ["<leader>G"] = "+Games 󰊗 ",
  ["<leader>Gh"] = "+Hatch 󰪰 ",
  ["<leader>Ghd"] = "Duck 🦆",
  ["<leader>Ghg"] = "Ghost ඞ",
  ["<leader>GhH"] = "Horse 🐎",
  ["<leader>GhD"] = "Dinosaur 🦖",
  ["<leader>GhC"] = "Crab 🦀",
  ["<leader>Ghc"] = "Chick 🐤",
  ["<leader>Ghk"] = "Kitty 🐈",
  ["<leader>GhA"] = "All",
  ["<leader>Ghx"] = "Cook",
  ["<leader>GhX"] = "Cook All",

  -- ~/.config/nvim/Gl0riVim/plugins/games/hack.lua
  ["<leder>G4"] = "Manual Current Buffer  ",
  ["<leder>G5"] = "Auto Current Buffer  ",
  ["<leder>G6"] = "Auto  ",

  -- ~/.config/nvim/Gl0riVim/plugins/games/hardtime.lua
  ["<leader>Gf"] = "Toggle Hardtime  ",

  -- ~/.config/nvim/Gl0riVim/plugins/games/speed_typer.lua
  ["<leader>Gt"] = "Typing Practise 󰌌 ",

  -- ~/.config/nvim/Gl0riVim/plugins/games/sudoku.lua
  ["<leader>Gs"] = "Sudoku  ",

  -- ~/.config/nvim/Gl0riVim/plugins/games/vim_be_good.lua
  ["<leader>Gv"] = "Vim Be Good 󰕷 ",

  --            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  --            ┃                                                         ┃
  --            ┃       ~/.config/nvim/Gl0riVim/config/neovide.lua        ┃
  --            ┃                                                         ┃
  --            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  ["<C-->"] = "Neovide Font Size 󰍴 ",
  ["<C-=>"] = "Neovide Font Size   ",
  ["<leader>k"] = "Change layout  ",

  --            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  --            ┃                                                         ┃
  --            ┃       ~/.config/nvim/Gl0riVim/config/keymaps.lua        ┃
  --            ┃                                                         ┃
  --            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  ["<C-A>"] = "Select All 󰾂 ",
  ["<C-S>"] = "Save 󰳻 ",
  ["<BS>"] = "Delete in n-mode 󰆴 ",

  ["<Tab>"] = "NEXT Tab 󰩵 ",
  ["<S-Tab>"] = "PREV Tab 󱠼  ",

  ["<leader>"] = {
    p = { "Paste Over Selection  ", mode = "v" }, -- ~/.config/nvim/Gl0riVim/config/keymaps.lua
  },

  ["<leader><Tab>"] = {
    name = "+Tabs 󱐪 ",
    n = "New Tab 󰎔 ",
    c = "Close Tab  ",
    h = "Prev Tab 󰒮 ",
    l = "Next Tab 󰒭 ",
  },

  ["<leader>bca"] = "ALL buffers except current  ",

  ["<leader>P"] = {
    name = "+Plugin Manager 󱐥",
    b = "Build  ",
    C = "Check  ",
    D = "Debug 󰃤 ",
    d = "Dashboard 󰨇 ",
    H = "Help 󰋖 ",
    h = "Health 󰋡 ",
    L = "Log  ",
    l = "Load  ",
    u = "Update plugins 󰚰 ",
    p = "Profile 󰐭 ",
    R = "Restore 󰦛 ",
    r = "Reload 󰑇 ",
    s = "Sync 󱑠 ",
    x = "Clean  ",
  },

  ["<leader>t"] = {
    name = "+Toggle 󰔡 ",
    C = "Toggle Signcolumn",
    c = "Toggle Conceal level 󱂤 ",
    l = "Toggle LazyGit  ",
    m = "Toggle Mouse 󰍽 ",
    N = "Toggle line number (Local)  ",
    n = "Toggle line number (Global)  ",
    S = "Toggle Statusline 󰘤 ",
    s = "Toggle Spelling 󰓆 ",
    T = "Toggle Colorcolumn  ",

    t = "Toggle Tabline 󰓩 ",
    W = "Toggle Wrap  ",
    q = "Toggle Quick list 󱖫 ",
  },

  ["<leader>w"] = {
    name = "+Window  ",
    d = "Delete Window  ",
    j = "Split Window Below 󰤻 ",
    l = "Split Window Right 󰤼 ",
    o = "Goto Other Window  ",
  },

  ["X"] = "Dont't Ynak on Delete Char 󰬶 ",
  ["x"] = "Dont't Ynak on Delete Char 󰬶 ",

  ["<leader>o"] = { name = "+Open 󰏌 " },
  ["<leader>oo"] = "Options  ", -- ~/.config/nvim/Gl0riVim/config/keymaps.lua

  --            ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  --            ┃                                                         ┃
  --            ┃                        Builtins                         ┃
  --            ┃                                                         ┃
  --            ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  ["*"] = "Search Word Under Cursor (Forward)",
  ["#"] = "Search Word Under Cursor (Backward)",
  ["~"] = "Toggle Char Case (Capital/Small)",
  ["."] = "Repeat LAST command",
  ['"xy'] = "Ynak into register X",
  ['"xp'] = "Paste contentes of register X",
  ['"+y'] = "Yank into the SYSTEM clipboard",
  ['"+p'] = "Paste from the SYSTEM clipboard",

  -- using 'Hardtime' plugins
  ["<Down>"] = "  ", -- Disabled
  ["<Left>"] = "  ", -- Disabled
  ["<Right>"] = "  ", -- Disabled
  ["<Up>"] = "  ", -- Disabled

  ["A"] = "Insert at the END of LINE  ",
  ["a"] = "Insert after the cursor",
  ["B"] = "Jump Backward to the END of Word (Can contain punctuation) 󰈭 ",
  ["b"] = "Jump Backward to the END of Word 󰈭 ",
  ["C"] = "Cut to the END of Line  ",
  ["cc"] = "Cut ENTIRE Line  ",
  ["E"] = "Jump Forward to the END of Word (Can contain punctuation) 󰈭 ",
  ["e"] = "Jump Forward to the END of Word 󰈭 ",
  ["ea"] = "Insert at the END of the Word 󰈭 ",
  ["F"] = "Move To PREV Char 󰬶 ",
  ["f"] = "Move To NEXT Char 󰬶 ",
  ["G"] = "GoTo Last Line  ",
  ["g_"] = "Jump to the LAST non-black character of the Line  ",
  ["g~"] = "Switch CASE to motion 󰬶 ",
  ["gu"] = "Switch to LOWER CASE to motion 󰬶 ",
  ["gU"] = "Switch to UPPER CASE to motion 󰬶 ",
  ["gg"] = "GoTo FIRST Line  ",
  ["H"] = "Move to TOP of Screen  ",
  ["I"] = "Insert at the BEGINING of the line  ",
  ["i"] = "Insert BEFORE the cursor 󰗧 ",
  ["J"] = "Join line BELOW (With Space)",
  ["j"] = "Join line BELOW (Without Space)",
  ["L"] = "Move to BOTTOM of Screen   ",
  ["M"] = "Move to MIDDLE of Screen  ",
  ["O"] = "Add new line ABOVe the current line  ",
  ["o"] = "Add new line BELOW the current line  ",
  ["P"] = "Paste Above 󰁝 ",
  ["p"] = "Paste Below  ",
  ["R"] = "Replace Characters until ESC is pressed  ",
  ["r"] = "Replace SINGLE Characters  ",
  -- ["S"] = "Delete Char 󰬶 ", -- Mapped to Flash
  -- ["s"] = "Delete Char 󰬶 ", -- Mapped to Flash
  ["T"] = "Move before PREV Char 󰬶 ",
  ["t"] = "Move before NEXT Char 󰬶 ",
  ["U"] = "Restore UNDO last changed line  ",
  ["u"] = "UNDO",
  ["W"] = "Jump Forward to the START of Word (Can contain punctuation) 󰈭 ",
  ["w"] = "Jump Forward to the START of Word 󰈭 ",

  ["D"] = "Del to the END of Line 󰗩  ",
  ["d"] = {
    name = "Delete  ",
    ["$"] = "To END of Line  ",
    ["%"] = "To matching PARENTHESES: (), [], {}",
    ["0"] = "To START of Line (With the indent)",
    [";"] = "Repeat PREV (f, t, F, T) movements 󰕇  ",
    ["^"] = "To START of Line (Without the indent)",
    ["{"] = "To PREV EMPTY Line  ",
    ["}"] = "To NEXT EMPTY Line  ",
    ["<C-->"] = "  ", -- Disabled
    ["<C-=>"] = "  ", -- Disabled
    ["<C-Bslash>"] = "  ", -- Disabled, For Tmux Navigatior
    ["<C-H>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-J>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-K>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-L>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<Down>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Left>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Right>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Up>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["["] = {
      name = "To PREV... 󰦻 ",
      ["%"] = "Match it Operation 󱊄 ",
      C = "END @clss.outer  ",
      c = "START @class.outer  ",
      F = "END @function.outer 󰡱 ",
      f = "START @function.outer 󰡱 ",
      i = "To indent scope TOP",
    },
    ["]"] = {
      name = "To NEXT... 󰦻 ",
      ["%"] = "Match it Operation 󱊄 ",
      i = "To indent scope BOTTOM",
    },
    b = "PREV Word 󰈭 ",
    e = "NEXT END of Word 󰈭 ",
    F = "Move To PREV Char 󰬶  ",
    f = "Move To NEXT Char 󰬵  ",
    G = "To LAST Line 󰕞  ",
    g = {
      name = "To... 󰦻 ",
      ["%"] = "Match it Operation 󱊄 ",
      e = "The END of Word 󰾸 ",
      g = "The FIRST line  ",
    },
    h = "LEFT ",
    j = "DOWN ",
    k = "UP ",
    l = "RIGHT ",
    T = "Move To PREV Char 󰬶  ",
    t = "Move To NEXT Char 󰬵  ",
    w = "NEXT Word 󰈭 ",
  },

  ["Y"] = "Yank to the END of Line  ",
  ["y"] = {
    name = "Yank  ",
    ["$"] = "To END of Line  ",
    ["%"] = "To matching PARENTHESES: (), [], {}",
    ["0"] = "To START of Line (With the indent)",
    ["^"] = "To START of Line (Without the indent)",
    ["{"] = "To PREV EMPTY Line  ",
    ["}"] = "To NEXT EMPTY Line  ",
    ["["] = {
      name = "GoTo PREV... 󰦻 ",
      i = "To indent scope TOP",
    },
    ["]"] = {
      name = "GoTo NEXT... 󰦻 ",
      i = "To indent scope BOTTOM",
    },
    ["<C-->"] = "  ", -- Disabled
    ["<C-=>"] = "  ", -- Disabled
    ["<C-Bslash>"] = "  ", -- Disabled, For Tmux Navigatior
    ["<C-H>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-J>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-K>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-L>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<Down>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Left>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Right>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Up>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    b = "PREV Word 󰈭 ",
    e = "NEXT END of Word 󰈭 ",
    F = "Move To PREV Char 󰬶  ",
    f = "Move To NEXT Char 󰬵  ",
    G = "To LAST Line 󰕞  ",
    h = "LEFT ",
    j = "DOWN ",
    k = "UP ",
    l = "RIGHT ",
    T = "Move To PREV Char 󰬶  ",
    t = "Move To NEXT Char 󰬵  ",
    w = "NEXT Word 󰈭 ",
  },

  ["V"] = "Visual Mode (Whole Line) ",
  ["<C-V>"] = "Start VISUAL BLOCK mode",
  ["aw"] = "Mark a Word 󰈭 ",

  ["v"] = {
    name = "Visual Mode 󰕷 ",
    ["$"] = "To END of Line  ",
    ["%"] = "To matching PARENTHESES: (), [], {}",
    ["0"] = "To START of Line (With the indent)",
    [";"] = "Repeat PREV (f, t, F, T) movements 󰕇  ",
    ["^"] = "To START of Line (Without the indent)",
    ["{"] = "To PREV EMPTY Line  ",
    ["}"] = "To NEXT EMPTY Line  ",
    ["<C-Bslash>"] = "  ", -- Disabled, For Tmux Navigatior
    ["<C-H>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-J>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-K>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<C-L>"] = "  ", -- Disabled, for Tmux Navigatior
    ["<Down>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Left>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Right>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["<Up>"] = "  ", -- Disabled, will be disabled while using (Hardtime plugins)
    ["["] = {
      name = "To PREV... 󰦻 ",
      ["%"] = "Match it Operation 󱊄 ",
      i = "To indent scope TOP",
    },
    ["]"] = {
      name = "To NEXT... 󰦻 ",
      ["%"] = "Match it Operation 󱊄 ",
      i = "To indent scope BOTTOM",
    },
    b = "PREV Word 󰈭 ",
    e = "NEXT END of Word 󰈭 ",
    F = "Move To PREV Char 󰬶  ",
    f = "Move To NEXT Char 󰬵  ",
    G = "To LAST Line 󰕞  ",
    g = {
      name = "To... 󰦻 ",
      ["%"] = "Match it Operation 󱊄 ",
      e = "The END of Word 󰾸 ",
      g = "The FIRST line  ",
    },
    h = "LEFT ",
    j = "DOWN ",
    k = "UP ",
    l = "RIGHT ",
    O = "Move to other CORNER of Block",
    o = "Move to other END of marked area",
    T = "Move To PREV Char 󰬶  ",
    t = "Move To NEXT Char 󰬵  ",
    w = "NEXT Word 󰈭 ",
  },

  ["z"] = {
    name = "+Fold/Lines 󱐪 ",
    b = "BOTTOM This Line   ",
    e = "RIGHT This Line  ",
    H = "Half Screen to the LEFT  ",
    L = "Half Screen to the RIGHT  ",
    g = "Add Word to Spell List 󰓆 ",
    M = "Close All Folds  ",
    m = "Fold More   ",
    O = "Open All Folds Under Cursor   ",
    o = "Open Fold Under Cursor   ",
    R = "Open All Folds  ",
    r = "Fold Less    ",
    s = "LEFT This Line  ",
    t = "TOP This Line  ",
    w = "Mark Word as misspelled ",
    v = "Show Cursor Line 󱄧  ",
    x = "Update Folds",
    z = { "Center This Line   " },
  },
}

wk.register(whichkey_registered)
