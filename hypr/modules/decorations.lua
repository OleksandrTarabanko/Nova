-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 5,
        gaps_out         = 20,

        border_size      = 4,

        col              = {
            active_border   = { colors = { "#60DD2A" } },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing    = false,
    },

    decoration = {
        rounding         = 20,
        rounding_power   = 1,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow           = {
            enabled        = true,
            range          = 20,
            render_power   = 2,
            color          = 0x99050d00, --active_border
            color_inactive = 0xee121212, --inactive_border
        },

        blur             = {
            enabled  = true,
            size     = 3,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 5.0, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.0, spring = "easy", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "quick", style = "popin 80%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.75, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.0, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 4.0, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4.0, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.8, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.4, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4.5, bezier = "easeOutQuint", style = "slidefade 25%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "slidefade 25%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4.5, bezier = "easeOutQuint", style = "slidefade 25%" })
hl.animation({
    leaf = "specialWorkspace",
    enabled = true,
    speed = 3.0,
    bezier = "easeOutQuint",
    style =
    "slidefadevert 15%"
})
hl.animation({
    leaf = "specialWorkspaceIn",
    enabled = true,
    speed = 3.0,
    bezier = "easeOutQuint",
    style =
    "slidefadevert 15%"
})
hl.animation({
    leaf = "specialWorkspaceOut",
    enabled = true,
    speed = 3.0,
    bezier = "easeOutQuint",
    style =
    "slidefadevert 15%"
})
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
