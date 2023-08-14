local wezterm = require("wezterm")

local function font_with_fallback(name, params)
  local names = { name, "Apple Color Emoji", "HackGenNerd Console" }
  return wezterm.font_with_fallback(names, params)
end

local font_name = "HackGen Console NF With FFxiv Glyph"

return {
  front_end = "OpenGL",
  enable_wayland = false,

  color_scheme = 'Dracula (Official)',

  font = font_with_fallback(font_name),
  font_rules = {
    {
      italic = true,
      font = font_with_fallback(font_name, { italic = true }),
    },
    {
      italic = true,
      intensity = "Bold",
      font = font_with_fallback(font_name, { italic = true, bold = true }),
    },
    {
      intensity = "Bold",
      font = font_with_fallback(font_name, { bold = true }),
    },
  },
  warn_about_missing_glyphs = false,
  font_size = 24,
  line_height = 1.0,

  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  show_tab_index_in_tab_bar = false,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,

  window_padding = {
    left = 25,
    right = 4,
    top = 25,
    bottom = 25,
  },

  disable_default_key_bindings = true,
  keys = {
    {
      key = "y",
      mods = "CTRL|SHIFT",
      action = "ActivateCopyMode",
    },
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ PasteFrom = "Clipboard" }),
    },
    {
      key = "c",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
    },
    {
      key = "t",
      mods = "CTRL|SHIFT",
      action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
    },
  },


  audible_bell = "Disabled",
  automatically_reload_config = true,
  window_background_opacity = 0.7,
  window_close_confirmation = "NeverPrompt",
}
