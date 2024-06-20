local wezterm = require("wezterm")
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

function enumerate(tbl, func) -- almost same as python's enumerate(map with index)
	local t = {}
	for idx, v in ipairs(tbl) do
		t[idx] = func(v, idx)
	end
	return t
end
-- https://gist.github.com/w13b3/5d8a80fae57ab9d51e285f909e2862e0
function zip(...) -- almost same as python's zip
	local idx, ret, args = 1, {}, { ... }
	while true do -- loop smallest table-times
		local sub_table = {}
		for _, table_ in ipairs(args) do
			value = table_[idx] -- becomes nil if index is out of range
			if value == nil then
				break
			end -- break for-loop
			table.insert(sub_table, value)
		end
		if value == nil then
			break
		end -- break while-loop
		table.insert(ret, sub_table) -- insert the sub result
		idx = idx + 1
	end
	return ret
end

function flatten1(tbls) -- flatten 1 level
	local result = {}
	for index, tbl in next, tbls do
		for _, value in next, tbl do
			table.insert(result, value)
		end
	end
	return result
end

function day_of_week_in_japan(weeknum)
	local days = { "月", "火", "水", "木", "金", "土", "日" }
	return days[weeknum]
end

-- https://open-meteo.com/en/docs
function weather_symbol(weathercode)
	local weathers = {
		[-1] = "❓", -- undefined
		[0] = "☀️",
		[1] = "🌤",
		[2] = "🌦",
		[3] = "☁️",
		[45] = "🌫",
		[48] = "🌫",
		[51] = "🌦",
		[53] = "🌦",
		[55] = "🌧",
		[56] = "🌨",
		[57] = "🌨",
		[61] = "☂",
		[63] = "☔",
		[65] = "☔",
		[66] = "☂",
		[67] = "☔",
		[71] = "⛄",
		[73] = "☃",
		[75] = "☃",
		[77] = "🌨",
		[80] = "🌧",
		[81] = "☂",
		[82] = "☔",
		[85] = "🌨",
		[86] = "🌨",
		[95] = "⛈",
		[96] = "⛈",
		[99] = "⛈",
	}
	return weathers[weathercode]
end

function styled_whether(weathercode, temperature_max, temperature_min)
	return {
		{
			Foreground = {
				Color = "#c0c0c0",
			},
		},
		{
			Text = string.format(" %s", weather_symbol(weathercode)),
		},
		{
			Foreground = {
				Color = "#f08300", -- hot color
			},
		},
		{
			Text = string.format("%s", temperature_max),
		},
		{
			Foreground = {
				Color = "#c0c0c0",
			},
		},
		{
			Text = "|",
		},
		{
			Foreground = {
				Color = "#89c3eb", -- cool color
			},
		},
		{
			Text = string.format("%s ", temperature_min),
		},
	}
end

function powerline(styled_text, color) -- decorate right prompt
	return {
		{
			Foreground = {
				Color = color,
			},
		},
		{
			Text = SOLID_LEFT_ARROW,
		},
		{
			Background = {
				Color = color,
			},
		},
		table.unpack(styled_text),
	}
end

function update_whether()
	local success, stdout, stderr = wezterm.run_child_process({
		"curl",
		"--silent",
		"https://api.open-meteo.com/v1/forecast?latitude=35.7&longitude=139.82&daily=weathercode,temperature_2m_max,temperature_2m_min&forecast_days=3&timezone=Asia%2FTokyo",
	}) -- At Tokyo SkyTree
	if not success or not stdout then
		return
	end
	local res = wezterm.json_parse(stdout).daily
	wezterm.GLOBAL.daily_weather = res
end

function styled_current_git_branch(current_dir)
	local success, stdout, _stderr = wezterm.run_child_process({
		"git",
		"--git-dir",
		string.format("%s/.git", current_dir),
		"branch",
		"--show-current",
	})
	return {
		{
			Foreground = {
				Color = "#c0c0c0",
			},
		},
		{
			Text = success and string.format(" %s ", string.gsub(stdout, "^(.+)\n$", "%1")) or " ❓ ",
		},
	}
end

function create_powerlines(window, pane)
	local current_dir
	if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
		-- Windows: C:/Users/username/
		current_dir = (pane:get_current_working_dir() or ''):sub(9)
	else -- other: /home/username/
		current_dir = (pane:get_current_working_dir() or ''):sub(8)
	end
	local daily_weather = wezterm.GLOBAL.daily_weather
		or {
			weathercode = { -1, -1, -1 },
			temperature_2m_min = { "?", "?", "?" },
			temperature_2m_max = { "?", "?", "?" },
		}
	local weather_infos =
		zip(daily_weather.weathercode, daily_weather.temperature_2m_max, daily_weather.temperature_2m_min)
	local styled_whethers = enumerate(weather_infos, function(weather_info, index)
		return styled_whether(table.unpack(weather_info))
	end)
	local styled_texts = {
		styled_whethers[1],
		styled_whethers[2],
		styled_whethers[3],
		styled_current_git_branch(current_dir),
		{
			{
				Foreground = {
					Color = "#c0c0c0",
				},
			},
			{
				Text = string.format(" %s ", current_dir),
			},
		},
		{
			{
				Foreground = {
					Color = "#c0c0c0",
				},
			},
			{
				Text = string.format(
					" %s(%s) %s ",
					wezterm.strftime("%-m/%-d"),
					day_of_week_in_japan(tonumber(wezterm.strftime("%u"))),
					wezterm.strftime("%H:%M:%S")
				),
			},
		},
	}
	return flatten1(enumerate(styled_texts, function(styled_text, index)
		local color = string.format("hsl(%sdeg 75%% 25%%)", index % 2 == 0 and 240 or 224)
		return powerline(styled_text, color)
	end))
