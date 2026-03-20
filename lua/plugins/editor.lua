return {
    -- Generic Editor Plugins {{{
    "tpope/vim-repeat",

    { "nvim-mini/mini.bracketed", version = "*" },

    "aca/vidir.nvim",

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
    },

    {
        "nvim-mini/mini.surround",
        version = "*",
        opts = {},
        init = function()
            vim.keymap.set({ "n", "x" }, "s", "<nop>")
        end,
    },

    {
        "andymass/vim-matchup",
        event = "BufReadPre",
        config = function()
            vim.g.matchup_surround_enabled = 1
            vim.g.matchup_transmute_enabled = 1
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_override_vimtex = 1
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    {
        "saghen/blink.pairs",
        version = "*",
        dependencies = "saghen/blink.download",
        opts = {
            mappings = {
                enabled = true,
                cmdline = true,
            },
            highlights = { -- TODO: Consider rainbows
                enabled = false,
            },
        },
    },

    {
        "nvim-mini/mini.jump2d",
        opts = {
            mappings = {
                start_jumping = "S",
            },
        },
        version = false,
    },

    {
        "nvim-mini/mini.align",
        event = "BufEnter",
        opts = {
            mappings = {
                start = "ga",
                start_with_preview = "gA",
            },
        },
    },

    { "nvim-mini/mini.ai", version = false },

    {
        "shellRaining/hlchunk.nvim",
        enabled = true,
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            exclude_filetypes = {
                alpha = true,
                tex = true,
                vimdoc = true,
                help = true,
                packer = true,
                undotree = true,
                text = true,
                dashboard = true,
                man = true,
            },
            chunk = {
                enable = true,
                style = {
                    { fg = "#88aaaa" },
                    { fg = "#c21f30" },
                },
                duration = 150,
                chars = {
                    horizontal_line = "─",
                    left_top = "╭",
                    vertical_line = "│",
                    left_bottom = "╰",
                    right_arrow = "─",
                },
                textobject = "ix",
            },
            indent = {
                enable = true,
                chars = {
                    " ",
                    -- "▏",
                    "│",
                    "│",
                    "│",
                    "│",
                    "│",
                    "│",
                },
            },
            line_num = {
                enable = false,
            },
            blank = {
                enable = false,
            },
        },
    },

    {
        -- quickfix improvements
        "kevinhwang91/nvim-bqf",
        opts = {
            auto_enable = true,
            auto_resize_height = true,
            func_map = {
                fzffilter = "",
            },
        },
    },

    {
        -- quickfix improvements
        "stevearc/quicker.nvim",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        opts = { signs = false },
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },

    {
        "teamtype/teamtype-nvim",
        keys = { { "<leader>j", "<cmd>EthersyncJumpToCursor<cr>" } },
        lazy = false,
    },

    -- }}}
}
