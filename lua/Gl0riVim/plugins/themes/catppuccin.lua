local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (catppuccin.lua)", vim.log.levels.WARN)
  return
end

local catpp_opts = settings.theme_plugins.catppuccin

local catppuccin = {}

if catpp_opts.enable then
  catppuccin = {
    cmd = "",
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = catpp_opts.style, -- latte, frappe, macchiato, mocha
      transparent_background = catpp_opts.transparency,
      background = {
        light = "latte",
        dark = "mocha",
      },
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      show_end_of_buffer = true,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      styles = {
        comments = { "italic" },
        conditionals = {},
        loops = {},
        functions = {},
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          NormalFloat = { bg = colors.mantle },
          FloatBorder = { bg = colors.mantle, fg = colors.mantle },

          StatusLine = { bg = "NONE" },

          Pmenu = { bg = colors.crust, fg = colors.overlay2 },

          WinBar = { fg = colors.text },

          NvimTreeRootFolder = { fg = colors.mantle },
          NvimTreeFolderIcon = { fg = "#FEE082" },

          CmpMenu = {
            bg = transparent_background and colors.none or colors.base,
            fg = colors.text,
          },
          CmpMenuBorder = {
            bg = transparent_background and colors.none or colors.base,
            fg = colors.surface2,
          },
          CmpMenuSel = { bg = colors.sky, fg = colors.base },
          CmpDoc = {
            bg = transparent_background and colors.none or colors.base,
            fg = colors.text,
          },
          CmpDocBorder = {
            bg = transparent_background and colors.none or colors.base,
            fg = colors.surface2,
          },

          -- TreesitterContext
          TreesitterContext = { bg = colors.surface0 },
          TreesitterContextLineNumber = { bg = colors.surface0 },

          -- Telescope
          TelescopeBorder = {
            bg = colors.crust,
            fg = colors.crust,
          },
          TelescopeNormal = { bg = colors.crust },

          -- Telescope Preview
          TelescopePreviewBorder = {
            bg = colors.mantle,
            fg = colors.mantle,
          },
          TelescopePreviewNormal = { bg = colors.mantle },
          TelescopePreviewTitle = {
            bg = colors.mantle,
            fg = colors.text,
          },

          -- Telescope Prompt
          TelescopePromptBorder = {
            bg = colors.surface0,
            fg = colors.surface0,
          },
          TelescopePromptNormal = { bg = colors.surface0 },
          TelescopePromptTitle = {
            bg = colors.surface0,
            fg = colors.text,
          },

          -- Telescope Selection
          TelescopeSelection = {
            bg = colors.crust,
            fg = colors.green,
          },
          TelescopeMultiSelection = { bg = colors.crust },

          -- ToggleTerm
          ToggleTerm1NormalFloat = { bg = colors.crust },
          ToggleTerm1FloatBorder = {
            bg = colors.crust,
            fg = colors.crust,
          },

          -- LSP Saga
          LspFloatWinNormal = { bg = "NONE" },

          -- LSP Virtual Text
          DiagnosticVirtualTextError = { bg = "NONE" },
          DiagnosticVirtualTextWarn = { bg = "NONE" },
          DiagnosticVirtualTextInfo = { bg = "NONE" },
          DiagnosticVirtualTextHint = { bg = "NONE" },
        }
      end,
    },
  }
end

return catppuccin