end

wezterm.on("update-status", function(window, pane)
	local counter = wezterm.GLOBAL.weather_loop_counter or 0
	if counter % (3600 * 4) == 0 then -- every 4 hours
		update_whether()
	end
	wezterm.GLOBAL.weather_loop_counter = counter + 1

	window:set_right_status(wezterm.format(create_powerlines(window, pane)))
end)

return {
	check_for_updates = false,
	color_scheme = "Monokai Remastered",
    colors = { scrollbar_thumb = '#888888' },
	cursor_blink_rate = 500,
	default_cursor_style = "BlinkingUnderline",
	disable_default_key_bindings = true,
    enable_scroll_bar = true,
	font = wezterm.font_with_fallback({ "Cica" }),
	font_size = 16.0,
	hyperlink_rules = {},
	keys = {
		{
			key = "Tab",
			mods = "ALT",
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "Tab",
			mods = "ALT|SHIFT",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "Enter",
			mods = "SUPER",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DecreaseFontSize,
		},
		{
			key = "-",
			mods = "ALT",
			action = wezterm.action.SplitVertical({
				domain = "CurrentPaneDomain",
			}),
		},
		{
			key = "1",
			mods = "ALT",
			action = wezterm.action.ActivateTab(0),
		},
		{
			key = "2",
			mods = "ALT",
			action = wezterm.action.ActivateTab(1),
		},
		{
			key = "3",
			mods = "ALT",
			action = wezterm.action.ActivateTab(2),
		},
		{
			key = "4",
			mods = "ALT",
			action = wezterm.action.ActivateTab(3),
		},
		{
			key = "5",
			mods = "ALT",
			action = wezterm.action.ActivateTab(4),
		},
		{
			key = "6",
			mods = "ALT",
			action = wezterm.action.ActivateTab(5),
		},
		{
			key = "7",
			mods = "ALT",
			action = wezterm.action.ActivateTab(6),
		},
		{
			key = "8",
			mods = "ALT",
			action = wezterm.action.ActivateTab(7),
		},
		{
			key = "9",
			mods = "ALT",
			action = wezterm.action.ActivateTab(8),
		},
		{
			key = "=",
			mods = "CTRL|SHIFT",
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "c", -- CTRL+C for SIGINT
			mods = "CTRL",
			action = wezterm.action({
				CopyTo = "Clipboard",
			}),
		},
		{
			key = "c",
			mods = "SUPER",
			action = wezterm.action({
				CopyTo = "Clipboard",
			}),
		},
		{
			key = "c",
			mods = "ALT|SUPER",
			action = wezterm.action.QuickSelect,
		},
		{
			key = "f",
			mods = "CTRL",
			action = wezterm.action({
				Search = {
					Regex = "",
				},
			}),
		},
		{
			key = "f",
			mods = "ALT",
			action = wezterm.action({
				Search = {
					Regex = "",
				},
			}),
		},
		{
			key = "f",
			mods = "SUPER",
			action = wezterm.action({
				Search = {
					Regex = "",
				},
			}),
		},
		{
			key = "k",
			mods = "ALT",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		{
			key = "k",
			mods = "SUPER",
			action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
		},
		{
			key = "l",
			mods = "SUPER",
			action = wezterm.action.ShowLauncher,
		},
		{
			key = "L",
			mods = "SUPER",
			action = wezterm.action.ShowDebugOverlay,
		},
		{
			key = "n",
			mods = "SUPER",
			action = wezterm.action({
				SpawnTab = "CurrentPaneDomain",
			}),
		},
		{
			key = "q",
			mods = "ALT",
			action = wezterm.action.PaneSelect,
		},
		{
			key = "r",
			mods = "SUPER",
			action = wezterm.action.ReloadConfiguration,
		},
		{
			key = "v",
			mods = "CTRL",
			action = wezterm.action({
				PasteFrom = "Clipboard",
			}),
		},
		{
			key = "v",
			mods = "SUPER",
			action = wezterm.action({
				PasteFrom = "Clipboard",
			}),
		},
		{
			key = "w",
			mods = "SUPER",
			action = wezterm.action.CloseCurrentTab({
				confirm = true,
			}),
		},
		{
			key = "\\",
			mods = "ALT",
			action = wezterm.action.SplitHorizontal({
				domain = 'CurrentPaneDomain'
			}),
		},
		{
			key = "LeftArrow",
			mods = "ALT",
			action = wezterm.action.ActivateTabRelative(-1),
		},
		{
			key = "RightArrow",
			mods = "ALT",
			action = wezterm.action.ActivateTabRelative(1),
		},
		{
			key = "LeftArrow",
			mods = "ALT|SHIFT",
			action = wezterm.action.MoveTabRelative(-1),
		},
		{
			key = "RightArrow",
			mods = "ALT|SHIFT",
			action = wezterm.action.MoveTabRelative(1),
		},
		{
			key = "UpArrow",
			mods = "ALT",
			action = wezterm.action.ScrollByPage(-1),
		},
		{
			key = "DownArrow",
			mods = "ALT",
			action = wezterm.action.ScrollByPage(1),
		},
	},
	leader = {
		key = "q",
		mods = "CTRL",
		timeout_milliseconds = 2000,
	},
	scrollback_lines = 200000,
	unix_domains = {
		{
			name = "unix",
		},
	},
	tab_max_width = 24,
	use_dead_keys = false,
	window_decorations = "RESIZE", -- no title bar
	window_background_opacity = 0.7,
}
