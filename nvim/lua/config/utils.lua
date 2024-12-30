local M = {}

-- cool progress bar for 'lualine'
function M.progress()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

-- python environment for 'lualine'
-- Credits:
-- (https://www.reddit.com/r/neovim/comments/16ya0fr/show_the_current_python_virtual_env_on_statusline/)
-- (https://github.com/jdhao/nvim-config/commit/3137850db67b1b45111656e8749b60eb936dfa7d)
function M.py_vertual_env()
  -- only show virtual env for Python
  if vim.bo.filetype ~= "python" then return "" end

  local conda_env = os.getenv("CONDA_DEFAULT_ENV")
  local venv_path = os.getenv("VIRTUAL_ENV")

  if venv_path == nil then
    if conda_env == nil then
      return ""
    else
      return string.format(" %s (conda)", conda_env)
    end
  else
    local venv_name = vim.fn.fnamemodify(venv_path, ":t")
    return string.format(" %s (venv)", venv_name)
  end
end

function M.hide_in_width() return vim.fn.winwidth(0) > 80 end

return M
