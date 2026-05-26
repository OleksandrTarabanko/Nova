------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Default screen
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- External monitor (positioned to the right of the laptop)
hl.monitor({
    output   = "DP-1",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- -- Workspaces 1-5 stay on the laptop screen
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1", persistent = true })

-- -- Workspaces 6-10 stay on the external monitor (any connected display)
hl.workspace_rule({ workspace = "6", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "7", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "8", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "9", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "10", monitor = "DP-1", persistent = true })
