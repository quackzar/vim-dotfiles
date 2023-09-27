return {
    -- Should probably start hoarding less colorschemes, but a system to lazyload while still be
    -- available in the 'colorscheme' command or in Telescope would be nice.
    -- Although, loadtimes of colorschemes should be pretty low.
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.g.tokyonight_style = "night"
        end,
    },

    {
        "tiagovla/tokyodark.nvim",
        priority = 1000,
        config = function()
            vim.g.tokyodark_transparent_background = false
        end,
    },

    {
        "meliora-theme/neovim",
        name = "melioria",
        priority = 1000,
        dependencies = { "rktjmp/lush.nvim" },
    },

    {
        "loctvl842/monokai-pro.nvim",
        priority = 1000,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                flavour = "mocha",
                dim_inactive = {
                    enabled = false,
                },
                transparent_background = false,
                term_colors = false, -- ??? screws with windline
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    neotree = true,
                    telescope = true,
                    notify = true,
                    neogit = true,
                    neotest = true,
                    overseer = true,
                    treesitter = true,
                    treesitter_context = true,
                    which_key = true,
                    leap = true,
                    native_lsp = { enabled = true },
                    dap = { enabled = true },
                    indent_blankline = { enabled = false },
                },
            }
            -- vim.g.terminal_color_0 = nil
            -- vim.g.terminal_color_8 = nil
        end,
    },

    {
        "mhartington/oceanic-next",
        priority = 1000,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
    },

    {
        "ribru17/bamboo.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("bamboo").setup {
                -- optional configuration here
            }
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
    },
    {
        "ful1e5/onedark.nvim",
        priority = 1000,
    },
    {
        "sainnhe/everforest",
    },
    {
        "sainnhe/sonokai",
        priority = 1000,
    },
    {
        "savq/melange-nvim",
        priority = 1000,
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        opts = {
            compile = true,
        },
        build = ":KanagawaCompile",
        priority = 1000,
    },
    {
        "shaunsingh/moonlight.nvim",
        priority = 1000,
    },

    -- Remembers the last colorscheme set
    {
        "raddari/last-color.nvim",
        priority = 9999,
    },
}
