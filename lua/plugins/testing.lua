return {

    { -- TODO: Setup mappings
        "rcarriga/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",

            -- Seperate test suites (should maybe be hot-loaded?)
            "rouge8/neotest-rust",
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
                status = {
                    enabled = true,
                    virtual_text = true,
                    signs = false,
                },
                consumers = {
                    overseer = require("neotest.consumers.overseer"),
                },
                adapters = {
                    require("neotest-rust"),
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
                { desc = "next test" },
            },
            {
                "[t",
                function()
                    require("neotest").jump.prev()
                end,
                { desc = "prev test" },
            },
            {
                "]T",
                function()
                    require("neotest").jump.next { status = "failed" }
                end,
                { desc = "next failed test" },
            },
            {
                "[T",
                function()
                    require("neotest").jump.prev { status = "failed" }
                end,
                { desc = "prev failed test" },
            },
        },
    },

    {
        "stevearc/overseer.nvim",
        opts = {
            -- strategy = {
            --     "toggleterm",
            -- },
            task_list = {
                direction = "right",
                default_detail = 2,
                bindings = {
                    ["a"] = "<cmd>OverseerRun<cr>",
                    ["A"] = "<cmd>OverseerBuild<cr>",
                },
            },
            log = {
                {
                    type = "notify",
                    level = vim.log.levels.INFO,
                },
            },
        },
        keys = {
            { "<leader>c", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
            { "<leader>C", "<cmd>OverseerRun<cr>", desc = "Run a task" },
            { "<leader>A", "<cmd>OverseerQuickAction<cr>", desc = "Overseer Action" },
        },
    },

    -- { "Olical/conjure", event = "VimEnter" },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            shell = "fish",
            start_in_insert = false,
            winbar = { enabled = true },
        },
        keys = {
            { -- This fixes a hydra that switches windows, since it gets consumed halfway
                "<C-\\>",
                "<cmd>ToggleTerm<cr><cmd>startinsert!<cr>",
                desc = "Toggle Terminal",
                mode = { "n", "i", "v" },
            },
            {
                "<C-\\>",
                "<cmd>ToggleTerm<cr>",
                desc = "Toggle Terminal",
                mode = { "t" },
            },
        },
        init = function()
            function _G.set_terminal_keymaps()
                local opts = { buffer = 0 }
                vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
                vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
                vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
                vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
                vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
                vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
            end

            -- if you only want these mappings for toggle term use term://*toggleterm#* instead
            vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
        end,
    },

    {
        "p00f/godbolt.nvim",
        lazy = true,
        cmd = { "Godbolt", "GodboltCompiler" },
        opts = {
            quickfix = {
                enable = true, -- whether to populate the quickfix list in case of errors
                auto_open = true, -- whether to open the quickfix list in case of errors
            },
        },
    },

    {
        "andythigpen/nvim-coverage",
        -- See: https://github.com/mozilla/grcov#usage
        -- TODO: Hydra
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
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
