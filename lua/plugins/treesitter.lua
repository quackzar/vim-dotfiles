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
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 8, -- How many lines the window should span. Values <= 0 mean no limit.
            }
        end,
    },

    "RRethy/nvim-treesitter-textsubjects",

    "nvim-treesitter/nvim-treesitter-textobjects",

    -- "nvim-treesitter/nvim-treesitter-refactor",

    "nvim-treesitter/playground",

    { "nvim-treesitter/nvim-treesitter-angular", ft = { "html", "ts" } },

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
            local npairs = require("nvim-autopairs")
            npairs.add_rule(Rule("\\(", "\\)", "tex"))
            npairs.add_rule(Rule("\\[", "\\]", "tex"))
            npairs.add_rule(Rule("\\left", "\\right", "tex"))
        end,
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
        "ckolkey/ts-node-action",
        dependencies = { "nvim-treesitter" },
        config = function() -- Optional
            require("ts-node-action").setup {}
            vim.keymap.set(
                { "n" },
                "<localleader>t",
                require("ts-node-action").node_action,
                { desc = "Trigger Node Action" }
            )
        end,
        keys = { "<localleader>t" },
    },

    { "windwp/nvim-ts-autotag" },

    {
        "cshuaimin/ssr.nvim",
        module = "ssr",
        -- Calling setup is optional.
        config = function()
            require("ssr").setup {
                min_width = 50,
                min_height = 5,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_all = "<leader><cr>",
                },
            }
        end,
    },

    {
        "abecodes/tabout.nvim",
        event = "InsertEnter",
        config = function()
            require("tabout").setup {
                tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true, -- shift content if tab out is not possible
                act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = "<C-d>", -- reverse shift default action,
                enable_backwards = true, -- well ...
                completion = true, -- if the tabkey is used in a completion pum
                tabouts = {
                    { open = "'", close = "'" },
                    { open = '"', close = '"' },
                    { open = "`", close = "`" },
                    { open = "(", close = ")" },
                    { open = "[", close = "]" },
                    { open = "{", close = "}" },
                    { open = "\\(", close = "\\)" },
                    { open = "\\{", close = "\\}" },
                    { open = "\\[", close = "\\]" },
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {}, -- tabout will ignore these filetypes
            }
        end,
        dependencies = { "nvim-treesitter", "nvim-cmp" },
    },

    {
        "danymat/neogen",
        opts = {
            enabled = true,
            snippet_engine = "luasnip",
            languages = {
                cs = { template = { annotation_convention = "xmldoc" } },
            },
        },
        dependencies = "nvim-treesitter/nvim-treesitter",
        keys = {
            {
                "<leader>nn",
                function()
                    require("neogen").generate {}
                end,
                desc = "document thing",
            },
            {
                "<leader>nf",
                function()
                    require("neogen").generate { type = "func" }
                end,
                desc = "document function",
            },
            {
                "<leader>nc",
                function()
                    require("neogen").generate { type = "class" }
                end,
                desc = "document class",
            },
            {
                "<leader>nd",
                function()
                    require("neogen").generate { type = "file" }
                end,
                desc = "document file",
            },
            {
                "<leader>nn",
                function()
                    require("neogen").generate { type = "type" }
                end,
                desc = "document type",
            },
        },
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
            { "g:", "<cmd>ISwap<cr>", desc = "Swap" },
            { "g.", "<cmd>ISwapWith<cr>", desc = "Swap with" },
            { "g<", "<cmd>ISwapWithLeft<cr>", desc = "Swap left" },
            { "g>", "<cmd>ISwapWithRight<cr>", desc = "Swap right" },
        },
    },

    -- }}}
}
