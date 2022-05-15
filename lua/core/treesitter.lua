-- use a protected call so we don't error out on first use
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end


-- Setting clang as the compiler to use as pre this solution
-- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#troubleshooting
-- NOTE: Had issues with clang and nix installed build-essentials and gcc and it works
require("nvim-treesitter.install").compilers = { "gcc", "clang", "cl" }
configs.setup({
  autotag = {
    enable = true,
    filetypes = {"html", "xml", "javascript", "javascriptreact", "php", "markdown"},
  },
  highlight = { enable = true, disable = { "yaml" } },
  playground = { enable = true },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
  },
	rainbow = {
		enable = true,
		disable = { "html" },
		extended_mode = false,
		max_file_lines = nil,
	},

  context_commentstring = {
    enable = true,
		enable_autocmd = false,
    --[[ config = {
      c = "// %s",
      lua = "-- %s",
      nix = "# %s",
    }, ]]
  },
  ensure_installed = {
    "bash",
    "vim",
    "c",
    "fish",
    "css",
    "cmake",
    "c_sharp",
    "comment",
    "cpp",
    "go",
    "java",
    "javascript",
    "json",
    -- "lua",
    "python",
    "query",
    "regex",
    "rust",
    "ruby",
    "php",
    "http",
    "html",
    "typescript",
    "yaml",
  },
})
