return {
    {
        "stevearc/overseer.nvim",
        opts = {
            -- strategy = {
            --     "toggleterm",
            -- },
            task_list = {
                direction = "right",
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
            require("cfg.neotest")
        end,
    },

    -- { "Olical/conjure", event = "VimEnter" },

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            shell = "fish",
            start_in_insert = false,
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
    },

    {
        "p00f/godbolt.nvim",
        opts = {
            quickfix = {
                enable = true, -- whether to populate the quickfix list in case of errors
                auto_open = true, -- whether to open the quickfix list in case of errors
            },
        },
    },

    {
        "andythigpen/nvim-coverage",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = true,
    },

    {
        "t-troebst/perfanno.nvim",
        lazy = true,
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
