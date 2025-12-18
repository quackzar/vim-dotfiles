return {
    -- Treesitter {{{

    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
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
            vim.keymap.set("n", "[<", function() -- a bit weird with topline
                require("treesitter-context").go_to_context(vim.v.count1)
            end, { silent = true, desc = "goto context" })
        end,
    },

    -- "RRethy/nvim-treesitter-textsubjects",
    -- "nvim-treesitter/nvim-treesitter-textobjects",

    {
        -- For some sensible treesitter based navigation
        "aaronik/treewalker.nvim",
        opts = {},
        keys = {
            -- Parent/children
            { "[[", "<cmd>Treewalker Left<cr>", "tree walk left", mode = { "v", "n" }, desc = "tree walk left" },
            { "]]", "<cmd>Treewalker Right<cr>", "tree walk right", mode = { "v", "n" }, desc = "tree walk right" },
            -- Siblings
            { "][", "<cmd>Treewalker Up<cr>", "tree walk up", mode = { "v", "n" }, desc = "tree walk up" },
            { "[]", "<cmd>Treewalker Down<cr>", "tree walk down", mode = { "v", "n" }, desc = "tree walk down" },
        },
    },

    {
        "RRethy/nvim-treesitter-endwise",
        event = "InsertEnter",
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
                map_c_w = true,
            }
            local Rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")
            local npairs = require("nvim-autopairs")
            npairs.add_rule(Rule("\\(", "\\)", "tex"))
            npairs.add_rule(Rule("\\[", "\\]", "tex"))
            npairs.add_rule(Rule("\\left", "\\right", "tex"))
            -- Sort of works, but screws with single `|`
            --
            --npairs.add_rules({Rule("|", "|", { "rust", "go", "lua" }):with_move(cond.after_regex("|")) })

            -- Very nice!
            npairs.add_rule(Rule("<", ">", {
                -- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
                -- so that it doesn't conflict with nvim-ts-autotag
                "-html",
                "-svelte",
                "-vue",
                "-xml",
                "-javascriptreact",
                "-typescriptreact",
            }):with_pair(
                -- regex will make it so that it will auto-pair on
                -- `a<` but not `a <`
                -- The `:?:?` part makes it also
                -- work on Rust generics like `some_func::<T>()`
                cond.before_regex("%a+:?:?$", 3)
            ):with_move(function(opts)
                return opts.char == ">"
            end))
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
        lazy = false,
        config = function()
            require("nvim-ts-autotag").setup {
                opts = {
                    enable_close = true,
                    enable_rename = true,
                    enable_close_on_slash = true,
                },
            }
        end,
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
