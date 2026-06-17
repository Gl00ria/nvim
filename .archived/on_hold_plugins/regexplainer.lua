vim.pack.add {
  'https://github.com/bennypowers/nvim-regexplainer',
  'https://github.com/edluffy/hologram.nvim', -- for graphical mode
}

require('regexplainer').setup {
  -- 'narrative', 'graphical'
  mode = 'narrative',

  -- automatically show the explainer when the cursor enters a regexp
  auto = true,

  -- filetypes in which to activate regexplainer
  filetypes = {
    'html',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'ruby',
    'python',
    'go',
    'rust',
    'php',
    'java',
    'cs',
  },

  -- Whether to log debug messages
  debug = false,

  -- 'split', 'popup'
  display = 'popup',

  mappings = {
    toggle = 'gR',
    -- examples, not defaults:
    -- show = 'gS',
    -- hide = 'gH',
    -- show_split = 'gP',
    -- show_popup = 'gU',
  },

  -- narrative = {
  --   indendation_string = '> ', -- default '  '
  -- },

  graphical = {
    width = 800, -- image width in pixels
    height = 600, -- image height in pixels
    python_cmd = nil, -- python command (auto-detected)
  },

  deps = {
    auto_install = true, -- automatically install Python dependencies
    python_cmd = nil, -- python command (auto-detected)
    venv_path = nil, -- virtual environment path (auto-generated)
    check_interval = 3600, -- dependency check interval in seconds
  },
}
