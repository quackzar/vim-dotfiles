return {
    -- Treesitter {{{

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("cfg.treesitter")
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context", -- Repo moved to nvim-treesitter
        config = function()
            require("treesitter-context").setup {
                enable = true,
                throttle = true,
                mode = "topline",
                multiwindow = true,
            }
            vim.keymap.set("n", "[C", function() -- a bit weird with topline
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true, desc = "goto context" })
        end,
    },

    "RRethy/nvim-treesitter-textsubjects",

    "nvim-treesitter/nvim-treesitter-textobjects",

    {
        "RRethy/nvim-treesitter-endwise",
        event = "InsertEnter",
        config = function()
            require("nvim-treesitter.configs").setup {
                endwise = {
                    enable = true,
                },
            }
        end,
    },

    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {
                disable_filetype = { "TelescopePrompt", "guihua", "guihua_rust", "clap_input" },
                check_ts = true,
                enable_check_bracket_line = true,
                fast_wrap = {},
            }
            local Rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")
            local npairs = require("nvim-autopairs")
            npairs.add_rule(Rule("\\(", "\\)", "tex"))
            npairs.add_rule(Rule("\\[", "\\]", "tex"))
            npairs.add_rule(Rule("\\left", "\\right", "tex"))
            npairs.add_rules {
                Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(opts)
                    return opts.char == ">"
                end),
            }
            -- Sort of works, but screws with single `|`
            --npairs.add_rules({Rule("|", "|", { "rust", "go", "lua" }):with_move(cond.after_regex("|")) })
        end,
    },

    {
        -- Boosted '%'
        -- Maybe redundant with vim-matchup (also uses treesitter)
        "yorickpeterse/nvim-tree-pairs",
        enabled = false,
        config = true,
    },

    {
        "Wansmer/treesj",
        dependencies = { "nvim-treesitter" },
        config = function()
            require("treesj").setup {
                use_default_keymaps = false,
                check_syntax_error = true,
            }
            vim.keymap.set({ "n" }, "gJ", "<cmd>TSJToggle<cr>", {
                desc = "toggle join/split",
                silent = true,
            })
        end,
        keys = { { "gJ", "<cmd>TSJToggle<cr>", desc = "toggle join/split" } },
    },

    {
        -- Auto rename HTML, XML and other kinds of tags
        "windwp/nvim-ts-autotag",
    },

    {
        "danymat/neogen",
        lazy = true,
        cmd = "Neogen",
        opts = {
            enabled = true,
            snippet_engine = "luasnip",
            languages = {
                cs = { template = { annotation_convention = "xmldoc" } },
            },
        },
        dependencies = "nvim-treesitter/nvim-treesitter",
    },

    {
        "folke/paint.nvim",
        config = function()
            require("paint").setup {
                highlights = {
                    {
                        -- filter can be a table of buffer options that should match,
                        -- or a function called with buf as param that should return true.
                        -- The example below will paint @something in comments with Constant
                        filter = { filetype = "lua" },
                        pattern = "%s*%-%-%-%s*(@%w+)",
                        hl = "Constant",
                    },
                },
            }
        end,
    },

    {
        "mizlan/iswap.nvim",
        keys = {
            -- { "g:", "<cmd>ISwap<cr>", desc = "Swap" },
            { "g.", "<cmd>ISwapWith<cr>", desc = "Swap with" },
            -- { "g<", "<cmd>ISwapWithLeft<cr>", desc = "Swap left" },
            -- { "g>", "<cmd>ISwapWithRight<cr>", desc = "Swap right" },
        },
    },

    -- }}}
}
