local fn = vim.fn

-- automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Work in progress..."
  vim.cmd [[packadd packer.nvim]]
end


-- return the require for use in `core, lsp, github, UI, extra, colorscheme` parameter of packer's use
-- expects the name of the config file
local function get_core(core)
    return string.format("require(\"core/%s\")", core)
end

local function get_lsp(lsp)
  return string.format("require(\"lsp/%s\")", lsp)
end

local function get_git(git)
  return string.format("require(\"git/%s\")", git)
end

local function get_UI(ui)
    return string.format("require(\"UI/%s\")", ui)
end

local function get_extra(extra)
    return string.format("require(\"extra/%s\")", extra)
end

local function get_color(color)
    return string.format("require(\"colorscheme/%s\")", color)
end


-- autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)

  -- Core
  use { "wbthomason/packer.nvim" } -- have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- required by lots of plugins
  use { "nvim-lua/popup.nvim" } -- an implementation of the Popup API from vim in Neovim
  use { "MunifTanjim/nui.nvim" } -- required by 'neo-tree'
  use { "kyazdani42/nvim-web-devicons" } -- keep it always on top of plugins
  use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", config = get_core("neotree") }
  use { "lewis6991/impatient.nvim", config = get_core("impatient") } -- improve Startup time
  use { "windwp/nvim-autopairs", config = get_core("autopairs") } -- autopairs
  use { "Pocco81/AutoSave.nvim", config = get_core("autosave") }
  use { "numToStr/Comment.nvim", config = get_core("comment") } -- comment Utility
  use { "rmagatti/goto-preview", config = get_core("goto") } -- goto difinition
  use { "tami5/lspsaga.nvim", config = get_core("lspsaga") } -- code action, hover, signature,
  use { "mbbill/undotree", config = get_core("undotree") } -- display UNDO History
  use { "sar/spectre.nvim", config = get_core("spectre") } -- search/replace panel
  use { "SmiteshP/nvim-gps", config = get_core("gps") } -- show context of the current cursor position on the statusline
  use { "liuchengxu/vista.vim" } -- view symbols useing lsp
  use { "moll/vim-bbye" } -- close a file 'without a punch on my face' :)
  use { "junegunn/fzf" } -- fuzzy finder

  -- Ftplugin
  use { "mfussenegger/nvim-jdtls", ft = "java" } -- Java
  use { "p00f/clangd_extensions.nvim", config = get_core("clangd_extensions"), ft = { "c", "cpp", "objc", "objcpp" } }
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })

  -- Telescope
  use { "nvim-telescope/telescope.nvim", config = get_core("telescope") }
  use {
  "tom-anders/telescope-vim-bookmarks.nvim", "nvim-telescope/telescope-media-files.nvim",
  "xiyaowong/telescope-emoji", "nvim-telescope/telescope-ui-select.nvim",
  "nvim-telescope/telescope-file-browser.nvim", "ThePrimeagen/harpoon"}
  use { "ahmedkhalf/project.nvim", config = get_core("project") } -- project manager

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", config = get_core("treesitter"), run = ":TSUpdate" }
  use { "romgrk/nvim-treesitter-context", config = get_core("ts-context" )}
  use { "JoosepAlviste/nvim-ts-context-commentstring", "windwp/nvim-ts-autotag", "nvim-treesitter/playground" }

  -- LSP
  use { "neovim/nvim-lspconfig", config = get_lsp("lsp-config" )} -- enable LSP + collection of common configs
  use { "williamboman/nvim-lsp-installer", config = get_lsp("lsp-installer") } -- simple to use language server installer
  use { "jose-elias-alvarez/null-ls.nvim", config = get_lsp("null-ls" )} -- for formatters and linters
  use { "ray-x/lsp_signature.nvim", config = get_lsp("lsp-signature" )} -- show function signatures when you type
  use { "folke/lsp-trouble.nvim", config = get_core("trouble" )} -- diagnostic
  use { "antoinemadec/FixCursorHold.nvim" } -- this is needed to fix lsp doc highlight
  use { "tamago324/nlsp-settings.nvim" } -- language server settings defined in json for


  -- CMP plugins
  use { "hrsh7th/nvim-cmp", config = get_core("cmp") } -- the completion plugin
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lua" }
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-cmdline" } -- cmdline completions
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "kdheepak/cmp-latex-symbols" }
  use { "hrsh7th/cmp-emoji" }
  use { "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = { -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
      }
    end,

    -- NOTE: if you are on 'Windows', replace "./install.sh" with "powershell ./install.ps1"
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

  -- Snippets
  use { "L3MON4D3/LuaSnip" } -- snippet engine
  use { "rafamadriz/friendly-snippets" } -- a bunch of snippets

  use { "rcarriga/nvim-dap-ui",
  config = function()
    require("dapui").setup()
    end,
    ft = { "python", "rust", "go", "java", "c", "cpp" },
    event = "BufReadPost",
    requires = { "mfussenegger/nvim-dap" },
   }

  -- Git
  use { "mattn/webapi-vim" } -- an interface to web APIs
  -- use {"mattn/vim-gist", config = get_github("gist")}
  use { "ruifm/gitlinker.nvim", config = get_git("git-linker") }
  use { "sindrets/diffview.nvim", config = get_git("diffview") } -- cycling through diffs for all modifided files for any git rev
  use { "lewis6991/gitsigns.nvim", config = get_git("git-signs") }
  use { "f-person/git-blame.nvim", config = get_git("git-blame") }
  -- use { "kdheepak/lazygit.nvim" }
  use { "github/copilot.vim", config = get_git("copilot") } -- NOTE: you need to join the Github copilot
  use { "zbirenbaum/copilot.lua",
  event = {"VimEnter"},
  after = "nvim-cmp",
  requires = { "zbirenbaum/copilot-cmp" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup()
    end, 100)
  end,
}

  -- UI
  -- use { "matbme/JABS.nvim", config = get_UI("jabs") } -- show opened buffers
  use { "sunjon/shade.nvim", config = get_UI("shade") } -- dim inactive window
  use { "rcarriga/nvim-notify", config = get_UI("notify") } -- fancy notification window
  use { "folke/zen-mode.nvim", config = get_UI("zen-mode") } -- distraction free coding
  -- use { "folke/which-key.nvim", config = get_UI("whichkey") } -- display possible key-maps
  use { "karb94/neoscroll.nvim", config = get_UI("neoscroll") } -- smooth scrolling
  use { "glepnir/dashboard-nvim", config = get_UI("dashboard") } -- greathing window
  use { "RRethy/vim-illuminate", config = get_UI("illuminate") } -- highlighting other uses of the current word under the cursor
  use { "nvim-lualine/lualine.nvim", config = get_UI("lualine") } -- statusline
  use { "akinsho/bufferline.nvim", config = get_UI("bufferline") } -- bufferline
  use { "dhruvasagar/vim-table-mode", config = get_UI("tablemode") }
  use{ "ghillb/cybu.nvim", branch = "v1.x", config = get_UI("cybu") } -- cycle between buffers
  use { "folke/todo-comments.nvim", config = get_UI("todo-comments") } -- comment utility
  use { "gfeiyou/command-center.nvim", config = get_UI("command_center") }
  use { "lukas-reineke/indent-blankline.nvim", config = get_UI("indentline") } -- indentation guides
  use { "gelguy/wilder.nvim", run = "UpdateRemotePlugins", config = get_UI("wilder") } -- cmdline

  -- Extra
  use { "mhinz/vim-rfc" } -- usage = :RFC NUMBER or :RFC NAME
  use { "tpope/vim-repeat" } -- repeat the last plugin map '.'
  -- use { "jbyuki/instant.nvim" }
  use { "kevinhwang91/rnvimr" } -- ranger
  use { "b0o/SchemaStore.nvim" } -- Get extra JSON schemas
  use { "kevinhwang91/nvim-bqf" } -- better 'Quickfix window'
  -- use { "dstein64/vim-startuptime" } -- :StartupTime
  use { "phaazon/hop.nvim", config = get_extra("hop") } -- jumb to any word-char in the document
  use { "monaqa/dial.nvim", config = get_extra("dial") } -- increment/decrement
  use { "mizlan/iswap.nvim", config = get_extra("iswap") }
  -- use { "nacro90/numb.nvim", config = get_extra("numb") } -- peek a line without jumping to that line
  use { "unblevable/quick-scope", config = get_extra("quickscope") } -- highlight when using 'F, T etc...'
  use { "RishabhRD/nvim-cheat.sh", requires = { "RishabhRD/popfix"} } -- cheat sheet
  use { "tversteeg/registers.nvim", config = get_extra("registers") } -- show registers content
  use { "akinsho/toggleterm.nvim", config = get_extra("toggleterm") } -- terminal window
  use { "br1anchen/nvim-colorizer.lua", config = get_extra("colorizer") } -- color highlighter
  -- use { "anuvyklack/pretty-fold.nvim", config = get_extra("pretty-fold") } -- fold functions
  use { "MattesGroeger/vim-bookmarks", config = get_extra("vim-bookmarks") } -- add a bookmark
  use { "simrat39/symbols-outline.nvim", config = get_extra("symbol-outline") } -- view symbols useing lsp 'currently using Vista'
  use { "michaelb/sniprun", run = "bash ./install.sh", config = get_extra("sniprun") } -- partial code testing
  use { "Darazaki/indent-o-matic", event = "BufRead", config = get_extra("indent-o-matic") }

  -- Too many Colorschemes! Yeah, I purge every single default colorscheme comes with Neovim by default
  -- NOTE: head to 'lua/colorscheme/' to customize according to your own needs
  use { "xiyaowong/nvim-transparent", config = get_color("transparent" )} -- Enable transparent mode
  use { "luisiacc/gruvbox-baby", config = get_color("gruvbox-baby") }
  use { "gruvbox-community/gruvbox", config = get_color("gruvbox") }
  use { "tiagovla/tokyodark.nvim", config = get_color("tokyodark") }
  use { "EdenEast/nightfox.nvim", config = get_color("nightfox") }
  use { "navarasu/onedark.nvim", config = get_color("onedark") }
  use { "sainnhe/sonokai", config = get_color("sonokai") }
  use { "savq/melange", config = get_color("melange") }
  use { "NTBBloodbath/doom-one.nvim" }
  use { "martinsione/darkplus.nvim" }
  use { "cpea2506/one_monokai.nvim" }
  use { "rmehri01/onenord.nvim" }
  use { "folke/tokyonight.nvim" }
  use { "Shatur/neovim-ayu" }
  use { "rose-pine/neovim" }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
