local wezterm = require 'wezterm'
return {
  font = wezterm.font_with_fallback {
    {family = 'HackGen35 Console NFJ' },
  },
  color_scheme = "Sonokai (Gogh)",
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
