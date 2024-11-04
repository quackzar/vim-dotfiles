return {

    -- LSP + Snippets {{{
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-nvim-dap.nvim",
        "neovim/nvim-lspconfig",
    },

    {
        "luckasRanarison/clear-action.nvim",
        event = "LspAttach",
        opts = {
            signs = {
                position = "right_align",
                icons = {
                    quickfix = "  ",
                    refactor = "  ",
                    source = "  ",
                    combined = "  ", -- used when combine is set to true
                },
            },
            mappings = {
                -- TODO: Somehow work the new default mapping `crr` and `<C-r>r` (<C-r><C-r>) into these.
                code_action = { "<leader>a", "apply code action" },
                quickfix = { "<leader>q", "apply quickfix" },
                quickfix_next = { "]a", "apply next quickfix" },
                quickfix_prev = { "[a", "apply prev quickfix" }, -- tries to fix the previous diagnostic
                -- Consider this as a Hydra or prefixed with a 'refactor' mapping.
                refactor = { "<leader>rr", "apply refactor" },
                refactor_inline = { "<leader>ri", "refactor inline" },
                refactor_extract = { "<leader>re", "refactor extract" },
                refactor_rewrite = { "<leader>rw", "refactor rewrite" },
                source = { "<leader>s", "apply source" },
                actions = {
                    -- example:
                    ["rust_analyzer"] = {
                        -- ["Inline"] = "<leader>ai"
                        ["Add braces"] = { "<leader>rb", "Add braces" },
                        ["Insert explicit type"] = { "<leader>rt", "Explicit type" },
                    },
                },
            },
            quickfix_filters = { -- example:
                ["rust_analyzer"] = {
                    ["E0433"] = "Import",
                    ["E0369"] = "Restrict bounds",
                },
                -- ["lua_ls"] = {
                --   ["unused-local"] = "Disable diagnostics on this line",
                -- },
            },
        },
    },

    {
        "dnlhc/glance.nvim",
        config = true,
        lazy = true,
        cmd = "Glance",
        event = "LspAttach",
        init = function()
            -- TODO: This vs Telescope vs Quickfix + bqf
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function()
                    -- Consider using the regular mappings
                    vim.keymap.set("n", "gD", "<CMD>Glance definitions<CR>")
                    vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
                    vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>")
                    vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>")
                end,
            })
        end,
    },

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        -- event = "LspAttach",
        config = true,
    },

    {
        -- TODO: Consider this in relation to lsp_lines, quickfix and trouble
        -- however by itself I think it is pretty neat.
        -- Might want to disable lsp_lines in cases where it is annoying?
        -- Or might just add an option so this is on if it is off,
        -- since it just displays the same thing.
        -- BUT, lsp_lines does mess with virtual lines, and that can be jarring,
        -- so maybe something between insert mode and normal mode?
        "dgagn/diagflow.nvim",
        event = "BufEnter",
        enabled = true,
        opts = {
            enable = vim.g.diagflow,
            scope = "line",
            padding_right = 3,
        },
    },

    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        config = function()
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    local highlights = {
                        error = "DiagnosticError",
                        warn = "DiagnosticWarn",
                        info = "DiagnosticInfo",
                        hint = "DiagnosticHint",
                        arrow = "NonText",
                        background = "CursorLine",
                        mixing_color = "None",
                    }
                    local blend = { factor = 0.27 }
                    require("tiny-inline-diagnostic").change(blend, highlights)
                end,
            })

            require("tiny-inline-diagnostic").setup()
        end,
    },

    {
        "folke/trouble.nvim",
        enabled = true,
        lazy = true,
        opts = {
            use_diagnostic_signs = true,
        },
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble<cr>", desc = "toggle trouble" },
            { "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", desc = "workspace diagnostics" },
            { "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", desc = "document diagnostics" },
            { "<leader>xl", "<cmd>Trouble loclist<cr>", desc = "location list" },
            { "<leader>xq", "<cmd>Trouble quickfix<cr>", desc = "quickfix" },
            { "<leader>xc", "<cmd>TroubleClose<cr>", desc = "close" },
            {
                "]x",
                function()
                    require("trouble").next { skip_groups = true, jump = true }
                end,
                desc = "next trouble",
            },
            {
                "[x",
                function()
                    require("trouble").previous { skip_groups = true, jump = true }
                end,
                desc = "prev trouble",
            },
        },
    },

    {
        "stevearc/conform.nvim",
        event = "BufEnter",
        opts = {
            formatters_by_ft = {
                -- lua is better handled by the lsp
                python = { "isort", "black" },
                javascript = { { "prettierd", "prettier" } },
                rust = { "rustfmt" },
                bash = { "shellcheck" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
        init = function()
            -- this will fallback to the lsp if there is no specific formatter
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
        config = function(_, opts)
            require("conform").setup(opts)
            require("conform").formatters.rustfmt = {
                prepend_args = { "--edition", "2021" }, -- Otherwise we can't use new syntax.
            }
        end,
    },

    {
        "zapling/mason-conform.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "stevearc/conform.nvim",
        },
    },

    {
        "mfussenegger/nvim-lint",
        name = "lint",
        lazy = true,
        event = "BufWritePost",
        config = function()
            require("lint").linters_by_ft = {
                -- python = { "ruff" },
                bash = { "shellcheck" },
                c = { "compiler" },
                yaml = { "actionlint" },
                lua = { "luacheck" },
                typescript = { "eslint_d" },
                javascript = { "eslint_d" },
            }
        end,
        init = function()
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end, -- TODO: Setup call to notify/noice
    },

    {
        "rshkarin/mason-nvim-lint",
        event = "BufWritePost",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-lint",
        },
    },

    {
        "onsails/lspkind-nvim",
        config = function()
            require("lspkind").init {
                preset = "codicons",
            }
        end,
    },

    {
        "Bekaboo/dropbar.nvim",
        lazy = false, -- lazy-loading is done by the plugin itself
        enabled = vim.fn.has("nvim-0.10") == 1,
        opts = {
            icons = {
                kinds = {
                    symbols = {
                        -- Folder icons are implicit
                        Folder = "",
                    },
                },
                ui = {
                    menu = { separator = " " },
                    bar = { separator = "  " },
                },
            },
        },
        config = function(_, opts)
            require("dropbar").setup(opts)

            -- setup so it looks like `https://github.com/utilyre/barbecue.nvim`
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("set_dropbar_colors", { clear = true }),
                callback = function()
                    local hl = vim.api.nvim_get_hl(0, { name = "Conceal", link = false })
                    local foreground = string.format("#%06x", hl["fg"] or 0)
                    vim.api.nvim_set_hl(0, "DropBarIconUISeparator", { foreground = foreground })
                    vim.api.nvim_set_hl(0, "DropBarKindFolder", { foreground = foreground })
                end,
            })
        end,
        keys = {
            {
                "<leader>p",
                function()
                    require("dropbar.api").pick()
                end,
                desc = "Dropbar pick",
            },
            {
                "<leader>P",
                function()
                    require("dropbar.api").select_next_context()
                end,
                desc = "Dropbar pick neighbour",
            },
        },
    },

    {
        "linux-cultist/venv-selector.nvim",
        branch = "regexp", -- This is the regexp branch, use this for the new version
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
        opts = {
            -- Your options go here
            -- name = "venv",
            -- auto_refresh = false
        },
        event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        cmd = {
            "VenvSelect",
            "VenvSelectCached",
        },
    },

    -- }}}
}
