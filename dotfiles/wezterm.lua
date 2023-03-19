local wezterm = require 'wezterm'
return {
  font = wezterm.font_with_fallback {
    {family = 'HackGen35 Console NFJ' },
  },
  color_scheme = "Sonokai (Gogh)",
  -- Overrides the cell background color when the current cell is occupied by the
  colors = {
    -- cursor and the cursor style is set to Block
    cursor_bg = '#5A6477',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = 'white',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#E1E3E4',
  },
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  keys = {
    {
      key = '¥',
      mods = 'ALT',
      action = wezterm.action.SendString '\x5C',
    }
  },
}
