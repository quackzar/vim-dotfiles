return {
    -- Generic Editor Plugins {{{
    "tpope/vim-repeat",
    "tpope/vim-eunuch", -- Basic (Delete, Move, Rename unix commands

    {
        "linty-org/readline.nvim",
        config = function()
            local readline = require("readline")
            vim.keymap.set("!", "<M-f>", readline.forward_word)
            vim.keymap.set("!", "<M-b>", readline.backward_word)
            vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
            vim.keymap.set("!", "<C-e>", readline.end_of_line)
            vim.keymap.set("!", "<M-d>", readline.kill_word)
            vim.keymap.set("!", "<C-w>", readline.backward_kill_word)
            vim.keymap.set("!", "<C-k>", readline.kill_line)
            vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
        end,
    },

    "aca/vidir.nvim",

    {
        "numToStr/Comment.nvim",
        opts = {
            ignore = "^$",
        },
    },

    {
        "monaqa/dial.nvim",
        keys = {
            { "<C-a>", "<Plug>(dial-increment)", desc = "Dial up", mode = { "n", "v" } },
            { "<C-x>", "<Plug>(dial-decrement)", desc = "Dial down", mode = { "n", "v" } },
            { "g<C-a>", "g<Plug>(dial-increment)", desc = "Dial up relative", mode = "v" },
            { "g<C-x>", "g<Plug>(dial-decrement)", desc = "Dial down relative", mode = "v" },
        },
    },

    {
        "kylechui/nvim-surround",
        config = true,
    },

    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_surround_enabled = 1
            vim.g.matchup_transmute_enabled = 1
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_override_vimtex = 1
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { silent = true })
            vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { silent = true })
            vim.keymap.set("v", "ga", "<Plug>(EasyAlign)", { silent = true })
        end,
    },

    "Konfekt/vim-sentence-chopper",
    "flwyd/vim-conjoin",

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.g.indent_blankline_char = "▏"
            vim.g.indent_blankline_filetype_exclude = { "help", "packer", "undotree", "text", "dashboard", "man" }
            vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
            vim.g.indent_blankline_show_trailing_blankline_indent = true
            vim.g.indent_blankline_show_first_indent_level = false
            require("indent_blankline").setup {
                -- for example, context is off by default, use this to turn it on
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end,
    },

    "reedes/vim-litecorrect", -- autocorrection! Fixes stupid common mistakes

    {
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
        "folke/todo-comments.nvim",
        event = "BufRead",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },

    { "gpanders/editorconfig.nvim" },

    -- }}}
}
