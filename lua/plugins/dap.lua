return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "Keyword", linehl = "", numhl = "" })
            vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "Keyword", linehl = "", numhl = "" })
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = " ", texthl = "Identifier", linehl = "", numhl = "" }
            )
            vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "Keyword", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = " ", texthl = "Function", linehl = "", numhl = "" })
            local dap = require("dap")
            dap.adapters.netcoredb = {}

            require("mason-nvim-dap").setup {
                automatic_setup = true,
            }
            require("mason-nvim-dap").setup_handlers {
                function(source)
                    require("mason-nvim-dap.automatic_setup")(source)
                end,
            }
        end,
    },

    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = true,
        opts = {
            highlight_changed_variables = true,
            show_stop_reason = true, -- show stop reason when stopped for exceptions
            virt_text_pos = "eol", -- position of virtual text, see :h nvim_buf_set_extmark()
        },
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = true,
        keys = {
            "<leader>du",
            "<cmd>lua require('dapui').toggle<cr>",
            desc = "Toggle DAP UI",
        },
    },

    {
        "mfussenegger/nvim-dap-python",
        ft = { "python" },
        dependencies = { "mfussenegger/nvim-dap" },
    },
}
