local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (comment.lua)", vim.log.levels.WARN)
  return
end

local keymap = settings.coding_plugins.comment.keymaps

local comment = {}
local comment_box = {}

if settings.coding_plugins.comment.enable then
  comment = {
    event = settings.coding_plugins.comment.event,
    keys = {
      { keymap.line_wise.key, keymap.line_wise.desc, keymap.line_wise.mode },
      { keymap.block_wise.key, keymap.block_wise.desc, keymap.block_wise.mode },
      { keymap.add_comment_above.key, keymap.add_comment_above.desc, keymap.add_comment_above.mode },
      { keymap.add_comment_below.key, keymap.add_comment_below.desc, keymap.add_comment_below.mode },
      { keymap.add_comment_eol.key, keymap.add_comment_eol.desc, keymap.add_comment_eol.mode },
    },
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      mappings = {
        -- enable mappings
        basic = true,
        extra = true,
      },

      padding = true, -- Add a space b/w comment and the line
      sticky = false, -- Whether the cursor should stay at its position
      ignore = "^$", -- ignore empty lines

      -- mappings in NORMAL mode
      toggler = {
        line = keymap.line_wise.key, -- Line-comment toggle keymap
        block = keymap.block_wise.key, -- Block-comment toggle keymap
      },

      -- mappings in VISUAL mode
      opleader = {
        line = keymap.line_wise.key, -- Line-comment toggle keymap
        block = keymap.block_wise.key, -- Block-comment toggle keymap
      },

      -- extra mappings
      extra = {
        above = keymap.add_comment_above.key, --Add comment on the line above
        below = keymap.add_comment_below.key, --Add comment on the line below
        eol = keymap.add_comment_eol.key, --Add comment at the end of line
      },

      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      -- pre_hook = function()
      --     return require("ts_context_commentstring.internal").calculate_commentstring()
      --         or vim.bo.commentstring
      -- end,

      -- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),

      -- move cursor to the next line after commenting
      post_hook = nil,
    },
  }
end

local comment_box_opts = settings.editor_plugins.comment_box

