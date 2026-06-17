return {
  "mbbill/undotree",
  event = "VeryLazy",
  cmd = "UndotreeToggle",
  keys = {
    { "<F3>", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree 󰣜 " },
  },
  config = function()
    vim.cmd([[
            if has("persistent_undo")

            let target_path = expand('~/.custom_db/nvim/plugins/undotree/')

            " create the directory and any parent directories
            " if the location does not exist.
            if !isdirectory(target_path)
            call mkdir(target_path, "p", 0700)
            endif

            let &undodir=target_path
            set undofile
            endif
            ]])
  end,
}
