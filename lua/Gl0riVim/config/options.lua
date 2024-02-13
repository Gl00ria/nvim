local settings_status, settings = pcall(require, "control_center")
if not settings_status then
  vim.notify("[settings] failed to load within (keymaps.lua)", vim.log.levels.WARN)
  return
end
local utils_status, utils = pcall(require, "Gl0riVim.config.utils")
if not utils_status then
  vim.notify("[utils] failed to load within (options.lua)", vim.log.levels.WARN)
  return
end

local opts = settings.options

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = opts.mapleader
vim.g.maplocalleader = opts.local_mapleader

local options = {
  clipboard = opts.clipboard, -- Copy-paste between vim and everything else
  confirm = opts.confirm, -- Confirm to save changes before exiting modified buffer
  cmdheight = opts.cmdheight, -- Give more space for displaying messages
  completeopt = opts.completeopt, --- Better autocompletion
  cursorline = opts.cursorline, -- Highlight of current line
  emoji = opts.emoji, -- Fix emoji display
  expandtab = opts.expandtab, -- Use spaces instead of tabs

  foldlevel = opts.foldlevel,
  foldtext = opts.foldtext,
  foldmethod = opts.foldmethod,
  foldexpr = opts.foldexpr,
  -- foldcolumn = opts.foldcolumn,
  -- foldnestmax = opts.foldnestmax,
  -- foldlevelstart = opts.foldlevelstart, -- Expand all folds by default

  -- use "set guifont=*" to see available fonts on your system
  guifont = opts.guifont,

  ignorecase = opts.ignorecase, -- Needed for smartcase
  laststatus = opts.laststatus, -- Global statusline at the bottom
  list = opts.list,
  -- which list chars to show
  listchars = {
    --    eol = opts.listchars.eol,
    tab = opts.listchars.tab,
    --    trail = opts.listchars.trail,
    extends = opts.listchars.extends,
    precedes = opts.listchars.precedes,
  },
  mouse = opts.mouse,
  number = opts.number, -- Shows current line number
  relativenumber = opts.relativenumber, -- Relative line numbers
  pumheight = opts.pumheight, -- Max num of items in completion menu
  scrolloff = opts.scrolloff, -- Always keep space when scrolling to bottom/top edge
  shiftwidth = opts.shiftwidth, -- Number of space characters inserted for indentation
  showtabline = opts.showtabline,
  signcolumn = opts.signcolumn, -- Add extra sign column next to line number
  smartcase = opts.smartcase, -- Uses case in search
  smartindent = opts.smartindent, -- Makes indenting smart
  smarttab = opts.smarttab, -- Makes tabbing smarter will realize you have 2 vs 4
  softtabstop = opts.softtabstop, -- Insert 2 spaces for a tab
  splitright = opts.splitright, -- Vertical splits will automatically be to the right
  swapfile = opts.swapfile, -- Swap not needed
  tabstop = opts.tabstop, -- Insert 2 spaces for a tab
  termguicolors = opts.termguicolors, -- Correct terminal colors
  timeoutlen = opts.timeoutlen, -- Faster completion (cannot be lower than 200)
  ttimeoutlen = opts.ttimeoutlen, -- Time to wait for a key code sequence to complete
  undofile = opts.undofile, -- Sets undo to file
  updatetime = opts.updatetime, -- Faster completion
  viminfo = opts.viminfo, -- Increase the size of file history
  wildignore = opts.wildignore, -- Don't search inside Node.js modules (works for gutentag)
  wrap = opts.wrap, -- Display long lines as just one line
  writebackup = opts.writebackup, -- Not needed
  autoindent = opts.autoindent, -- Good auto indent
  backspace = opts.backspace, -- Making sure backspace works
  backup = opts.backup, -- Recommended by coc
  -- Concealed text is completely hidden unless it has a custom replacement
  -- character defined (needed for dynamically showing tailwind classes)
  conceallevel = opts.conceallevel,
  concealcursor = opts.concealcursor, -- Set to an empty string to expand tailwind class when on cursorline
  encoding = opts.encoding, -- The encoding displayed
  errorbells = opts.errorbells, -- Disables sound effect for errors
  fileencoding = opts.fileencoding, -- The encoding written to file
  incsearch = opts.incsearch, -- Start searching before pressing enter
  showmode = opts.showmode, -- Don't show things like -- INSERT -- anymore
}

local globals = {
  speeddating_no_mappings = 1, -- Disable default mappings for speeddating
}

vim.opt.shortmess:append("c")
vim.opt.formatoptions:remove("c")
vim.opt.formatoptions:remove("r")
vim.opt.formatoptions:remove("o")

vim.opt.fillchars:append("stl: ")
vim.opt.fillchars:append("eob: ")
vim.opt.fillchars:append("fold: ")
vim.opt.fillchars:append("foldopen:")
vim.opt.fillchars:append("foldsep: ")
vim.opt.fillchars:append("foldclose:")

for k, v in pairs(options) do
  vim.opt[k] = v
end

for k, v in pairs(globals) do
  vim.g[k] = v
end

vim.g.pymode = 1
vim.g.pymode_warnings = 1
vim.g.loaded_perl_provider = 0

-- The Homebrew installation location
local brew_prefix = os.getenv("HOMEBREW_PREFIX")

if brew_prefix ~= nil then
  if utils.isdir("/home/linuxbrew/.linuxbrew") then
    vim.g.homebrew_install_dir = "/home/linuxbrew/.linuxbrew"
  else
    if utils.isdir("/opt/homebrew") then
      vim.g.homebrew_install_dir = "/opt/homebrew"
    else
      if utils.isdir("/usr/local") then
        vim.g.homebrew_install_dir = "/usr/local"
      else
        vim.g.homebrew_install_dir = ""
      end
    end
  end
else
  vim.g.homebrew_install_dir = "/usr"
end

local python_path = vim.fn.exepath("python3")
if python_path == nil or python_path == "" then
  python_path = vim.g.homebrew_install_dir .. "/bin/python3"
  if utils.file_or_dir_exists(python_path) then
    vim.g.python3_host_prog = python_path
  end
else
  vim.g.python3_host_prog = python_path
end

local doq_path = vim.fn.exepath("doq")
if doq_path == nil or doq_path == "" then
  doq_path = vim.g.homebrew_install_dir .. "/bin/doq"
  if utils.file_or_dir_exists(doq_path) then
    vim.g.pydocstring_doq_path = doq_path
  else
    vim.g.pydocstring_doq_path = "/usr/bin/doq"
  end
else
  vim.g.pydocstring_doq_path = doq_path
end
