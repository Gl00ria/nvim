-- use a protected call so we don't error out on first use
local status_ok1, command_center = pcall(require, "command_center")
if not status_ok1 then
  return
end
local opts = { noremap = true, silent = true }

command_center.add({
  {
    description = "Trigger Command Center",
    cmd = "<cmd>Telescope command_center<cr>",
    keybindings = {
      { "i", "<leader>cc", opts },
      { "n", "<leader>cc", opts },
      { "v", "<leader>cc", opts },
    },
  },
  { description = "Programmer's cheatsheet :)", cmd = "<cmd>Cheat<cr>"},
  { description = "Lines From History", cmd = "<cmd>:e ~/.config/nvim/lines_from_history.txt<cr>"},


  {
    description = "__________________Friends__________________",
    cmd = "",
  },
  {
    description = "Exit Insert mode",
    cmd = "<ESC>",
    keybindings = {
      { "i", "jk", opts },
      { "i", "kj", opts },
    }
  },
  { description = "NeoTree", cmd = "<cmd>NeoTreeShowToggle<cr>", keybindings = { "n", "<leader>ef", opts } },
  { description = "Zen Mode", cmd = "<cmd>ZenMode<cr>", keybindings = { "n", "<leader>z", opts } },
  { description = "Rename", cmd = "<cmd>Lspsaga rename<cr>", keybindings = { "n", "<F2>", opts } },
  { description = "UndoTree", cmd = "<cmd>UndotreeToggle<cr>", keybindings = { "n", "<F3>", opts } },
  { description = "Code outline window", cmd = "<cmd>SymbolsOutline<cr>", keybindings = { "n", "<F4>", opts } },
  { description = "Registers", cmd = "<cmd>Telescope registers<cr>", keybindings = { "n", "<leader>ar", opts } },
  { description = "Man pages", cmd = "<cmd>Telescope man_pages<cr>,", keybindings = { "n", "<leader>am", opts } },
  { description = "Help", cmd = "<cmd>Telescope help_tags<cr>", keybindings = { "n", "<leader>ah", opts } },
  { description = "Table Mode", cmd = "<cmd>TableModeToggle<cr>", keybindings = { "n", "<leader>ta", opts}},

  {
    description = "__________________Browse__________________",
    cmd = "",
  },
  { description = "Google Search", cmd = "<cmd>GoogleSearch<cr>" },
  { description = "Brwoser's Bookmarks", cmd = "<cmd>BrowserBookmarks<cr>" },
  { description = "Devdocs Search", cmd = "<cmd>BrowseDevdocsSearch<cr>" },
  { description = "Devdocs Filetype Search", cmd = "<cmd>BrowseDevdocsFiletypeSearch<cr>" },
  { description = "MDN Search", cmd = "<cmd>BrowseMdnSearch<cr>" },
  { description = "Browselist", cmd = "<cmd>Browselist<cr>" },

  {
    description = "_____________Windows Operations_____________",
    cmd = "",
  },
  { description = "Move cursor to the window Up", cmd = "<C-w>k", keybindings = { "n", "<C-k>", opts } },
  { description = "Move cursor to the window Down", cmd = "<C-w>j", keybindings = { "n", "<C-j>", opts } },
  { description = "Move cursor to the winodw Right", cmd = "<C-w>l", keybindings = { "n", "<C-l>", opts } },
  { description = "Move cursor to the window Left", cmd = "<C-w>h", keybindings = { "n", "<C-h>", opts } },
  { description = "Resize Up", cmd = "<cmd>resize -2<cr>", keybindings = { "n", "<C-Up>", opts } },
  { description = "Resize Down", cmd = "<cmd>resize +2<cr>", keybindings = { "n", "<C-Down>", opts } },
  { description = "Resize Right", cmd = "<cmd>vertical resize -2<cr>", keybindings = { "n", "<C-Right>", opts } },
  { description = "Resize Left", cmd = "<cmd>vertical resize +2<cr>", keybindings = { "n", "<C-Left>", opts } },
  { description = "Dim inactive Windows (on/off)", cmd = "", keybindings = { "n", "<leader>2", opts } },


  {
    description = "______________File Operations______________",
    cmd = "",
  },
  { description = "Find a word within the current file", cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>" },
  { description = "Find Files (current directory)",
  cmd = "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  keybindings = {
    {"n", "<leader>af", opts},
  }
},
  { description = "Find hidden files (current directory)", cmd = "<CMD>Telescope find_files hidden=true<CR>" },
  { description = "Show opened files", cmd = "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  keybindings = { "n", "<leader>eb", opts } },
  { description = "Show recent opened files", cmd = "<cmd>Telescope oldfiles<cr>", keybindings = { "n", "<leader>ao", opts } },
  { description = "Goto to the next buffer", cmd = "<cmd>CybuNext<cr>", keybindings = { "n", "<S-l>", opts } },
  { description = "Goto to the previous buffer", cmd = "<cmd>CybuPrev<cr>", keybindings = { "n", "<S-h>", opts } },
  { description = "Pick a Buffer", cmd = "<cmd>BufferLinePick<cr>", keybindings = { "n", "bp", opts} },
  { description = "Delete current buffer without a punch", cmd = "<cmd>Bdelete!<cr>", keybindings = { "n", "Q", opts } },
  { description = "Exit highlighted mode", cmd = "<cmd>nohlsearch<cr>", keybindings = { "n", "<esc><esc>", opts } },


  {
    description = "______________Text Operations______________",
    cmd = "",
  },
  { description = "Find text within the current directory",
  cmd = "<cmd>Telescope live_grep theme=ivy<cr>",
  keybindings = {
    { "n", "<leader>al", opts },
  }
},
  { description = "Search word under the cursor, (in the directory)", cmd = "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", keybindings = { "n", "sw", opts } },
  { description = "Search word under the cursor, (in the same file)", cmd = "viw:lua require('spectre').open_file_search()<cr>", keybindings = { "n", "sf", opts } },
  { description = "Search current highlighted word", cmd = "<cmd>lua require('spectre').open_visual()<cr>", keybindings = { "v", "vs", opts } },
  { description = "Open Spectre", cmd = "<cmd>lua require('spectre').open()<cr>", keybindings = { "n", "so", opts } },
  { description = "Decrement Number", cmd = "<cmd>DialDecrement<cr>", keybindings = { "n", "<C-D>", opts } },
  { description = "Swap elements Mode", cmd = "<cmd>ISwap<cr>", keybindings = { "n", "<leader>s", opts } },
  { description = "Swap elemets with", cmd = "<cmd>ISwapWith<cr>", keybindings = { "n", "<leader>sw", opts } },
  {
    description = "Move highlighted text Up",
    cmd = ":move '<-2<cr>gv-gv",
    keybindings = {
      { "x", "K", opts },
      { "x", "<A-k>", opts },
    }
  },
  {
    description = "Move highlighted text Down",
    cmd = ":move '>+1<cr>gv-gv",
    keybindings = {
      { "x", "J", opts },
      { "x", "<A-j>", opts },
    }
  },
  { description = "Indent_ Block", cmd = ">gv", keybindings = { "x", "<Tab>", opts } },
  { description = "_Indent Block", cmd = "<gv", keybindings = { "x", "<S-Tab>", opts } },


  {
    description = "__________________Comment___________________",
    cmd = "",
  },
  { description = "Comment line", cmd = "<Plug>(comment_toggle_current_linewise)<cr>", keybindings = { "n", ",cc", opts } },
  { description = "Comment block", cmd = "<Plug>(comment_toggle_blockwise_visual)<cr>", keybindings = { "x", ",cc", opts } },


  {
    description = "_________________Bookmarks_________________",
    cmd = "",
  },
  { description = "Annotate Bookmark", cmd = "<cmd>BookmarkAnnotate<cr>", keybindings = { "n", "<leader>ba", opts } },
  { description = "Clear Bookmarks", cmd = "<cmd>BookmarkClear<cr>", keybindings = { "n", "<leader>bc", opts } },
  { description = "Toggle Bookmark", cmd = "<cmd>BookmarkToggle<cr>", keybindings = { "n", "<leader>bt", opts } },
  { description = "Next Bookmark", cmd = "<cmd>BookmarkNext<cr>", keybindings = { "n", "<leader>bn", opts } },
  { description = "Previous Bookmark", cmd = "<cmd>BookmarkPrev<cr>", keybindings = { "n", "<leader>bp", opts} },
  { description = "Bookmark current file", cmd = '<cmd>lua require("harpoon.mark").add_file()<cr>', keybindings = { "n", "<leader>bf", opts } },
  { description = "Show Bookmarked files", cmd = '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', keybindings = { "n", "<leader>sbf", opts } },
  { description = "Clear all Bookmarks", cmd = "<cmd>BookmarkClearAll<cr>" },
  { description = "Show all Bookmarks", cmd = "<cmd>lua require('telescope).extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>" },


  {
    description = "____________________Git____________________",
    cmd = "",
  },
  { description = "Lazygit", cmd = "<cmd>lua _LAZYGIT_TOGGLE()<cr>", keybindings = { "n", "<leader>lg", opts } },
  { description = "Next hunk", cmd = "<cmd>lua require 'gitsigns'.next_hunk()<cr>", keybindings = { "n", "<leader>nh", opts } },
  { description = "Previous hunk", cmd = "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", keybindings = { "n", "<leader>ph", opts } },
  { description = "Blame", cmd = "<cmd>GitBlameToggle<cr>", keybindings = { "n", "<leader>gb", opts } },
  { description = "Preview hunk", cmd = "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", keybindings = { "n", "<leader>ch", opts } },
  { description = "Reset hunk", cmd = "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", keybindings = { "n", "<leader>rh", opts } },
  { description = "Reset buffer", cmd = "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", keybindings = { "n", "<leader>rb", opts } },
  { description = "Stage hunk", cmd = "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", keybindings = { "n", "<leader>sh", opts } },
  { description = "Undo stage hunk", cmd = "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", keybindings = { "n", "<leader>us", opts } },
  { description = "Open changed file", cmd = "<cmd>Telescope git_status<cr>", keybindings = { "n", "<leader>oc", opts } },
  { description = "Checkout branch", cmd = "<cmd>Telescope git_branches<cr>", keybindings = { "n", "<leader>ab", opts } },
  { description = "Checkout commit", cmd = "<cmd>Telescope git_commits<cr>", keybindings = { "n", "<leader>co", opts } },
  { description = "Diff", cmd = "<cmd>Gitsigns diffthis HEAD<cr>" },
  { description = "Open Diffview", cmd = "<cmd>DiffviewOpen<cr>", keybindings = { "n", "<leader>od", opts } },
  { description = "Close Diffview", cmd = "<cmd>DiffviewClose<cr>", keybindings = { "n", "<leader>cd", opts } },
  { description = "File history", cmd = "<cmd>DiffviewFileHistory<cr>", keybindings = { "n", "<leader>dh", opts } },
  { description = "Focus files", cmd = "<cmd>DiffviewFocusFiles<cr>", keybindings = { "n", "<leader>df", opts } },
  { description = "Refresh", cmd = "<cmd>DiffviewRefresh<cr>", keybindings = { "n", "<leader>dr", opts } },
  { description = "View Log", cmd = "<cmd>DiffviewLog<cr>", keybindings = { "n", "<leader>vl", opts } },
  { description = "Toggle Diffview", cmd = "<cmd>DiffviewToggleFiles<cr>", keybindings = { "n", "<leader>td", opts } },


  {
    description = "____________________Gist___________________",
    cmd = "",
  },
  { description = "Create Anon", cmd = "<cmd>Gist -b -a<cr>" },
  { description = "Delete", cmd = "<cmd>Gist -d<cr>" },
  { description = "Fork", cmd = "<cmd>Gist -f<cr>" },
  { description = "Creat", cmd = "<cmd>Gist -b<cr>" },
  { description = "List", cmd = "<cmd>Gist -l<cr>" },
  { description = "Creat private", cmd = "<cmd>Gist -b -p<cr>" },


  {
    description = "____________LSP, Diagonstic, goto___________",
    cmd = "",
  },
  { description = "LSP info", cmd = "<cmd>LspInfo<cr>", },
  { description = "LSP instller info", cmd = "<cmd>LspInstallInfo<cr>", },
  { description = "Toggle_virtual_text", cmd = "<cmd>Lspsaga toggle_virtual_text<cr>", keybindings = { "n", "vt", opts } },
  { description = "Code Action", cmd = "<cmd>CodeActionMenu<cr>", keybindings = { "n", "ca", opts} },
  { description = "Format", cmd = "<cmd>lua vim.lsp.buf.formatting()<cr>" },
  { description = "Toggle Format", cmd = "<cmd>LspToggleAutoFormat<cr>" },
  { description = "Hover", cmd = "<cmd>lua vim.lsp.buf.hover()<cr>", keybindings = { "n", "<C-k>", opts } },
  { description = "_Preview Implementation", cmd = "<cmd>lua require('goto-preview').goto_preview_implementation()<cr>", keybindings = { "n", "<F5>", opts } },
  { description = "Preview Implementation_", cmd = "<cmd>lua vim.lsp.buf.implementation()<cr>", keybindings = { "n", "si", opts } },
  { description = "Preview Definition", cmd = "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", keybindings = { "n", "<F6>", opts } },
  { description = "Preview Declaration", cmd = "<cmd>lua vim.lsp.buf.declaration()<cr>", keybindings = { "n", "sd", opts } },
  { description = "Preview Reference", cmd = "<cmd>lua require('goto-preview').goto_preview_references()<cr>", keybindings = { "n", "<F7>", opts } },
  { description = "Workspace Diagnostics", cmd = "<cmd>TroubleToggle workspace_diagnostics<cr>", keybindings = { "n", "<F8>", opts } },
  { description = "Document Diagnostics", cmd = "<cmd>TroubleToggle document_diagnostics<cr>", keybindings = { "n", "<F9>", opts } },
  { description = "Diagnostics", cmd = "<cmd>lua vim.diagnostic.open_float()<cr>", keybindings = { "n", "od", opts } },
  { description = "List Diagnostics", cmd = "<cmd>lua vim.diagnostic.setloclist()<cr>", keybindings = { "n", "ld", opts } },
  { description = "Next Diagonstic", cmd = "<cmd>lua vim.diagnostic.goto_next()<cr>", keybindings = { "n", "nd", opts } },
  { description = "Previous Diagonstic", cmd = "<cmd>lua vim.diagnostic.goto_prev()<cr>", keybindings = { "n", "pd", opts } },
  { description = "Signature Help", cmd = "<cmd>lua vim.lsp.buf.signature_help()<cr>", keybindings = { "n", "sh", opts } },


  {
    description = "__________________Workspace________________",
    cmd = "",
  },
  { description = "List Workspace", cmd = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", keybindings = { "n", "lf", opts } },
  { description = "Add Workspace", cmd = "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>", keybindings = { "n", "af", opts } },
  { description = "Remove Workspace", cmd = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>", keybindings = { "n", "rf", opts } },
  { description = "Wrokspace diagnostics", cmd = "<cmd>TroubleToggle workspace_diagnostics<cr>", keybindings = { "n", "<F8>", opts } },
  { description = "projects", cmd = "<cmd>lua require('telescope').extensions.projects.projects()<cr>" },


  {
    description = "__________________Packer___________________",
    cmd = "",
  },
  { description = "Status", cmd = "<cmd>PackerStatus<cr>", keybindings = { "n", "<leader>ps", opts } },
  { description = "Install", cmd = "<cmd>PackerInstall<cr>", keybindings = { "n", "<leader>pi", opts } },
  { description = "Update", cmd = "<cmd>PackerUpdate<cr>", keybindings = { "n", "<leader>pu", opts } },
  { description = "Sync", cmd = "<cmd>PackerSync<cr>", keybindings = { "n", "<leader>sy", opts} },
  { description = "Compile", cmd = "<cmd>PackerCompile<cr>", keybindings = { "n", "<leader>pc", opts } },


  {
    description = "__________________SnipRun__________________",
    cmd = "",
  },
  { description = "Info", cmd = "<cmd>SnipInfo<cr>", keybindings = { "n", "<leader>si", opts } },
  { description = "Run file", cmd = "<cmd>%SnipRun<cr>", keybindings = { "n", "<leader>rf", opts } },
  { description = "Toggle", cmd = "<cmd>SnipRunToggle<cr>", keybindings = { "n", "<leader>st", opts } },
  { description = "Terminate", cmd = "<cmd>SnipTerminate<cr>", keybindings = { "n", "<leader>sx", opts } },
  { description = "Reset", cmd = "<cmd>SnipReset<cr>", keybindings = { "n", "<leader>sr", opts } },
  { description = "Clean Memory", cmd = "<cmd>SnipReplMemoryClean<cr>", keybindings = { "n", "<leader>cm", opts } },
  { description = "Close", cmd = "<cmd>SnipClose<cr>", keybindings = { "n", "<leader>sc", opts } },


  {
    description = "_________________Terminal__________________",
    cmd = "",
  },
  { description = "Terminal (1)", cmd = ":1ToggleTerm<cr>" },
  { description = "Terminal (2)", cmd = ":2ToggleTerm<cr>" },
  { description = "Terminal (3)", cmd = ":3ToggleTerm<cr>" },
  { description = "Terminal (4)", cmd = ":4ToggleTerm<cr>" },
  { description = "Node", cmd = "<cmd>lua _NODE_TOGGLE()<cr>", keybindings = { "n", "<leader>tn", opts } },
  { description = "Python", cmd = "<cmd>lua _PYTHON_TOGGLE()<cr>", keybindings = { "n", "<leader>tp", opts } },
  { description = "NCDU", cmd = "<cmd>lua _NCDU_TOGGLE()<cr>", keybindings = { "n", "<leader>tu", opts } },
  { description = "Htop", cmd = "<cmd>lua _HTOP_TOGGLE()<cr>", keybindings = { "n", "<leader>ht", opts } },
  { description = "Float Terminal", cmd = "<cmd>ToggleTerm direction=float<cr>", keybindings = { "n", "f\\", opts } },
  { description = "Horizontal Terminal", cmd = "<cmd>ToggleTerm size=10 direction=horizontal<cr>", keybindings = { "n", "<leader>th", opts } },
  { description = "Vertical Terminal", cmd = "<cmd>ToggleTerm size=90 direction=vertical<cr>", keybindings = { "n", "v\\", opts } },
  { description = "Toggle Terminal", cmd = "<cmd>ToggleTerm><cr>", keybindings = { "n", "\\", opts } },


  {
    description = "_________________Colorscheme________________",
    cmd = "",
  },
  { description = "Enable Transparency", cmd = "<cmd>TransparentToggle<cr>", keybindings = {"n", "<F10>", opts} },
  { description = "List Colorschemes", cmd = "<cmd>Telescope colorscheme<cr>", keybindings = {"n", "00", opts}},
  { description = "Gruvbox", cmd = "<cmd>colorscheme gruvbox<cr>", keybindings = {"n", "11", opts} },
  { description = "Tokyonight", cmd = "<cmd>colorscheme tokyonight<cr>", keybindings = {"n", "22", opts} },
  { description = "Tokyodark", cmd = "<cmd>colorscheme tokyodark<cr>", keybindings = {"n", "33", opts} },
  { description = "Darkplus", cmd = "<cmd>colorscheme darkplus<cr>", keybindings = {"n", "44", opts} },
  { description = "Doom-one", cmd = "<cmd>colorscheme doom-one<cr>", keybindings = {"n", "55", opts} },
  { description = "Onedark", cmd = "<cmd>colorscheme onedark<cr>", keybindings = {"n", "66", opts} },
  { description = "One_monokai", cmd = "<cmd>colorscheme one_monokai<cr>", keybindings = { "n", "77", opts } },
  { description = "Rose-pine", cmd = "<cmd>colorscheme rose-pine<cr>", keybindings = {"n", "88", opts} },
  { description = "Sonokai", cmd = "<cmd>colorscheme sonokai<cr>", keybindings = {"n", "99", opts} },

})

-- use a protected call so we don't error out on first use
local status_ok2, telescope = pcall(require, "telescope")
if not status_ok2 then
  return
end
telescope.setup {
  extensions = {
    command_center = {
      components = {
        command_center.component.DESCRIPTION,
        command_center.component.KEYBINDINGS,
        -- command_center.component.COMMAND,
      },
      auto_replace_desc_with_cmd = false,
    }
  }
}
