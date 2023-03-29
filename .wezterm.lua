local wezterm = require 'wezterm'
local LEFT_ARROW = utf8.char(0xe0b3);
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

function enumerate(tbl, func)
    local t = {}
    for k, v in pairs(tbl) do
        t[k] = func(v, k)
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

function powerline(text, is_last, index)
    local colors = {"#3c1361", "#52307c", "#663a82", "#7c5295", "#b491c8"}
    return {{
        Foreground = {
            Color = colors[index]
        }
    }, {
        Text = SOLID_LEFT_ARROW
    }, {
        Foreground = {
            Color = "#c0c0c0"
        }
    }, {
        Background = {
            Color = colors[index]
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
        return powerline(text, index == #texts, index)
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
        key = 'c',
        mods = 'CTRL',
        action = wezterm.action {
            CopyTo = "Clipboard"
        }
    }, -- CTRL+C for SIGINT
    {
        key = 'f',
        mods = 'CTRL',
        action = wezterm.action {
            Search = {
                Regex = ''
            }
        }
    }, {
        key = 'k',
        mods = 'CTRL',
        action = wezterm.action.ClearScrollback 'ScrollbackAndViewport'
    }, {
        key = 'v',
        mods = 'CTRL',
        action = wezterm.action {
            PasteFrom = "Clipboard"
        }
    }, {
        key = 'L',
        mods = 'CTRL',
        action = wezterm.action.ShowDebugOverlay
    }, {
        key = 'n',
        mods = 'SUPER',
        action = wezterm.action {
            SpawnTab = 'CurrentPaneDomain'
        }
    }, {
        key = "l",
        mods = 'LEADER',
        action = wezterm.action.ShowLauncher
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
