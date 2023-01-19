return {
    -- Running, Testing and Debugging {{{
    {
        "stevearc/overseer.nvim",
        config = function()
            require("overseer").setup {
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
            }
            vim.keymap.set("n", "<leader>c", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer" })
            vim.keymap.set("n", "<leader>C", "<cmd>OverseerRun<cr>", { desc = "Run a task" })
            vim.keymap.set("n", "<leader>A", "<cmd>OverseerQuickAction<cr>", { desc = "Overseer Action" })
        end,
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
        config = function()
            require("cfg.neotest")
        end,
    },

    -- { "Olical/conjure", event = "VimEnter" },

    "mfussenegger/nvim-dap",
    { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },

    -- {'t-troebst/perfanno.nvim', config = function()
    --	   require('cfg.perfanno')
    -- end
    -- },
    --
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup {
                shell = "fish",
            }
            vim.keymap.set(
                { "n", "i", "v", "t", "t" },
                "<C-\\>",
                "<cmd>ToggleTerm<cr>",
                { silent = true, desc = "Toggle Terminal" }
            )
        end,
    },

    {
        "p00f/godbolt.nvim",
        config = function()
            require("godbolt").setup {
                quickfix = {
                    enable = true, -- whether to populate the quickfix list in case of errors
                    auto_open = true, -- whether to open the quickfix list in case of errors
                },
            }
        end,
    },

    -- }}}
}
