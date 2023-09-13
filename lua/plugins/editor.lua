return {
    -- Generic Editor Plugins {{{
    "tpope/vim-repeat",
    "tpope/vim-eunuch", -- Basic (Delete, Move, Rename unix commands

    { "johmsalas/text-case.nvim", config = true },

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
        event = "VeryLazy",
        opts = {
            ignore = "^$",
        },
    },

    "LudoPinelli/comment-box.nvim", -- Maybe hydra? Also the venn diagram one

    {
        "monaqa/dial.nvim",
        config = function()
            -- Using lazy to set them apparantly doesn't work
            vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true, desc = "Dial up" })
            vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true, desc = "Diap down" })
            vim.keymap.set("n", "g<C-a>", require("dial.map").inc_gnormal(), { noremap = true }) -- TODO: add desc. to rest
            vim.keymap.set("n", "g<C-x>", require("dial.map").dec_gnormal(), { noremap = true })
            vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
            vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
            vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
            vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
        end,
        keys = { "<C-a>", { "<C-x>", mode = "n" } },
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = true,
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
        "echasnovski/mini.align",
        opts = {
            mappings = {
                start = "ga",
                start_with_preview = "gA",
            },
        },
    },

    "Konfekt/vim-sentence-chopper",

    {
        "chrisgrieser/nvim-various-textobjs",
        -- maybe consider https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
        config = function()
            require("various-textobjs").setup { useDefaultKeymaps = true }
            vim.keymap.del("x", "r")
            vim.keymap.del("x", "R")
        end,
    },

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = true,
        lazy = true,
    },

    {
        "tzachar/highlight-undo.nvim",
        config = true,
        keys = {
            { "u" },
            { "<C-r>" },
        },
    },

    {
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
        opts = {
            exclude_filtypes = {
                "typst",
                "help",
                "packer",
                "undotree",
                "text",
                "dashboard",
                "man",
            },
            chunk = {
                chars = {
                    horizontal_line = "─",
                    left_top = "╭",
                    vertical_line = "│",
                    left_bottom = "╰",
                    right_arrow = "─",
                },
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
        "HampusHauffman/block.nvim",
        config = function()
            require("block").setup {}
        end,
    },

    {
        "atusy/tsnode-marker.nvim",
        lazy = true,
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
                pattern = "markdown",
                callback = function(ctx)
                    require("tsnode-marker").set_automark(ctx.buf, {
                        target = { "code_fence_content" }, -- list of target node types
                        hl_group = "CursorLine", -- highlight group
                    })
                end,
            })
            -- Cool idea. Might need some tweaking.
            -- vim.api.nvim_create_autocmd("FileType", {
            --     group = vim.api.nvim_create_augroup("tsnode-marker-rust", {}),
            --     pattern = "rust",
            --     callback = function(ctx)
            --         require("tsnode-marker").set_automark(ctx.buf, {
            --             target = { "unsafe_block" }, -- list of target node types
            --             hl_group = "DiffDelete", -- highlight group
            --         })
            --     end,
            -- })
        end,
    },

    -- {
    --     'huy-hng/anyline.nvim',
    --     dependencies = { 'nvim-treesitter/nvim-treesitter' },
    --     config = {
    --         ft_ignore = {"help", "alpha", "neo-tree", "OverseerList", "text", "aerial"}
    --     },
    --     event = 'VeryLazy',
    -- },

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

    -- {
    --     "ecthelionvi/NeoComposer.nvim",
    --     dependencies = { "kkharji/sqlite.lua" },
    --     opts = { notify = false },
    -- },

    -- }}}
}
