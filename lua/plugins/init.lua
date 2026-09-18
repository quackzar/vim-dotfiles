return {
    {
        "vladdoster/remember.nvim",
        lazy = false,
        config = true,
    },

    {
        "folke/persistence.nvim",
        enabled = true,
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = true,
    },

    {
        "miversen33/netman.nvim",
        lazy = false,
    },

    { -- autoclose unused buffers
        "axkirillov/hbac.nvim",
        config = true,
        event = "VeryLazy",
        opts = {
            autoclose = true,
            threshold = 10,
        },
    },

    {
        "HakonHarnes/img-clip.nvim",
        cmd = "PasteImage",
        opts = {
            -- add options here
            -- or leave it empty to use the default settings
        },
        keys = {
            -- suggested keymap
            { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
        },
    },

    {
        "sustech-data/wildfire.nvim",
        keys = { "<CR>" },
        opts = {
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<S-CR>",
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = true,
    },

    {
        "nacro90/numb.nvim",
        keys = { ":" },
        config = true,
    },

    {
        "chrishrb/gx.nvim",
        event = { "BufEnter" },
        config = true, -- default settings
    },

    {
        "gbprod/stay-in-place.nvim",
        --  is a Neovim plugin that prevent the cursor from moving when using shift and filter actions.
        config = true,
    },
}
-- vim: foldmethod=marker
