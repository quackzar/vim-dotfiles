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
    -- "ray-x/lsp_signature.nvim",

    {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        config = function()
            require("toggle_lsp_diagnostics").init()
        end,
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
        opts = {
            enable = false,
            scope = "line",
        },
    },

    "jose-elias-alvarez/null-ls.nvim",

    {
        "stevearc/aerial.nvim",
        enabled = false,
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
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        event = "BufEnter",
        enabled = false, --vim.fn.has("nvim-0.10") == 0,
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
            -- configurations go here
        },
    },

    {
        "Bekaboo/dropbar.nvim",
        -- BUG: Currently breaks exiting from Telescope, thus entering insert mode.
        -- which is not ideal.
        enabled = true, -- vim.fn.has("nvim-0.10") == 1,
        opts = {
            update_events = {
                win = {
                    -- 'CursorMoved',
                    -- 'CursorMovedI',
                    -- 'WinEnter',
                    -- 'WinResized',
                    -- 'WinScrolled',
                },
                buf = {
                    -- 'BufModifiedSet',
                    -- 'FileChangedShellPost',
                    -- 'TextChanged',
                    -- 'TextChangedI',
                },
                global = {
                    -- 'DirChanged',
                    -- 'VimResized',
                },
            },
            icons = {
                kinds = {
                    symbols = {
                        -- Folders are too much noise
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
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("set_hydra_colors", { clear = true }),
                callback = function()
                    local hl = vim.api.nvim_get_hl_by_name("Comment", true)
                    local foreground = string.format("#%06x", hl["foreground"] or 0)
                    vim.api.nvim_set_hl(0, "DropBarKindFolder", { foreground = foreground })
                end,
            })
        end,
        lazy = false,
        keys = {
            {
                "<leader>p",
                function()
                    require("dropbar.api").pick()
                end,
                desc = "Dropbar pick",
            },
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
        "lvimuser/lsp-inlayhints.nvim",
        branch = "anticonceal",
        enabled = false, -- vim.fn.has("nvim-0.10") == 1,
        lazy = false,
        opts = {
            debug_mode = false,
        },
        init = function()
            vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = "LspAttach_inlayhints",
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    require("lsp-inlayhints").on_attach(client, bufnr)
                end,
            })
        end,
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
