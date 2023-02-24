local wezterm = require 'wezterm'

return {
    check_for_updates = false,
    color_scheme = "Monokai Remastered",
	cursor_blink_rate = 500,
    default_cursor_style = 'BlinkingUnderline',
    disable_default_key_bindings = true,
    font = wezterm.font_with_fallback({'FiraCode Nerd Font', 'JetBrains Mono'}),
    font_size = 16.0,
    keys = {
        {key = 'c', mods = 'CTRL', action = wezterm.action {CopyTo = "Clipboard"}}, -- CTRL+C for SIGINT
        {key = 'f', mods = 'CTRL', action = wezterm.action {Search = {Regex = ''}}},
        {key = 'k', mods = 'CTRL', action = wezterm.action.ClearScrollback 'ScrollbackAndViewport'},
        {key = 'v', mods = 'CTRL', action = wezterm.action {PasteFrom = "Clipboard"}},
        {key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay},
        {key = 'n', mods = 'SUPER', action = wezterm.action {SpawnTab = 'CurrentPaneDomain'}},
        {key = "l", mods = 'LEADER', action = wezterm.action.ShowLauncher},
    },
    leader = {key = 'a', mods = 'CTRL', timeout_milliseconds = 2000},
    scrollback_lines = 200000,
    tab_max_width = 24,
    use_dead_keys = false,
    window_decorations = 'RESIZE', -- no title bar
    window_background_opacity = 0.75,
}

