return {

    -- LSP + Snippets {{{
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-nvim-dap.nvim",
        "jayp0521/mason-null-ls.nvim",
        "neovim/nvim-lspconfig",
    },

    "weilbith/nvim-code-action-menu",

    {
        "aznhe21/actions-preview.nvim",
        opts = {
            diff = {
                algorithm = "patience",
                ignore_whitespace = true,
            },
        },
    },

    {
        "kosayoda/nvim-lightbulb",
        opts = {
            autocmd = { enabled = true },
            priority = 10,
            -- NOTE: Could be nice if we had two types
            -- One noisy for quickfix and a more discrete version for everything else
            action_kinds = { "quickfix" },
            sign = {
                -- TODO: Does not work :(
                enabled = true,
                text = "",
                hl = "DiagnosticOk",
            },
            virtual_text = {
                enabled = true,
                text = "  ",
                hl = "DiagnosticOk",
                pos = "eol",
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
        opts = {
            use_diagnostic_signs = true,
        },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "toggle trouble" },
            { "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>" },
            { "<leader>xd", "<cmd>Trouble document_diagnostics<cr>" },
            { "<leader>xl", "<cmd>Trouble loclist<cr>" },
            { "<leader>xq", "<cmd>Trouble quickfix<cr>" },
            { "<leader>xc", "<cmd>TroubleClose<cr>" },
            { "gR", "<cmd>Trouble lsp_references<cr>" },
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
        },
    },

    "jose-elias-alvarez/null-ls.nvim",

    {
        "onsails/lspkind-nvim",
        setup = function()
            require("lspkind").init {
                preset = "codicons",
            }
        end,
    },

    {
        "Bekaboo/dropbar.nvim",
        lazy = false, -- lazy-loading is done by the plugin itself
        enabled = true, -- vim.fn.has("nvim-0.10") == 1,
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
        ft = { "markdown", "tex" },
        dependencies = { "neovim/nvim-lspconfig" },
        -- yes, you can use the opts field, just I'm showing the setup explicitly
        opts = {
            require("ltex_extra").setup {
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
    },

    -- AI stuff
    {
        "Bryley/neoai.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        cmd = {
            "NeoAI",
            "NeoAIOpen",
            "NeoAIClose",
            "NeoAIToggle",
            "NeoAIContext",
            "NeoAIContextOpen",
            "NeoAIContextClose",
            "NeoAIInject",
            "NeoAIInjectCode",
            "NeoAIInjectContext",
            "NeoAIInjectContextCode",
        },
        keys = {
            { "<leader>s", desc = "summarize text" },
            { "<leader>S", desc = "generate git message" },
        },
        config = true,
    },

    -- }}}
}
