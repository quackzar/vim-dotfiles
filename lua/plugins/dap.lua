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
            require("mason-nvim-dap").setup {
                automatic_setup = true,
                handlers = {
                    function(source)
                        require("mason-nvim-dap").default_setup(source)
                    end,
                    codelldb = function(config)
                        config.configurations[1].args = function()
                            return vim.fn.split(vim.fn.input("Args: "), " ")
                        end
                        require("mason-nvim-dap").default_setup(config) -- don't forget this!
                    end,
                },
            }
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
            virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
        },
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = true,
        lazy = true, -- Triggered by Hydra
    },

    { "nvim-telescope/telescope-dap.nvim" },

    {
        "LiadOz/nvim-dap-repl-highlights",
        config = true,
        lazy = true,
    },
}
