local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (snippets_engine.lua)", vim.log.levels.WARN)
  return
end

local keymaps = settings.coding_plugins.luasnip.keymaps

local luasnip = {}

if settings.coding_plugins.luasnip.enable then
  luasnip = {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
        and "echo -e 'Note: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        local snippet_path = vim.fn.stdpath("config") .. "/snippets"
        require("luasnip.loaders.from_snipmate").load({ path = { snippet_path } })
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      {
        keymaps.jump_next_snippet.key,
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
        desc = keymaps.jump_next_snippet.desc,
      },
      {
        keymaps.jump_next_snippet.key,
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
        desc = keymaps.jump_next_snippet.desc,
      },
      {
        keymaps.jump_prev_snippet.key,
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
        desc = keymaps.jump_prev_snippet.desc,
      },
    },
  }
end

return luasnip
