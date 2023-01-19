return {
    -- Telescope {{{
    --
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        event = "VimEnter",
        config = function()
            require("cfg.telescope")
        end,
    },

    "willthbill/opener.nvim",

    "romgrk/fzy-lua-native", -- for use with wilder

    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- "nvim-telescope/telescope-z.nvim",

    {
        "stevearc/resession.nvim",
        config = function()
            local resession = require("resession")
            resession.setup {
                autosave = {
                    enabled = true,
                    interval = 60,
                    notify = false,
                },
                tab_buf_filter = function(tabpage, bufnr)
                    local dir = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
                    return vim.startswith(vim.api.nvim_buf_get_name(bufnr), dir)
                end,
            }
            vim.keymap.set("n", "<leader>ss", resession.save_tab, { desc = "Save session" })
            vim.keymap.set("n", "<leader>sl", resession.load, { desc = "Load session" })
            vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Delete session" })
        end,
    },

    {

        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker")
        end,
    },

    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = true,
    },

    -- }}}
}
