-- use a protected call so we don't error out on first use
local status_ok, wilder = pcall(require, "wilder")
if not status_ok then
  return
end

local gradient = {
  '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
  '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
  '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
  '#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
}

for i, fg in ipairs(gradient) do
  gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', {{a = 1}, {a = 1}, {foreground = fg}})
end

wilder.setup({
  modes = {':', '/', '?'},
})

wilder.set_option('renderer', wilder.wildmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  separator = ' · ',
  left = {' ', wilder.wildmenu_spinner(), ' '},
  right = {' ', wilder.wildmenu_index()},
}))

-- Fuzzy search | NOTE: kinda annoying
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      set_pcre2_pattern = 1,
    }),
    wilder.python_search_pipeline({
      pattern = 'fuzzy',
    })
  ),
})

wilder.set_option('renderer', wilder.popupmenu_renderer(

-- have it opened in the middle of the screen
  wilder.popupmenu_palette_theme({
    reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
    pumblend = 20,
    min_height = 0,          -- set to the same as 'max_height' for a fixed height window
    border = 'rounded',      -- 'single', 'double', 'rounded' or 'solid'
    max_height = '50%',      -- max height of the palette
    prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
    highlights = { gradient = gradient },
    highlighter = wilder.highlighter_with_gradient({ wilder.basic_highlighter() }),
    left = {' ', wilder.popupmenu_devicons()},
    right = {' ', wilder.popupmenu_scrollbar()},
  })

--[[
-- have it opened as normal
wilder.popupmenu_border_theme({
  highlights = { border = 'Normal' }, -- highlight to use for the border
  pumblend = 20,
  -- 'single', 'double', 'rounded' or 'solid'
  -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
  border = 'rounded',
  highlighter = wilder.basic_highlighter(),
  left = {' ', wilder.popupmenu_devicons()},
  right = {' ', wilder.popupmenu_scrollbar()},
})
]]

))
