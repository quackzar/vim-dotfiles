return {
    "goolord/alpha-nvim",
    enabled = false,
    event = "VimEnter",
    opts = function()
        local theta = require("alpha.themes.theta")
        local dashboard = require("alpha.themes.dashboard")
        local version = vim.version()
        local nvim_version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
        if version.prerelease then
            -- there might be other kinds of prereleases, but currently it just writes 'dev'
            -- and nightly just sounds cooler.
            --
            -- Since we are nightly, we might want the modification date.
            -- We could also use the git-hash, but that does not say a lot by itself.
            -- We also might actually find the executable which we run,
            -- instead of just assuming it's the one in PATH.
            -- But given this will require looking up the current process and such,
            -- and the usual invocated exe is the one in PATH, it seems niche.
            local timestamp = vim.fn.system("which nvim | xargs ls -l | awk '{print $6, $7, \"-\", $8}' | tr -d '\n'")
            if vim.v.shell_error == 0 then
                nvim_version_info = nvim_version_info .. " (nightly | built " .. timestamp .. ")"
            else
                nvim_version_info = nvim_version_info .. " (nightly)"
            end
        end

        theta.header = {
            type = "text",
            val = nvim_version_info,
            opts = {
                position = "center",
                hl = "Type",
            },
        }
        table.insert(theta.config.layout, 3, theta.header)
        table.insert(theta.config.layout, 3, { type = "padding", val = 1 })

        theta.buttons.val = {
            { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
            { type = "padding", val = 1 },
            dashboard.button("s", "󰁯  Restore Session", [[<cmd>lua require("persistence").load()<cr>]]),
            dashboard.button("SPC f f", "󰮗  Find file"),
            dashboard.button("SPC f g", "  Live grep"),
            dashboard.button("SPC f z", "󰈸  Zoxide"),
            dashboard.button("e", "  New file", "<cmd>ene <bar> startinsert<CR>"),
            dashboard.button(
                "c",
                "  Configuration",
                [[<cmd>cd ~/.config/nvim/ <CR><cmd>lua require('persistence').load()<cr>]]
            ),
            dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<CR>"),
            dashboard.button("m", "  Mason", "<cmd>Mason<CR>"),
            dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
        }

        theta.footer = {
            type = "text",
            val = "",
            opts = {
                position = "center",
                hl = "Type",
            },
        }

        table.insert(theta.config.layout, { type = "padding", val = 2 })
        table.insert(theta.config.layout, theta.footer)
        return theta
    end,
    config = function(_, theta)
        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
            vim.cmd.close()
            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function()
                    require("lazy").show()
                end,
            })
        end

        require("alpha").setup(theta.config)

        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            callback = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                theta.footer.val = " Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            callback = function(info)
                vim.o.showtabline = 0
                vim.o.laststatus = 0
                vim.api.nvim_create_autocmd("BufUnload", {
                    buffer = info.buf,
                    callback = function()
                        vim.o.showtabline = 2
                        vim.o.laststatus = 3
                        return true
                    end,
                })
                return true
            end,
        })
    end,
}
