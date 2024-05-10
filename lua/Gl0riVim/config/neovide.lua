local control_center_status, settings = pcall(require, "control_center")
if not control_center_status then
  vim.notify("[settings] failed to load within (neovide.lua)", vim.log.levels.WARN)
  return
end

local nv_opts = settings.neovide

if vim.g.neovide then
  vim.g.remember_window_size = nv_opts.remember_window_size
  vim.g.remember_window_position = nv_opts.remember_window_position
  vim.g.neovide_refresh_rate = nv_opts.neovide_refresh_rate
  vim.g.neovide_fullscreen = nv_opts.neovide_fullscreen
  vim.g.neovide_profiler = nv_opts.neovide_profiler

  vim.g.neovide_transparency = nv_opts.neovide_transparency
  vim.g.neovide_scroll_animation_length = nv_opts.neovide_scroll_animation_length
  vim.g.neovide_cursor_animate_in_insert_mode = nv_opts.neovide_cursor_animate_in_insert_mode
  vim.g.neovide_cursor_vfx_mode = nv_opts.neovide_cursor_vfx_mode -- Available: railgun, torpedo, pixiedust, sonicboom ,ripple ,wireframe
  vim.g.neovide_hide_mouse_when_typing = nv_opts.neovide_hide_mouse_when_typing

  local function toggle_transparency()
    if vim.g.neovide_transparency == 1.0 then
      vim.cmd("let g:neovide_transparency=0.8")
    else
      vim.cmd("let g:neovide_transparency=1.0")
    end
  end
  vim.keymap.set("n", nv_opts.t_neovide_transparency, toggle_transparency, { desc = "Toggle neovide transparency" })

  -- change font size with ( CTRL + = & CTRL + - )
  -- zoom
  vim.keymap.set("", nv_opts.zoom_key, function()
    -- find & get current font size
    local _, _, font_size = vim.o.guifont:find(".*:h(%d+)$")
    font_size = tostring(tonumber(font_size) + 1)
    -- update the font size
    vim.o.guifont = string.gsub(vim.o.guifont, "%d+$", font_size)
  end, { noremap = true })
  -- dezoom
  vim.keymap.set("", nv_opts.dezoom_key, function()
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
    -- guifont = "DejaVu Sans Mono:h18",
    -- guifont = "Vazir Code Hack:h18",
    vim.cmd('"guifont = "Kawkab Mono:h18"')
  end, { desc = "Change to 'Right to Left' layout 󱌨 " })
end
