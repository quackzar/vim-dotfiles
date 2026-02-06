return {

    -- LSP + Snippets {{{
    {
        "williamboman/mason.nvim",
        "jayp0521/mason-nvim-dap.nvim",
        "neovim/nvim-lspconfig",
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            automatic_enable = {
                exclude = {
                    "rust_analyzer",
                    "harper_ls",
                    "ltex_plus",
                },
            },
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },

    {
        "rachartier/tiny-code-action.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
        event = "LspAttach",
        opts = {
            backend = "delta",
            backend_opts = {
                args = {
                    "--syntax-theme=kanagawa",
                    "--line-numbers",
                },
            },
        },
        init = function()
            vim.keymap.set("n", "<leader>a", function()
                require("tiny-code-action").code_action()
            end, { noremap = true, silent = true })
        end,
    },

    {
        "dnlhc/glance.nvim",
        config = true,
        lazy = true,
        cmd = "Glance",
        event = "LspAttach",
        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function()
                    vim.keymap.set("n", "gRD", "<CMD>Glance definitions<CR>", { desc = "glance definitions" })
                    vim.keymap.set("n", "gRR", "<CMD>Glance references<CR>", { desc = "glance references" })
                    vim.keymap.set("n", "gRT", "<CMD>Glance type_definitions<CR>", { desc = "glance type" })
                    vim.keymap.set("n", "gRI", "<CMD>Glance implementations<CR>", { desc = "glance implementations" })
                end,
            })
        end,
    },

    {
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

            require("tiny-inline-diagnostic").setup {
                options = {
                    show_source = {
                        if_many = true,
                    },
                    softwrap = 40,
                    -- break_line = {
                    --     enabled = true,
                    --     after = 90,
                    -- },
                    multiline = {
                        enabled = true,
                    },
                },
            }
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
        "Wansmer/symbol-usage.nvim",
        -- Alternative to consider?
        -- https://github.com/oribarilan/lensline.nvim
        event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
        config = function()
            local function setup_colors()
                local function h(name)
                    return vim.api.nvim_get_hl(0, { name = name })
                end
                vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
                vim.api.nvim_set_hl(
                    0,
                    "SymbolUsageContent",
                    { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true }
                )
                vim.api.nvim_set_hl(
                    0,
                    "SymbolUsageRef",
                    { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true }
                )
                vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
                vim.api.nvim_set_hl(
                    0,
                    "SymbolUsageImpl",
                    { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true }
                )
            end
            vim.api.nvim_create_autocmd({ "ColorScheme", "UIEnter" }, {
                group = vim.api.nvim_create_augroup("set_symbol_usage_colors", { clear = true }),
                callback = setup_colors,
            })
            setup_colors()

            local function text_format(symbol)
                local res = {}

                local round_start = { "", "SymbolUsageRounding" }
                local round_end = { "", "SymbolUsageRounding" }

                -- Indicator that shows if there are any other symbols in the same line
                local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count)
                    or ""

                if symbol.references then
                    local usage = symbol.references <= 1 and "usage" or "usages"
                    local num = symbol.references == 0 and "no" or symbol.references
                    table.insert(res, round_start)
                    table.insert(res, { "󰌹 ", "SymbolUsageRef" })
                    table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
                    table.insert(res, round_end)
                end

                if symbol.definition then
                    if #res > 0 then
                        table.insert(res, { " ", "NonText" })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { "󰳽 ", "SymbolUsageDef" })
                    table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
                    table.insert(res, round_end)
                end

                if symbol.implementation then
                    if #res > 0 then
                        table.insert(res, { " ", "NonText" })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
                    table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
                    table.insert(res, round_end)
                end

                if stacked_functions_content ~= "" then
                    if #res > 0 then
                        table.insert(res, { " ", "NonText" })
                    end
                    table.insert(res, round_start)
                    table.insert(res, { " ", "SymbolUsageImpl" })
                    table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
                    table.insert(res, round_end)
                end

                return res
            end

            require("symbol-usage").setup {
                vt_position = "end_of_line",
                text_format = text_format,
            }
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                -- lua is better handled by the lsp
                python = { "isort", "black" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                rust = { "rustfmt", lsp_format = "fallback" },
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
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim",
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },

    {
        "linux-cultist/venv-selector.nvim",
        branch = "main",
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
