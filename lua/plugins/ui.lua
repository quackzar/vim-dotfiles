return {
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                title_pos = "center",
                relative = "editor",
            },
        },
    },

    { "echasnovski/mini.icons", version = "*" },

    {
        "windwp/windline.nvim",
        event = "VeryLazy",
        enabled = true,
        config = function()
            require("windline.bubblegum")
        end,
    },

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
            -- see: https://github.com/folke/noice.nvim/blob/main/lua/noice/config/routes.lua
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
                    },
                },
            },
        },
        keys = {
            {
                "<S-Enter>",
                function()
                    require("noice").redirect(vim.fn.getcmdline())
                end,
                mode = "c",
                desc = "Redirect Cmdline",
            },
        },
    },

    {
        "luukvbaal/statuscol.nvim",
        lazy = false,
        init = function()
            vim.o.signcolumn = "number"
            -- vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
            --     group = vim.api.nvim_create_augroup("set_diagnostic_sign_colors", { clear = true }),
            --     callback = function()
            --         local function h(name)
            --             return vim.api.nvim_get_hl(0, { name = name })
            --         end
            --         vim.api.nvim_set_hl(0, "DiagnosticSignError", { bg = h("DiagnosticVirtualTextError").bg, bold = true })
            --         vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { bg = h("DiagnosticVirtualTextWarn").bg, bold = true})
            --         vim.api.nvim_set_hl(0, "DiagnosticSignHint", { bg = h("DiagnosticVirtualTextHint").bg, bold = true})
            --         vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { bg = h("DiagnosticVirtualTextInfo").bg, bold = true})
            --     end,
            -- })
            local ERROR = vim.diagnostic.severity.ERROR
            local WARN = vim.diagnostic.severity.WARN
            local HINT = vim.diagnostic.severity.HINT
            local INFO = vim.diagnostic.severity.INFO
            vim.diagnostic.config {
                signs = {
                    text = {
                        [ERROR] = "",
                        [WARN] = "",
                        [HINT] = "",
                        [INFO] = "",
                    },
                    numhl = {
                        [ERROR] = "DiagnosticVirtualTextError",
                        [WARN] = "DiagnosticVirtualTextWarn",
                        [HINT] = "DiagnosticVirtualTextHint",
                        [INFO] = "DiagnosticVirtualTextInfo",
                        -- [ERROR] = "DiagnosticSignError",
                        -- [WARN] = "DiagnosticSignWarn",
                        -- [HINT] = "DiagnosticSignHint",
                        -- [INFO] = "DiagnosticSignInfo",
                    },
                },
            }
        end,
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup {
                ft_ignore = { "NeogitStatus", "NeogitPopup", "NeogitCommitMessage" },
                setopt = true,
                seperator = true,
                relculright = true,
                clickmod = "c", -- modifier used for certain actions in the builtin clickhandlers:
                segments = {
                    {
                        sign = { name = { "Dap.*" }, maxwidth = 1, auto = true },
                        click = "v:lua.ScSa",
                    },
                    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                    {
                        text = { builtin.lnumfunc },
                        sign = {
                            namespace = { "diagnostic" },
                            maxwidth = 1,
                            foldclosed = true,
                        },
                        click = "v:lua.ScSa", -- Use diagnostic callback
                    },
                    {
                        sign = {
                            namespace = { "gitsign*" },
                            maxwidth = 1,
                            colwidth = 1,
                            auto = false,
                            wrap = true,
                        },
                        click = "v:lua.ScSa",
                    },
                },
            }
        end,
    },

    {
        "rachartier/tiny-glimmer.nvim",
        event = "VeryLazy",
        priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
        opts = {
            overwrite = {
                auto_map = true,
                yank = { enabled = true },
                search = { enabled = true },
                paste = { enabled = true },
                undo = { enabled = true },
                redo = { enabled = true },
            },
        },
    },

    {
        "karb94/neoscroll.nvim",
        opts = {},
    },

    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        lazy = true,
        cmd = { "WindowsMaximize", "WindowsMaximizeVertically", "WindowsMaximizeHorizontally", "WindowsEqualize" },
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
        "yegappan/taglist", -- Like document-symbols or vista but for tags
    },

    {
        "folke/edgy.nvim",
        enabled = false,
        event = "VeryLazy",
        init = function()
            vim.opt.splitkeep = "screen"
        end,
        opts = {
            animate = {
                cps = 240,
            },
            bottom = {
                {
                    ft = "toggleterm",
                    size = { height = 0.4 },
                    -- exclude floating windows
                    filter = function(buf, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
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
                -- TODO: Make these 'share' a window i.e., replace eachother
                { ft = "NeogitStatus", size = { height = 0.4 } },
                { ft = "NeogitPopup", size = { height = 0.4 } },
                { ft = "NeogitCommitMessage", size = { height = 0.4 } },
            },
            left = {
                {
                    ft = "neo-tree",
                    title = "Filesystem",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "filesystem"
                    end,
                    pinned = true,
                },
                {
                    ft = "neo-tree",
                    title = "Document Symbols",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "document_symbols"
                    end,
                    pinned = true,
                    open = "Neotree position=top document_symbols",
                },
                {
                    ft = "neo-tree",
                    title = "Git Status",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "git_status"
                    end,
                    pinned = false,
                    open = "Neotree position=right git_status",
                },
                {
                    ft = "neo-tree",
                    title = "Buffers",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "buffers"
                    end,
                    pinned = false,
                    open = "Neotree position=top buffers",
                },
                -- {ft="DiffviewFiles"},
            },
            right = {
                { ft = "OverseerList", title = "Overseer", size = { width = 10 } },
                { ft = "aerial" },
                {
                    ft = "neo-tree",
                    title = "Neo-Tree",
                    -- filter = function(buf)
                    --     return vim.b[buf].neo_tree_source == "document_symbols"
                    -- end,
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

    {
        "tiagovla/scope.nvim", -- Makes tabs work like other editors
        config = true,
    },

    -- { "nvzone/volt", lazy = true },
    -- {
    --     "nvzone/menu",
    --     lazy = true,
    --     init = function()
    --         vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
    --             require("menu.utils").delete_old_menus()
    --
    --             vim.cmd.exec('"normal! \\<RightMouse>"')
    --
    --             -- clicked buf
    --             local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
    --             local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"
    --             -- TODO: Impl. neo-tree bindings
    --
    --             require("menu").open(options, { mouse = true })
    --         end, {})
    --     end,
    -- },

    {
        "brenoprata10/nvim-highlight-colors",
        opts = {
            render = "virtual",
            enable_named_colors = false,
        },
    },

    {
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
                local timestamp =
                    vim.fn.system("which nvim | xargs ls -l | awk '{print $6, $7, \"-\", $8}' | tr -d '\n'")
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
    },

    {
        "rcarriga/nvim-notify",
        enabled = true,
        opts = {
            render = "compact",
            background_colour = "#000000",
            timeout = 2000,
        },
        config = function(opts)
            require("notify").setup(opts)
            vim.notify = require("notify")
        end,
        init = function()
            vim.keymap.set({ "n", "i", "x" }, "<C-l>", function()
                require("notify").dismiss()
                vim.cmd("noh")
            end, { desc = "Dismiss" })
        end,
    },

    {
        "j-hui/fidget.nvim",
        enabled = false,
        event = "BufEnter",
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
        lazy = true,
        config = true,
        init = function()
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
        enabled = false,
        opts = {
            preset = "helix",
            plugins = {
                marks = true, -- shows a list of your marks on ' and `
                registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                spelling = {
                    -- Borked?
                    enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                    suggestions = 20, -- how many suggestions should be shown in the list?
                },
                presets = {
                    operators = true,
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = true, -- bindings for prefixed with g
                },
            },
            disable = {
                ft = { "neo-tree" },
            },
        },
        event = "VeryLazy",
    },

    {
        "echasnovski/mini.clue",
        enabled = false,
        version = false,
        event = "VimEnter",
        config = function()
            local miniclue = require("mini.clue")
            miniclue.setup {
                triggers = {
                    -- Leader triggers
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },

                    -- Built-in completion
                    { mode = "i", keys = "<C-x>" },

                    -- `g` key
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },

                    -- Marks
                    { mode = "n", keys = "'" },
                    { mode = "n", keys = "`" },
                    { mode = "x", keys = "'" },
                    { mode = "x", keys = "`" },

                    -- Registers
                    { mode = "n", keys = '"' },
                    { mode = "x", keys = '"' },
                    { mode = "i", keys = "<C-r>" },
                    { mode = "c", keys = "<C-r>" },

                    -- Window commands
                    { mode = "n", keys = "<C-w>" },

                    -- `z` key
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },

                    -- `[ and ]` key
                    { mode = "n", keys = "]" },
                    { mode = "x", keys = "]" },
                    { mode = "n", keys = "[" },
                    { mode = "x", keys = "[" },
                    -- '<localleader>'
                    { mode = "n", keys = "<localleader>" },
                    { mode = "x", keys = "<localleader>" },
                    -- Snippets
                    { mode = "i", keys = "<C-q>" },
                },
                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },
            }
        end,
    },

    {
        "sindrets/winshift.nvim",
        cmd = "WinShift",
    }, -- Used in a Hydra

    {
        "mrjones2014/smart-splits.nvim", -- Used in a Hydra
        lazy = true,
        config = true,
    },

    {
        "nvimtools/hydra.nvim",
        dependencies = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
        lazy = true,
        -- Maybe clean this up a bit, and trigger regitration on keys?
        config = function()
            require("cfg.hydra")
        end,
        keys = {
            "<space>f", -- Telescope
            "<space>g", -- Git
            "<space>t", -- Tests
            "<space>o", -- Options
            "<space>d", -- Debug
            "<C-w>", -- windows
        },
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
        "Bekaboo/deadcolumn.nvim",
        event = "BufEnter",
    },

    {
        "winston0410/range-highlight.nvim",
        dependencies = { "winston0410/cmd-parser.nvim" },
        config = true,
    },

    {
        "0xAdk/full_visual_line.nvim",
        keys = "V",
        opts = {},
    },

    { "meznaric/key-analyzer.nvim", opts = {} },
}
