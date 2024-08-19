return {
    -- Generic Editor Plugins {{{
    "tpope/vim-repeat",
    "tpope/vim-eunuch", -- Basic (Delete, Move, Rename unix commands

    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup {}
            require("telescope").load_extension("textcase")
        end,
        keys = {
            "ga", -- Default invocation prefix
            { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
        },
    },

    "aca/vidir.nvim",

    { -- NOTE: This is half-redundant in nvim-0.10
        "numToStr/Comment.nvim",
        enabled = vim.fn.has("nvim-0.10") == 0,
        event = "VeryLazy",
        opts = {
            ignore = "^$",
        },
    },

    {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
    },

    {
        "kylechui/nvim-surround",
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
        "tzachar/highlight-undo.nvim",
        config = true,
        keys = {
            { "u" },
            { "<C-r>" },
        },
    },

    {
        "shellRaining/hlchunk.nvim",
        enabled = false,
        event = { "UIEnter" },
        opts = {
            chunk = {
                exclude_filetypes = {
                    typst = true,
                    tex = true,
                    vimdoc = true,
                    help = true,
                    packer = true,
                    undotree = true,
                    text = true,
                    dashboard = true,
                    man = true,
                },
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
        enabled = false,
        config = true,
    },

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
