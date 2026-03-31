return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "GitSignsChange", linehl = "", numhl = "" })
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = " ", texthl = "GitSignsChange", linehl = "", numhl = "" }
            )
            vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "GitSignsChange", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = " ", texthl = "GitSignsAdd", linehl = "", numhl = "" })
            vim.fn.sign_define(
                "DapBreakpointRejected",
                { text = " ", texthl = "GitSignsDelete", linehl = "", numhl = "" }
            )
            require("nvim-dap-repl-highlights").setup()
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = true,
        opts = {
            highlight_changed_variables = true,
            show_stop_reason = true, -- show stop reason when stopped for exceptions
        },
    },

    -- {
    --     "rcarriga/nvim-dap-ui",
    --     dependencies = { "mfussenegger/nvim-dap" },
    --     config = true,
    --     lazy = true, -- Triggered by Hydra
    -- },

    {
        "igorlfs/nvim-dap-view",
        -- let the plugin lazy load itself
        lazy = false,
        version = "1.*",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
            winbar = {
                controls = {
                    enabled = true,
                },
                sections = {
                    "watches",
                    "scopes",
                    "exceptions",
                    "breakpoints",
                    "threads",
                    "repl",
                    "disassembly",
                },
            },
        },
    },

    {
        url = "https://codeberg.org/Jorenar/nvim-dap-disasm.git",
        dependencies = "igorlfs/nvim-dap-view",
        opts = {
            dapview_register = true,
        },
    },

    {
        "nvim-telescope/telescope-dap.nvim",
    },

    {
        "LiadOz/nvim-dap-repl-highlights",
        config = true,
        lazy = true,
    },
}
