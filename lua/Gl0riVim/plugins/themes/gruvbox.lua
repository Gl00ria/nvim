local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (gruvbox.lua)", vim.log.levels.WARN)
  return
end

local gruvbox_opts = settings.theme_plugins.gruvbox

local gruvbox = {}
local gruvbox_baby = {}
local gruvbox_material = {}

if gruvbox_opts.gruvbox_main.enable then
  gruvbox = {
    cmd = "",
    "ellisonleao/gruvbox.nvim",
    opts = {
      -- credits: (https://github.com/SeniorMars/dotfiles/blob/master/.config/nvim/init.lua)
      -- overrides = {
      --   Normal = { bg = "#000000" },
      --   VertSplit = { bg = "#000000" },
      --   SignColumn = { bg = "#000000" },
      --   Define = { link = "GruvboxPurple" },
      --   Macro = { link = "GruvboxPurple" },
      --   ["@constant.builtin"] = { link = "GruvboxPurple" },
      --   ["@storageclass.lifetime"] = { link = "GruvboxAqua" },
      --   ["@text.note"] = { link = "TODO" },
      --   CocCodeLens = { fg = "#878787" },
      --   ContextVt = { fg = "#878787" },
      --   Comment = { fg = "#fe8019", italic = true },
      --   Folded = { italic = true, fg = "#fe8019", bg = "#3c3836" },
      --   FoldColumn = { fg = "#fe8019", bg = "#0E1018" },
      --   DiffAdd = { bold = true, reverse = false, fg = "", bg = "#2a4333" },
      --   DiffChange = { bold = true, reverse = false, fg = "", bg = "#333841" },
      --   DiffDelete = { bold = true, reverse = false, fg = "#442d30", bg = "#442d30" },
      --   DiffText = { bold = true, reverse = false, fg = "", bg = "#213352" },
      --   StatusLine = { bg = "#ffffff", fg = "#000000" },
      --   StatusLineNC = { bg = "#3c3836", fg = "#000000" },
      --   CursorLineNr = { fg = "#fabd2f", bg = "#000000" },
      --   DiagnosticVirtualTextWarn = { fg = "#dfaf87" },
      --   GruvboxOrangeSign = { fg = "#dfaf87", bg = "#000000" },
      --   GruvboxAquaSign = { fg = "#8EC07C", bg = "#000000" },
      --   GruvboxGreenSign = { fg = "#b8bb26", bg = "#000000" },
      --   GruvboxRedSign = { fg = "#fb4934", bg = "#000000" },
      --   GruvboxBlueSign = { fg = "#83a598", bg = "#000000" },
      --   WilderMenu = { fg = "#ebdbb2", bg = "#000000" },
      --   WilderAccent = { fg = "#f4468f", bg = "#000000" },
      -- },
    },
  }
end

if gruvbox_opts.gruvbox_baby.enable then
  gruvbox_baby = {
    cmd = "",
    "luisiacc/gruvbox-baby",
    config = function()
      vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_keyword_style = "italic"

      vim.g.gruvbox_baby_telescope_theme = 1

      vim.g.gruvbox_baby_transparent_mode = gruvbox_opts.gruvbox_baby.transparency
    end,
  }
end

if gruvbox_opts.gruvbox_material.enable then
  gruvbox_material = {
    lazy = true,
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    config = function()
      vim.g.gruvbox_material_better_performance = 1
      -- Fonts
      vim.g.gruvbox_material_disable_italic_comment = 1
      vim.g.gruvbox_material_enable_italic = 0
      vim.g.gruvbox_material_enable_bold = 0
      vim.g.gruvbox_material_transparent_background = gruvbox_opts.gruvbox_material.transparency
      -- Themes
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_ui_contrast = "high" -- The contrast of line numbers, indent lines, etc.
      vim.g.gruvbox_material_float_style = "dim" -- Background of floating windows

      local configuration = vim.fn["gruvbox_material#get_configuration"]()
      local palette = vim.fn["gruvbox_material#get_palette"](
        configuration.background,
        configuration.foreground,
        configuration.colors_override
      )

      vim.cmd.colorscheme("gruvbox-material")

      local highlights_groups = {
        FoldColumn = { bg = "none" },
        SignColumn = { bg = "none" },
        Normal = { bg = "none" },
        NormalNC = { bg = "none" },
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none", fg = palette.orange[1] },
        TelescopeBorder = { bg = "none" },
        TelescopeNormal = { fg = "none" },
        TelescopePromptNormal = { bg = "none" },
        TelescopeResultsNormal = { bg = "none" },
        TelescopeSelection = { bg = palette.bg3[1] },
        Visual = { bg = palette.bg_visual_red[1] },
        Cursor = { bg = palette.bg_red[1], fg = palette.bg_dim[1] },
        ColorColumn = { bg = palette.bg_visual_blue[1] },
        CursorLine = { bg = palette.bg3[1], blend = 25 },
        GitSignsAdd = { fg = palette.green[1], bg = "none" },
        GitSignsChange = { fg = palette.yellow[1], bg = "none" },
        GitSignsDelete = { fg = palette.red[1], bg = "none" },
      }

      for group, styles in pairs(highlights_groups) do
        vim.api.nvim_set_hl(0, group, styles)
      end
    end,
  }
end

return { gruvbox, gruvbox_baby, gruvbox_material }
