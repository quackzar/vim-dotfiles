return {
    "stevearc/dressing.nvim",
    "windwp/windline.nvim",

    {
        "folke/noice.nvim",
        enabled = true,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        -- We still lack bar based cursor for it to be nice.
        -- We need to configure/disable some other plugins based on this
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                command_palette = false, -- position the cmdline and popupmenu together
                bottom_search = true,
                long_message_to_split = true,
            },
            popupmenu = {
                enabled = true,
                backend = "cmp",
                relative = "editor",
            },
            routes = {
                {
                    filter = {
                        event = "msg_show",
                        kind = "search_count",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "written",
                    },
                    opts = { skip = true },
                },
                {
                    filter = {
                        event = "msg_show",
                        kind = "",
                        find = "lines",
                    },
                    opts = { skip = true },
                },
                {
                    view = "mini",
                    filter = {
                        event = "msg_show",
                        kind = "",
                    },
                },
            },
        },
    },

    {
        "luukvbaal/statuscol.nvim",
        lazy = false,
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup {
                setopt = true,
                seperator = true,
                relculright = true,
                segments = {
                    -- {
                    --     sign = { name = { "Diagnostic" }, maxwidth = 1, auto = true },
                    --     click = "v:lua.ScSa"
                    -- },
                    {
                        sign = { name = { ".*" }, maxwidth = 1, auto = true },
                        click = "v:lua.ScSa",
                    },
                    {
                        text = { builtin.foldfunc, " " },
                        click = "v:lua.ScFa",
                    },
                    {
                        text = { builtin.lnumfunc, " " },
                        click = "v:lua.ScLa",
                    },
                    {
                        sign = { name = { "GitSign" }, maxwidth = 1, colwidth = 1, auto = true },
                        click = "v:lua.ScSa",
                    },
                },
            }
        end,
    },

    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require("windows").setup {
                autowidth = {
                    enable = false,
                },
                ignore = {
                    buftype = { "quickfix" },
                    filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "packer", "OverseerList" },
                },
            }
        end,
    },

    {
        "folke/edgy.nvim",
        enabled = false,
        event = "VeryLazy",
        opts = {
            fix_win_height = vim.fn.has("nvim-0.10.0") == 0,
            animate = {
                cps = 240,
            },
            bottom = {
                { ft = "toggleterm", size = { height = 0.4 } },
                {
                    ft = "lazyterm",
                    title = "LazyTerm",
                    size = { height = 0.4 },
                    filter = function(buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
                "Trouble",
                { ft = "qf", title = "QuickFix" },
                {
                    ft = "help",
                    size = { height = 30 },
                    -- only show help buffers
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                },
                { ft = "NeogitStatus", size = { height = 0.4 } },
            },
            left = {
                {
                    ft = "neo-tree",
                    title = "Neo-Tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source ~= "document_symbols"
                    end,
                },
                -- {ft="DiffviewFiles"},
            },
            right = {
                { ft = "OverseerList", title = "Overseer", size = { width = 10 } },
                { ft = "aerial" },
                {
                    ft = "neo-tree",
                    title = "Neo-Tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "document_symbols"
                    end,
                },
                { ft = "Outline" },
                { ft = "neotest-summary", title = "Neotest Summary" },
                { ft = "Table of contents (VimTeX)", title = "Table of Contents" },
            },
        },
        setup = function(_, opts)
            opts.animation.spinner = require("noice.util.spinners").spinners.circleFull
            require("edgy").setup(opts)
        end,
    },

    "famiu/bufdelete.nvim",

    {
        "tiagovla/scope.nvim", -- Makes tabs work like other editors
        config = true,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = true,
    },

    "rktjmp/lush.nvim",

    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local theta = require("alpha.themes.theta")
            local dashboard = require("alpha.themes.dashboard")
            local version = vim.version()
            local nvim_version_info = "v" .. version.major .. "." .. version.minor .. "." .. version.patch
            if version.prerelease then
                nvim_version_info = nvim_version_info .. " (nightly)"
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
                dashboard.button("s", "󰁯  Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("SPC f f", "󰮗  Find file"),
                dashboard.button("SPC f g", "  Live grep"),
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
                    theta.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
                    pcall(vim.cmd.AlphaRedraw)
                end,
            })
        end,
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    },

    {
        "j-hui/fidget.nvim",
        event = "BufEnter",
        enabled = false, -- "Note; not currently used with noice"
        config = function()
            require("fidget").setup {
                text = {
                    spinner = "dots",
                    done = " ", -- character shown when all tasks are complete
                },
            }
        end,
    },

    {
        "kevinhwang91/nvim-hlslens",
        event = "VimEnter",
        config = function()
            require("hlslens").setup()
            vim.keymap.set(
                { "n", "x" },
                "n",
                "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
                { desc = "next" }
            )
            vim.keymap.set(
                { "n", "x" },
                "N",
                "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
                { desc = "prev" }
            )
            vim.keymap.set("", "*", "*<Cmd>lua require('hlslens').start()<CR>", { desc = "star-search" })
            vim.keymap.set("", "#", "#<Cmd>lua require('hlslens').start()<CR>", { desc = "hash-search" })
            vim.keymap.set("", "g*", "*<Cmd>lua require('hlslens').start()<CR>", { desc = "g-star-search" })
            vim.keymap.set("", "g#", "#<Cmd>lua require('hlslens').start()<CR>", { desc = "g-hash-search" })
        end,
    },

    {
        "folke/which-key.nvim",
        opts = {
            plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                spelling = {
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = false, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = true, -- bindings for prefixed with g
                },
            },
            hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>" }, -- hide mapping boilerplate
            operators = { gc = "Comments" },
            ignore_missing = false, -- fun if one decides to register everything
            disable = {
                filetypes = { "neo-tree" },
            },
            triggers_blacklist = {
                n = { "<leader>g", "<leader>d", "<leader>f" },
            },
        },
        event = "VeryLazy",
    },

    "sindrets/winshift.nvim", -- Used in a Hydra
    {
        "mrjones2014/smart-splits.nvim", -- Used in a Hydra
        config = true,
    },

    {
        "anuvyklack/hydra.nvim",
        dependencies = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
        config = function()
            require("cfg.hydra")
        end,
    },

    {
        "folke/twilight.nvim",
        config = true,
    },

    {
        "folke/zen-mode.nvim",
        config = true,
    },

    -- {
    --     "declancm/cinnamon.nvim",
    --     config = {
    --         extra_keymaps = true,
    --         extended_keymaps = false,
    --         scroll_limit = 100,
    --         hide_cursor = false,
    --         default_delay = 5,
    --         max_length = 500,
    --     },
    -- },

    {
        "karb94/neoscroll.nvim",
        config = true,
    },

    {
        "eandrju/cellular-automaton.nvim",
        lazy = true,
    },

    {
        "Bekaboo/deadcolumn.nvim",
    },
}
