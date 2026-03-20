local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 테마
config.color_scheme = "Tokyo Night"

-- 폰트
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 14.0

-- 투명도 (0.0 완전 투명 ~ 1.0 불투명)
config.window_background_opacity = 0.82
config.macos_window_background_blur = 20

-- 창 스타일
config.window_decorations = "RESIZE"         -- 타이틀바 없이 깔끔하게
config.window_padding = {
  left = 12,
  right = 12,
  top = 10,
  bottom = 8,
}

-- 탭바
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

-- 커서
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- 스크롤
config.scrollback_lines = 10000

-- Claude Code 상태 패널 (CTRL+SHIFT+\  →  우측 30% 패널)
config.keys = {
  {
    key = '\\',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 30 },
      command = {
        args = { 'bash', '-c', 'while true; do clear; bash ~/.claude/panel.sh; sleep 5; done' },
      },
    },
  },
}

-- 렌더링
config.front_end = "WebGpu"
config.animation_fps = 60

return config
