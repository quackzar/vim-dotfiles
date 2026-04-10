return {

    { -- TODO: Setup mappings
        "rcarriga/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",

            -- Seperate test suites (should maybe be hot-loaded?)
            -- "rouge8/neotest-rust",
            "nvim-neotest/neotest-python",
            "haydenmeade/neotest-jest",
            "Issafalcon/neotest-dotnet",
        },
        lazy = true,
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("neotest").setup {
                icons = {
                    passed = " ",
                    running = " ",
                    failed = " ",
                    skipped = " ",
                    unknown = " ",
                    non_collapsible = "─",
                    collapsed = "",
                    expanded = "",
                    child_prefix = "├",
                    child_indent = "│",
                    final_child_prefix = "└",
                    final_child_indent = " ",
                    running_animated = {
                        "⠋",
                        "⠙",
                        "⠚",
                        "⠒",
                        "⠂",
                        "⠂",
                        "⠒",
                        "⠲",
                        "⠴",
                        "⠦",
                        "⠖",
                        "⠒",
                        "⠐",
                        "⠐",
                        "⠒",
                        "⠓",
                        "⠋",
                    },
                },
                ---@diagnostic disable-next-line: missing-fields
                summary = {
                    open = "topleft vsplit | vertical resize 30",
                },
                log_level = 0,
                status = {
                    enabled = true,
                    virtual_text = true,
                    signs = false,
                },
                consumers = {
                    overseer = require("neotest.consumers.overseer"),
                    -- neotree = require("neotest.consumers.neo-tree"),
                },
                adapters = {
                    -- require("neotest-rust"),
                    require("rustaceanvim.neotest"),
                    require("neotest-python") {
                        dap = { justMyCode = false },
                    },
                    require("neotest-jest") {
                        jestCommand = "npm test --",
                        jestConfigFile = "custom.jest.config.ts",
                    },
                    require("neotest-dotnet"),
                },
            }

            local highlighting = {
                NeotestPassed = { link = "GitSignsAdd" },
                NeotestRunning = { link = "GitSignsChange" },
                NeotestFailed = { link = "GitSignsDelete" },
                NeotestSkipped = { link = "DiagnosticWarn" },
                NeotestUnknown = { link = "DiagnosticInfo" },
            }

            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("set_neotest_colors", { clear = true }),
                callback = function()
                    for key, link in pairs(highlighting) do
                        vim.api.nvim_set_hl(0, key, link)
                    end
                end,
            })
            for key, link in pairs(highlighting) do
                vim.api.nvim_set_hl(0, key, link)
            end
        end,
        keys = {
            {
                "]t",
                function()
                    require("neotest").jump.next()
                end,
                desc = "next test",
            },
            {
                "[t",
                function()
                    require("neotest").jump.prev()
                end,
                desc = "prev test",
            },
            {
                "]T",
                function()
                    require("neotest").jump.next { status = "failed" }
                end,
                desc = "next failed test",
            },
            {
                "[T",
                function()
                    require("neotest").jump.prev { status = "failed" }
                end,
                desc = "prev failed test",
            },
            {
                "<leader>T",
                function()
                    require("neotest").summary.toggle()
                end,
                desc = "test summary",
            },
        },
    },

    {
        "andythigpen/nvim-coverage",
        -- See: https://github.com/mozilla/grcov#usage
        -- TODO: Hydra
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
        cmd = {
            "Coverage",
            "CoverageLoad",
            "CoverageLoadLcov",
        },
    },

    {
        "t-troebst/perfanno.nvim",
        lazy = true,
        -- TODO: Make it work on macOS (find something to output like perf does)
        -- TODO: Hydra
        config = function()
            local perfanno = require("perfanno")
            local util = require("perfanno.util")
            local bgcolor = vim.fn.synIDattr(vim.fn.hlID("Normal"), "bg", "gui")
            perfanno.setup {
                -- Creates a 10-step RGB color gradient beween bgcolor and "#CC3300"
                line_highlights = util.make_bg_highlights("#000000", "#CC3300", 10),
                vt_highlight = util.make_fg_highlight("#CC3300"),
            }
        end,
    },
}
