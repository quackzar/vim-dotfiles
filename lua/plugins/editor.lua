return {
    -- Generic Editor Plugins {{{
    "tpope/vim-repeat",
    "tpope/vim-eunuch", -- Basic (Delete, Move, Rename unix commands

    { "johmsalas/text-case.nvim", config = true },

    "aca/vidir.nvim",

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            ignore = "^$",
        },
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
        opts = {
            mappings = {
                start = "ga",
                start_with_preview = "gA",
            },
        },
    },

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
        config = function()
            require("block").setup {}
        end,
    },

    {
        "atusy/tsnode-marker.nvim",
        -- Does the same thing as headlines.nvim
        enabled = false,
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
        end,
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
        "folke/todo-comments.nvim",
        event = "BufRead",
        opts = { signs = false },
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },

    -- }}}
}
