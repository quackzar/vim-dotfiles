local function get_version()
    local version = vim.version()
    local nvim_version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
    if version.prerelease then
        -- there might be other kinds of prereleases, but currently it just writes 'dev'
        -- and nightly just sounds cooler.
        --
        -- Since we are nightly, we might want the modification date.
        -- We could also use the git-hash, but that does not say a lot by itself.
        -- We also might actually find the executable which we run, instead of just assuming it's the one in PATH.
        -- But given this will require looking up the current process and such,
        -- and the usual invocated exe is the one in PATH, it seems niche.
        local timestamp = vim.fn.system("which nvim | xargs ls -l | awk '{print $6, $7, \"-\", $8}' | tr -d '\n'")
        if vim.v.shell_error == 0 then
            nvim_version_info = nvim_version_info .. " (nightly | built " .. timestamp .. ")"
        else
            nvim_version_info = nvim_version_info .. " (nightly)"
        end
    end
    return nvim_version_info
end

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            words = { enabled = false },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { title = get_version(), align = "center" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                },
                preset = {
                    keys = {
                        {
                            icon = " ",
                            key = "f",
                            desc = "Find File",
                            action = ":lua Snacks.dashboard.pick('files')",
                        },
                        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "r",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = "󰒲 ",
                            key = "L",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        { icon = " ", key = "M", desc = "Mason", action = ":Mason" },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
            },
            keys = {
                {
                    "<c-/>",
                    function()
                        Snacks.terminal("fish")
                    end,
                    desc = "Toggle Terminal",
                },
                {
                    "<c-_>",
                    function()
                        Snacks.terminal("fish")
                    end,
                    desc = "which_key_ignore",
                },
                -- { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
                -- { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
            },
        },
    },
}
