if vim.g.neovide then
  vim.g.remember_window_size = true
  vim.g.remember_window_position = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_fullscreen = true
  vim.g.neovide_profiler = false

  vim.g.neovide_transparency = 0.8
  vim.g.neovide_scroll_animation_length = 0.9
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_vfx_mode = "railgun" -- Available: railgun, torpedo, pixiedust, sonicboom ,ripple ,wireframe
  vim.g.neovide_hide_mouse_when_typing = true

  local function toggle_transparency()
    if vim.g.neovide_transparency == 1.0 then
      vim.cmd("let g:neovide_transparency=0.8")
    else
      vim.cmd("let g:neovide_transparency=1.0")
    end
  end

  vim.keymap.set("n", "<leader>uv", toggle_transparency, { desc = "Toggle neovide transparency" })

  -- change font size with ( CTRL + = & CTRL + - )
  -- zoom
  vim.keymap.set("", "<c-=>", function()
    -- find & get current font size
    local _, _, font_size = vim.o.guifont:find(".*:h(%d+)$")
    font_size = tostring(tonumber(font_size) + 1)
    -- update the font size
    vim.o.guifont = string.gsub(vim.o.guifont, "%d+$", font_size)
  end, { noremap = true })
  -- dezoom
  vim.keymap.set("", "<c-->", function()
    -- find & get current font size
    local _, _, font_size = vim.o.guifont:find(".*:h(%d+)$")
    if tonumber(font_size) > 1 then
      font_size = tostring(tonumber(font_size) - 1)
      -- update the font size
      vim.o.guifont = string.gsub(vim.o.guifont, "%d+$", font_size)
    end
  end, { noremap = true })

  vim.keymap.set("n", "<leader>ke", function()
    vim.cmd("set norightleft")
    vim.cmd('"guifont = VictorMono\\ NF:h18"')
  end, { desc = "Change to 'English' layout  " })

  -- Right To Left layout
  vim.keymap.set("n", "<leader>ka", function()
    vim.cmd("set rightleft")
    -- Right To Left Fonts
    -- vim.cmd('"set guifont = "DejaVu Sans Mono:h18')
    -- vim.cmd('"set guifont = "Vazir Code Hack:h18"')
    -- vim.cmd('"set guifont = "Kawkab Mono:h18"')
  end, { desc = "Change to 'Right to Left' layout 󱌨 " })
end
