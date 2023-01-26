return {
    {
        "stevearc/overseer.nvim",
        opts = {
            strategy = {
                "toggleterm",
            },
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

    -- {'t-troebst/perfanno.nvim', config = function()
    --	   require('cfg.perfanno')
    -- end
    -- },
    --
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
}
