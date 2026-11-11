-- General variables
local mod = "SUPER"
local terminal = "kitty"
local menu = "wofi"

-- Monitor output settings
hl.monitor({
    output = "DP-1",
    mode = "1920x1080@119.98",
    position = "0x0",
    scale = 1,
    icc = "/etc/nixos/hosts/desktop/files/ULTRAGEAR.icm"
})

-- General config
hl.config({
    general = {
        layout = "master",

        allow_tearing = false,

        gaps_in = 6,
        gaps_out = 12,
        border_size = 1,

        col = {
            active_border = "0xcc007aff",
            inactive_border = "0x0d000000",
        },
    },

    decoration = {
        rounding = 16,
        rounding_power = 4,
        active_opacity = 0.9,
        inactive_opacity = 0.85,

        blur = {
          enabled = true,
          size = 12,
          passes = 4,
          new_optimizations = true,

          vibrancy = 0.6,
          vibrancy_darkness = 0.0,
          noise = 0.015,
          contrast = 0.95,
          brightness = 1.25,
        },
        shadow = {
            enabled = true,
            range = 24,
            render_power = 5,
            color = "0x33000000"
        }
    },
    binds = {
        drag_threshold = 10,
    }
})
-- Animations

hl.curve("Ease",{type="bezier", points={{0.25, 1}, {0.5, 1}}})
hl.curve("Bounce",{type="bezier", points={{0.34, 1.56}, {0.64, 1}}})

hl.animation({leaf="windows", enabled=true, speed=5, bezier="Bounce", style="popin 80%"})
hl.animation({leaf="windowsOut", enabled=true, speed=4, bezier="Bounce", style="popin 80%"})
hl.animation({leaf="workspaces", enabled=true, speed=6, bezier="Ease", style="slide"})
hl.animation({leaf="layers", enabled=true, speed=4, bezier="Bounce", style="popin 90%"})


-- Keybinds
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd(terminal))

hl.bind(mod .. " + F", hl.dsp.window.float())
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen())

hl.bind(mod .. " + M", hl.dsp.exec_cmd("wlogout"))

hl.bind(mod .. " + S", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))

-- Window focus
hl.bind(mod .. " + H", hl.dsp.focus({direction = "left"}))
hl.bind(mod .. " + J", hl.dsp.focus({direction = "down"}))
hl.bind(mod .. " + K", hl.dsp.focus({direction = "up"}))
hl.bind(mod .. " + L", hl.dsp.focus({direction = "right"}))

-- Window move
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({direction = "left"}))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({direction = "down"}))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({direction = "up"}))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({direction = "right"}))

-- Workspace switching & window moving
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({direction = "left"}))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({direction = "down"}))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({direction = "up"}))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({direction = "right"}))

for i = 1, 9 do
    hl.bind(mod .. " + " ..tostring(i), hl.dsp.focus({workspace=i}))
    hl.bind(mod .. " + SHIFT +" ..tostring(i), hl.dsp.window.move({workspace=i}))
end

-- Mouse binds
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .." + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- added windowrule for kitty, it started in maximized for some reason
hl.window_rule({
    match = {class = "kitty"},
    fullscreen_state = 0
})

hl.window_rule({
    match = {class = "^(Minecraft.*)$"},
    opacity = "1 override"
})

hl.window_rule({
    match = {xwayland = true, float = true},
    rounding = 0,
    no_shadow = true,
    border_size = 0,
    no_blur = true,
})

hl.layer_rule({
    match = {namespace = "waybar"},
    blur = true,
    ignore_alpha = .5
})

hl.layer_rule({
    match = {namespace = "wofi"},
    blur = true,
    ignore_alpha = .5
})

-- Animations
