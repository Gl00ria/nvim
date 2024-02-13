local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (telescop_extensions.lua)", vim.log.levels.WARN)
  return
end

local motion_opts = settings.editor_plugins.motion

local motion = {}

if motion_opts.strategy == "hop" then
  motion = {
    {
      "ziontee113/syntax-tree-surfer",
      event = "BufReadPost",
    },
    {
      "mfussenegger/nvim-treehopper",
      event = "BufReadPost",
      config = function()
        local tree_hopper = require("tsht")
        vim.keymap.set("n", "<Leader>hm", function()
          tree_hopper.nodes()
        end, { desc = "Treehopper nodes" })
        vim.keymap.set("n", "<Leader>h[", function()
          tree_hopper.move({ side = "start" })
        end, { desc = "Move to start of Treehopper node" })
        vim.keymap.set("n", "<Leader>h]", function()
          tree_hopper.move({ side = "end" })
        end, { desc = "Move to end of Treehopper node" })
      end,
    },
    {
      event = motion_opts.hop_opts.event,
      "phaazon/hop.nvim",
      cmd = motion_opts.hop_opts.cmd,
      config = function()
        require("Gl0riVim.plugins.00_config.motion_hop")
      end,
    },
  }
elseif motion_opts.strategy == "flash" then
  motion = {
    "folke/flash.nvim",
    event = motion_opts.flash_opts.event,
    keys = motion_opts.flash_opts.keys,
    opts = {
      modes = {
        search = {
          enabled = motion_opts.flash_opts.search_enable,
        },
      },
      label = {
        rainbow = {
          enabled = motion_opts.flash_opts.rainbow.enabled,
          shade = motion_opts.flash_opts.rainbow.shade,
        },
      },
      highlight = {
        -- show a backdrop with hl FlashBackdrop
        backdrop = true,
        -- Highlight the search matches
        matches = true,
        -- extmark priority
        priority = 5000,
        groups = {
          match = "FlashMatch",
          current = "FlashCurrent",
          backdrop = "FlashBackdrop",
          label = "FlashLabel",
        },
      },
    },
  }
elseif motion_opts.strategy == "leap" then
  motion = {
    {
      "ggandor/flit.nvim",
      event = "BufReadPost",
      keys = function()
        local ret = {}
        for _, key in ipairs({ "f", "F", "t", "T" }) do
          ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
        end
        return ret
      end,
      opts = { labeled_modes = "nx" },
    },
    {
      "ggandor/leap.nvim",
      event = motion_opts.leap_opts.event,
      keys = motion_opts.leap_opts.keys,
      config = function(_, opts)
        local leap = require("leap")
        for k, v in pairs(opts) do
          leap.opts[k] = v
        end
        leap.add_default_mappings(true)
        vim.keymap.del({ "x", "o" }, "x")
        vim.keymap.del({ "x", "o" }, "X")
      end,
    },
  }
end
return motion
