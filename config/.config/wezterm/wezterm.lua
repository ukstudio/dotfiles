local wezterm = require 'wezterm'

return {
  color_scheme = "tokyonight_night",
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
  font = wezterm.font 'Source Han Code JP',
  font_size = 16.0,
  keys = {
    {
      key = "r",
      mods = "SUPER|SHIFT",
      action = wezterm.action.PromptInputLine {
        description = "Enter new name for tab",
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end)
      }
    }
  }
}
