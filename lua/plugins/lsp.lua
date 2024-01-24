return {

    -- LSP + Snippets {{{
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-nvim-dap.nvim",
        "neovim/nvim-lspconfig",
    },

    -- {
    --     "hinell/lsp-timeout.nvim",
    --     dependencies = { "neovim/nvim-lspconfig" },
    -- },

    {
        "luckasRanarison/clear-action.nvim",
        opts = {
            signs = {
                icons = {
                    quickfix = "  ",
                    refactor = "  ",
                    source = "  ",
                    combined = "  ", -- used when combine is set to true
                },
            },
            mappings = {
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
        config = true,
    },

    {
        "folke/trouble.nvim",
        lazy = true,
        opts = {
            use_diagnostic_signs = true,
        },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "toggle trouble" },
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
        -- TODO: Consider this in relation to lsp_lines, quickfix and trouble
        -- however by itself I think it is pretty neat.
        -- Might want to disable lsp_lines in cases where it is annoying?
        -- Or might just add an option so this is on if it is off,
        -- since it just displays the same thing.
        -- BUT, lsp_lines does mess with virtual lines, and that can be jarring,
        -- so maybe something between insert mode and normal mode?
        "dgagn/diagflow.nvim",
        event = "BufEnter",
        opts = {
            enable = false,
            scope = "line",
            padding_right = 3,
        },
    },

    -- {
    --     "Wansmer/symbol-usage.nvim",
    --     event = "LspAttach",
    --     opts = {
    --         kinds = {
    --             SymbolKind.Function,
    --             SymbolKind.Method,
    --             SymbolKind.Interface,
    --         },
    --         vt_position = "end_of_line",
    --         hl = { link = "NonText" },
    --         references = { enabled = true, include_declaration = false },
    --         -- implementation = { enabled = true },
    --         -- definition = { enabled = true },
    --     },
    --     config = true,
    -- },

    {
        "chrisgrieser/nvim-rulebook",
        keys = {
            {
                "<leader>I",
                function()
                    require("rulebook").ignoreRule()
                end,
                desc = "ignore rule",
            },
            {
                "<leader>L",
                function()
                    require("rulebook").lookupRule()
                end,
                desc = "lookup rule",
            },
        },
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                -- lua is better handled by the lsp
                python = { "isort", "black" },
                javascript = { { "prettierd", "prettier" } },
                rust = { "rustfmt" },
                bash = { "shellcheck" },
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
        "mfussenegger/nvim-lint",
        name = "lint",
        lazy = true,
        event = "BufWritePost",
        config = function()
            require("lint").linters_by_ft = {
                bash = "shellcheck",
            }
        end,
        init = function()
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
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
        "barreiroleo/ltex_extra.nvim",
        enabled = true,
        ft = { "markdown", "tex" },
        dependencies = { "neovim/nvim-lspconfig" },
        -- yes, you can use the opts field, just I'm showing the setup explicitly
        opts = {
            server_opts = {
                settings = {
                    ltex = {
                        checkFrequency = "save",
                        language = "en-US",
                        additionalRules = {
                            enablePickyRules = false,
                        },
                        disabledRules = {
                            ["en-US"] = {
                                "TYPOS",
                                "MORFOLOGIK_RULE_EN",
                                "MORFOLOGIK_RULE_EN_US",
                                "EN_QUOTES",
                                "PASSIVE_VOICE",
                            },
                        },
                    },
                },
            },
        },
    },

    -- }}}
}
