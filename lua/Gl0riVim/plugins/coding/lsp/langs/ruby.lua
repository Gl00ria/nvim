local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (ruby.lua)", vim.log.levels.WARN)
  return
end

local utils_status, utils = pcall(require, "Gl0riVim.config.utils")
if not utils_status then
  vim.notify("[utils] failed to load within (ruby.lua)", vim.log.levels.WARN)
  return
end

local ruby_opts = settings.langs_control.ruby
local ruby = {}
local mason_ruby = {}
local treesitter_ruby = {}

-- First check rubygems user dir then system dir
local ruby_path = ""
if vim.fn.executable("ruby") == 1 then
  ruby_path = vim.fn.system({ "ruby", "-e", "puts Gem.user_dir" })
  if ruby_path == nil or ruby_path == "" then
    ruby_path = vim.fn.system({ "ruby", "-e", "puts Gem.dir" })
    if ruby_path == nil or ruby_path == "" then
      ruby_path = vim.g.homebrew_install_dir .. "/bin/ruby"
      if utils.file_or_dir_exists(ruby_path) then
        ruby_path = vim.fn.system({ ruby_path, "-e", "puts Gem.user_dir" })
        if ruby_path == nil or ruby_path == "" then
          ruby_path = vim.fn.system({ ruby_path, "-e", "puts Gem.dir" })
          if not (ruby_path == nil or ruby_path == "") then
            ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
            if utils.file_or_dir_exists(ruby_path) then
              vim.g.ruby_host_prog = ruby_path
            end
          end
        else
          ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
          if utils.file_or_dir_exists(ruby_path) then
            vim.g.ruby_host_prog = ruby_path
          end
        end
      end
    else
      ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
      if utils.file_or_dir_exists(ruby_path) then
        vim.g.ruby_host_prog = ruby_path
      end
    end
  else
    ruby_path = ruby_path:gsub("[%c]", "") .. "/bin/neovim-ruby-host"
    if utils.file_or_dir_exists(ruby_path) then
      vim.g.ruby_host_prog = ruby_path
    end
  end
end

if ruby_opts.enable then
  ruby = {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {},
      },
    },
  }

  if ruby_opts.mason_ruby then
    mason_ruby = {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "solargraph",
        })
      end,
    }
  end

  if ruby_opts.ts_ruby then
    treesitter_ruby = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        vim.list_extend(opts.ensure_installed, {
          "ruby",
        })
      end,
    }
  end
end

return {
  ruby,
  mason_ruby,
  treesitter_ruby,
}
