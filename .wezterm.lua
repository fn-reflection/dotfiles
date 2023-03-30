local wezterm = require 'wezterm'
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

function enumerate(tbl, func)
    local t = {}
    for idx, v in ipairs(tbl) do
        t[idx] = func(v, idx)
    end
    return t
end

function flatten1(tbls)
    local result = {}
    for index, tbl in next, tbls do
        for _, value in next, tbl do
            table.insert(result, value)
        end
    end
    return result
end

function day_of_week_in_japan(weeknum)
    local days = {"日", "月", "火", "水", "木", "金", "土"}
    return days[weeknum + 1]
end

function powerline(text, color)
    return {{
        Foreground = {
            Color = color
        }
    }, {
        Text = SOLID_LEFT_ARROW
    }, {
        Background = {
            Color = color
        }
    }, {
        Foreground = {
            Color = "#c0c0c0"
        }
    }, {
        Text = string.format(" %s ", text)
    }}
end

function update_right_status(window, pane)
    local texts = {(pane:get_current_working_dir() or ""):sub(8),
                   string.format("%s(%s) %s", wezterm.strftime("%-m/%-d"), day_of_week_in_japan(wezterm.strftime("%u")),
        wezterm.strftime("%H:%M:%S"))};
    local powerlines = flatten1(enumerate(texts, function(text, index)
        local colors = {"#3c1361", "#52307c", "#663a82", "#7c5295", "#b491c8"}
        return powerline(text, colors[index])
    end));
    window:set_right_status(wezterm.format(powerlines))
end

wezterm.on("update-right-status", function(window, pane)
    update_right_status(window, pane)
end);

return {
    check_for_updates = false,
    color_scheme = "Monokai Remastered",
    cursor_blink_rate = 500,
    default_cursor_style = 'BlinkingUnderline',
    disable_default_key_bindings = true,
    font = wezterm.font_with_fallback({'FiraCode Nerd Font', 'Cica'}),
    font_size = 16.0,
    keys = {{
        key = 'Tab',
        mods = 'ALT',
        action = wezterm.action.ActivateTabRelative(1)
    }, {
        key = 'Tab',
        mods = 'ALT|SHIFT',
        action = wezterm.action.ActivateTabRelative(-1)
    }, {
        key = 'Enter',
        mods = 'ALT',
        action = wezterm.action.ToggleFullScreen
    }, {
        key = 'Enter',
        mods = 'SUPER',
        action = wezterm.action.ToggleFullScreen
    }, {
        key = '1',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(0)
    }, {
        key = '2',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(1)
    }, {
        key = '3',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(2)
    }, {
        key = '4',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(3)
    }, {
        key = '5',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(4)
    }, {
        key = '6',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(5)
    }, {
        key = '7',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(6)
    }, {
        key = '8',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(7)
    }, {
        key = '9',
        mods = 'ALT',
        action = wezterm.action.ActivateTab(8)
    }, {
        key = '-',
        mods = 'ALT',
        action = wezterm.action.DecreaseFontSize
    }, {
        key = '-',
        mods = 'SUPER',
        action = wezterm.action.SplitVertical {
            domain = "CurrentPaneDomain"
        }
    }, {
        key = '=',
        mods = 'ALT',
        action = wezterm.action.IncreaseFontSize
    }, {
        key = 'c', -- CTRL+C for SIGINT
        mods = 'CTRL',
        action = wezterm.action {
            CopyTo = "Clipboard"
        }
    }, {
        key = 'c',
        mods = 'SUPER',
        action = wezterm.action {
            CopyTo = "Clipboard"
        }
    }, {
        key = 'c',
        mods = 'ALT|SUPER',
        action = wezterm.action.QuickSelect
    }, {
        key = 'f',
        mods = 'CTRL',
        action = wezterm.action {
            Search = {
                Regex = ''
            }
        }
    }, {
        key = 'f',
        mods = 'ALT',
        action = wezterm.action {
            Search = {
                Regex = ''
            }
        }
    }, {
        key = 'f',
        mods = 'SUPER',
        action = wezterm.action {
            Search = {
                Regex = ''
            }
        }
    }, {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.ClearScrollback('ScrollbackAndViewport')
    }, {
        key = 'k',
        mods = 'SUPER',
        action = wezterm.action.ClearScrollback('ScrollbackAndViewport')
    }, {
        key = "l",
        mods = 'SUPER',
        action = wezterm.action.ShowLauncher
    }, {
        key = 'L',
        mods = 'SUPER',
        action = wezterm.action.ShowDebugOverlay
    }, {
        key = 'n',
        mods = 'SUPER',
        action = wezterm.action {
            SpawnTab = 'CurrentPaneDomain'
        }
    }, {
        key = 'q',
        mods = 'ALT',
        action = wezterm.action.PaneSelect
    }, {
        key = 'r',
        mods = 'SUPER',
        action = wezterm.action.ReloadConfiguration
    }, {
        key = 'v',
        mods = 'CTRL',
        action = wezterm.action {
            PasteFrom = "Clipboard"
        }
    }, {
        key = 'v',
        mods = 'SUPER',
        action = wezterm.action {
            PasteFrom = "Clipboard"
        }
    }, {
        key = 'w',
        mods = 'SUPER',
        action = wezterm.action.CloseCurrentTab {
            confirm = true
        }
    }, {
        key = '\\',
        mods = 'SHIFT|SUPER',
        action = wezterm.action.SplitHorizontal {
            domain = "CurrentPaneDomain"
        }
    }, {
        key = 'LeftArrow',
        mods = 'ALT',
        action = wezterm.action.MoveTabRelative(-1)
    }, {
        key = 'RightArrow',
        mods = 'ALT',
        action = wezterm.action.MoveTabRelative(1)
    }, {
        key = 'UpArrow',
        mods = 'ALT',
        action = wezterm.action.ScrollByPage(-1)
    }, {
        key = 'DownArrow',
        mods = 'ALT',
        action = wezterm.action.ScrollByPage(1)
    }},
    leader = {
        key = 'q',
        mods = 'CTRL',
        timeout_milliseconds = 2000
    },
    scrollback_lines = 200000,
    tab_max_width = 24,
    use_dead_keys = false,
    window_decorations = 'RESIZE', -- no title bar
    window_background_opacity = 0.75
}
