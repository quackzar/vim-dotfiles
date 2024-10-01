return {
    -- Generic Editor Plugins {{{
    "tpope/vim-repeat",
    "tpope/vim-eunuch", -- Basic (Delete, Move, Rename unix commands

    { "echasnovski/mini.bracketed", version = "*" },

    "aca/vidir.nvim",

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
    },

    {
        "kylechui/nvim-surround",
        -- consider `echasnovski/mini.surround` for sandwich-like bindings
        -- Sandwich like bidnings conflict with `substitute`
        version = "*",
        event = "VeryLazy",
        config = function()
            local surr_utils = require("nvim-surround.config")
            require("nvim-surround").setup {
                surrounds = {
                    ["g"] = {
                        add = function()
                            local result = surr_utils.get_input("Enter the type name: ")
                            if result then
                                return { { result .. "<" }, { ">" } }
                            end
                        end,
                        find = "[%w]+%b<>",
                        delete = "^([%w]+<().-(%>)<>$",
                        change = {
                            target = "^([%w]+)().-()<>$",
                            replacement = function()
                                local result = surr_utils.get_input("Enter the type name: ")
                                if result then
                                    return { { result }, { "" } }
                                end
                            end,
                        },
                    },
                },
            }
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
        "echasnovski/mini.align",
        event = "BufEnter",
        opts = {
            mappings = {
                start = "ga",
                start_with_preview = "gA",
            },
        },
    },

    { "echasnovski/mini.ai", version = false },

    {
        "gbprod/substitute.nvim", -- sort of a 'paste, but backwards'
        lazy = true,
        opts = {},
        init = function()
            vim.keymap.set("n", "s", require("substitute").operator, { noremap = true })
            vim.keymap.set("n", "ss", require("substitute").line, { noremap = true })
            vim.keymap.set("n", "S", require("substitute").eol, { noremap = true })
            vim.keymap.set("x", "s", require("substitute").visual, { noremap = true })
        end,
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

    -- }}}
}
