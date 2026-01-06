-- ~/.config/wezterm/wezterm.lua
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ---------------------------------------------------------
-- 🎨 Theme & Appearance
-- ---------------------------------------------------------
-- Matches your Starship "Storm" palette (#1a1b26 background)
config.color_scheme = "Tokyo Night Storm"

-- Window Transparency & Blur
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Window Look
-- "RESIZE" removes the native macOS title bar for a seamless look.
-- If you miss the title bar, change this back to "TITLE|RESIZE"
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"

config.window_padding = {
    left = 12,
    right = 12,
    top = 12,
    bottom = 12,
}

-- ---------------------------------------------------------
-- 🔤 Font Configuration
-- ---------------------------------------------------------
config.font = wezterm.font_with_fallback({
    -- Primary: Monaspace Neon (The "Cyberpunk/GitHub" look)
    -- Requires: brew install font-monaspace-nerd-font
    { family = "MonaspiceNe NF", weight = "Regular" },
    
    -- Fallback: Your original JetBrains Mono
    { family = "JetBrainsMono Nerd Font", weight = "Regular" },
})

config.font_size = 14.0

-- Enable ligatures and stylistic sets for Monaspace
config.harfbuzz_features = { 
    "calt", "liga", "dlig", 
    "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" 
}

-- ---------------------------------------------------------
-- ⚙️ General Settings
-- ---------------------------------------------------------
config.adjust_window_size_when_changing_font_size = false
config.front_end = "WebGpu"
config.animation_fps = 60

-- ---------------------------------------------------------
-- 📑 Tab Bar
-- ---------------------------------------------------------
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = true

-- ---------------------------------------------------------
-- ⌨️ Key Bindings
-- ---------------------------------------------------------
config.keys = {
    -- Window Management
    { key = "q", mods = "CTRL", action = act.ToggleFullScreen },
    { key = "'", mods = "CTRL", action = act.ClearScrollback("ScrollbackAndViewport") },
    
    -- macOS Native-like Bindings
    { key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
    { key = "h", mods = "CMD", action = act.Hide },
    { key = "m", mods = "CMD", action = act.ToggleFullScreen },

    -- Pane Splitting
    { key = "s", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "v", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    -- Pane Navigation (Alt + Arrows)
    { key = "LeftArrow", mods = "ALT", action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
    { key = "UpArrow", mods = "ALT", action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = "ALT", action = act.ActivatePaneDirection("Down") },
}

-- ---------------------------------------------------------
-- 🖱️ Mouse Bindings
-- ---------------------------------------------------------
config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
}

return config
