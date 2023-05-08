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
    "kosayoda/nvim-lightbulb",

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

    -- { 'Issafalcon/lsp-overloads.nvim'},
    "ray-x/lsp_signature.nvim",

    {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        config = function()
            require("toggle_lsp_diagnostics").init()
        end,
    },

    "jose-elias-alvarez/null-ls.nvim",

    {
        "stevearc/aerial.nvim",
        opts = {
            filter_kind = false, -- TODO: play around with this.
            backends = { "lsp", "treesitter", "markdown", "man" },
            layout = {
                placement = "edge",
            },
            on_attach = function(bufnr)
                vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { buffer = bufnr })
            end,
        },
        keys = {
            { "<leader>v", "<cmd>AerialOpen<CR>", desc = "Aerial Focus" },
            { "<leader>V", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial" },
        },
    },

    {
        "onsails/lspkind-nvim",
        setup = function()
            require("lspkind").init {
                preset = "codicons",
            }
        end,
    },

    {
        "jackMort/ChatGPT.nvim",
        config = true,
        cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun", "ChatGPTRunCustomCodeAction" },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },

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

    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        event = "BufEnter",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },

    {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "neovim/nvim-lspconfig",
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
        },
        event = "BufEnter",
        opts = {
            lsp = {
                auto_attach = true,
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

    -- }}}
}
