return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { desc = "Tmux Nav LEFT " } },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { desc = "Tmux Nav DOWN " } },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { desc = "Tmux Nav UP " } },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { desc = "Tmux Nav RIGHT " } },
  },
}