if comment_box_opts.enable then
  comment_box = {
    "LudoPinelli/comment-box.nvim",
    keys = {
      {
        "<leader>ax",
        function()
          require("comment-box").dbox()
        end,
        mode = "v",
        desc = "Remove Box Comment",
      },
      -- Boxes
      {
        "<leader>aba",
        function()
          require("comment-box").lcbox(10)
        end,
        mode = "v",
        desc = "ASCII",
      },
      {
        "<leader>abb",
        function()
          require("comment-box").lcbox("1")
        end,
        mode = "v",
        desc = "Rounded",
      },
      {
        "<leader>abc",
        function()
          require("comment-box").lcbox("8")
        end,
        mode = "v",
        desc = "Mix (Double/Single) A",
      },
      {
        "<leader>abd",
        function()
          require("comment-box").lcbox("8")
        end,
        mode = "v",
        desc = "Double",
      },
      {
        "<leader>abe",
        function()
          require("comment-box").lcbox("3")
        end,
        mode = "v",
        desc = "Classic Heavy",
      },
      {
        "<leader>abf",
        function()
          require("comment-box").lcbox("2")
        end,
        mode = "v",
        desc = "Classic",
      },
      {
        "<leader>abg",
        function()
          require("comment-box").lcbox("5")
        end,
        mode = "v",
        desc = "Dashed Heavy",
      },
      {
        "<leader>abh",
        function()
          require("comment-box").lcbox("5")
        end,
        mode = "v",
        desc = "Dashed",
      },
      {
        "<leader>abi",
        function()
          require("comment-box").lcbox("9")
        end,
        mode = "v",
        desc = "Mix (Double/Sinble) B",
      },
      {
        "<leader>abj",
        function()
          require("comment-box").lcbox("11")
        end,
        mode = "v",
        desc = "Quote A",
      },
      {
        "<leader>abk",
        function()
          require("comment-box").lcbox("12")
        end,
        mode = "v",
        desc = "Quote B",
      },
      {
        "<leader>abl",
        function()
          require("comment-box").lcbox("13")
        end,
        mode = "v",
        desc = "Quote C",
      },
      {
        "<leader>abm",
        function()
          require("comment-box").lcbox("14")
        end,
        mode = "v",
        desc = "Marked A",
      },
      {
        "<leader>abn",
        function()
          require("comment-box").lcbox("15")
        end,
        mode = "v",
        desc = "Marked B",
      },
      {
        "<leader>abo",
        function()
          require("comment-box").lcbox("16")
        end,
        mode = "v",
        desc = "Marked C",
      },
      {
        "<leader>abp",
        function()
          require("comment-box").lcbox("17")
        end,
        mode = "v",
        desc = "Vertically Enclosed A",
      },
      {
        "<leader>abq",
        function()
          require("comment-box").lcbox("18")
        end,
        mode = "v",
        desc = "Vertically Enclosed B",
      },
      {
        "<leader>abr",
        function()
          require("comment-box").lcbox("19")
        end,
        mode = "v",
        desc = "Vertically Enclosed C",
      },
      {
        "<leader>abs",
        function()
          require("comment-box").lcbox("20")
        end,
        mode = "v",
        desc = "Horizontally Enclosed A",
      },
      {
        "<leader>abt",
        function()
          require("comment-box").lcbox("21")
        end,
        mode = "v",
        desc = "Horizontally Enclosed B",
      },
      {
        "<leader>abu",
        function()
          require("comment-box").lcbox("22")
        end,
        mode = "v",
        desc = "Horizontally Enclosed C",
      },
      {
        "<leader>abv",
        function()
          require("comment-box").lcbox("6")
        end,
        mode = "v",
        desc = "Mix (Heavy/Light)",
      },
      -- Lines
      {
        "<leader>ala",
        function()
          require("comment-box").lcline(1)
        end,
        mode = "v",
        desc = "Simple",
      },
      {
        "<leader>alb",
        function()
          require("comment-box").lcline(2)
        end,
        mode = "v",
        desc = "Rounded corner DOWN",
      },
      {
        "<leader>alc",
        function()
          require("comment-box").lcline(3)
        end,
        mode = "v",
        desc = "Rounded corner UP",
      },
      {
        "<leader>ald",
        function()
          require("comment-box").lcline(4)
        end,
        mode = "v",
        desc = "Squared corner DOWN",
      },
      {
        "<leader>ale",
        function()
          require("comment-box").lcline(5)
        end,
        mode = "v",
        desc = "Squared corner UP",
      },
      {
        "<leader>alf",
        function()
          require("comment-box").lcline(6)
        end,
        mode = "v",
        desc = "Squared title",
      },
      {
        "<leader>alg",
        function()
          require("comment-box").lcline(7)
        end,
        mode = "v",
        desc = "Rounded Title",
      },
      {
        "<leader>alh",
        function()
          require("comment-box").lcline(8)
        end,
        mode = "v",
        desc = "Spiked Title",
      },
      {
        "<leader>ali",
        function()
          require("comment-box").lcline(9)
        end,
        mode = "v",
        desc = "Simple Heavy",
      },
      {
        "<leader>alj",
        function()
          require("comment-box").lcline(10)
        end,
        mode = "v",
        desc = "Confined",
      },
      {
        "<leader>alk",
        function()
          require("comment-box").lcline(11)
        end,
        mode = "v",
        desc = "Confined Heavy",
      },
      {
        "<leader>all",
        function()
          require("comment-box").lcline(12)
        end,
        mode = "v",
        desc = "Simple Weighted",
      },
      {
        "<leader>alm",
        function()
          require("comment-box").lcline(13)
        end,
        mode = "v",
        desc = "Double",
      },
      {
        "<leader>aln",
        function()
          require("comment-box").lcline(14)
        end,
        mode = "v",
        desc = "Double Confined",
      },
      {
        "<leader>alo",
        function()
          require("comment-box").lcline(15)
        end,
        mode = "v",
        desc = "ASCII (A)",
      },
      {
        "<leader>alp",
        function()
          require("comment-box").lcline(16)
        end,
        mode = "v",
        desc = "ASCII (B)",
      },
      {
        "<leader>alq",
        function()
          require("comment-box").lcline(17)
        end,
        mode = "v",
        desc = "ASCII (C)",
      },
    },
    opts = {
      -- type of comments:
      --   - "line":  comment-box will always use line style comments
      --   - "block": comment-box will always use block style comments
      --   - "auto":  comment-box will use block line style comments if
      --              multiple lines are selected, line style comments
      --              otherwise
      comment_style = "auto",
      doc_width = 80, -- width of the document
      box_width = 60, -- width of the boxes
      borders = { -- symbols used to draw a box
        top = "─",
        bottom = "─",
        left = "│",
        right = "│",
        top_left = "╭",
        top_right = "╮",
        bottom_left = "╰",
        bottom_right = "╯",
      },
      line_width = 70, -- width of the lines
      line = { -- symbols used to draw a line
        line = "─",
        line_start = "─",
        line_end = "─",
        title_left = "─",
        title_right = "─",
      },
      outer_blank_lines_above = false, -- insert a blank line above the box
      outer_blank_lines_below = false, -- insert a blank line below the box
      inner_blank_lines = true, -- insert a blank line above and below the text
      line_blank_line_above = false, -- insert a blank line above the line
      line_blank_line_below = false, -- insert a blank line below the line
    },
  }
end

return { comment, comment_box }
