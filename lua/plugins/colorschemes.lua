vim.api.nvim_exec_autocmds("User", { pattern = "LoadAllColorschemes" })

return {
    -- These should be activated when the autocommand 'User LoadAllColorschemes' is triggered.
    -- How to trigger it when calling the `:colorscheme` command , I don't know.
    -- It is activated when using the telescope binding.
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
        config = function()
            vim.g.tokyonight_style = "night"
        end,
    },

    {
        "tiagovla/tokyodark.nvim",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
        config = function()
            vim.g.tokyodark_transparent_background = false
        end,
    },

    {
        "meliora-theme/neovim",
        name = "melioria",
        lazy = true,
        event = "User LoadAllColorschemes",
        priority = 1000,
        dependencies = { "rktjmp/lush.nvim" },
    },

    {
        "loctvl842/monokai-pro.nvim",
        priority = 1000,
        event = "User LoadAllColorschemes",
        lazy = true,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        event = "User LoadAllColorschemes",
        lazy = true,
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
        event = "User LoadAllColorschemes",
        lazy = true,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        event = "User LoadAllColorschemes",
        lazy = true,
    },

    {
        "ribru17/bamboo.nvim",
        lazy = true,
        event = "User LoadAllColorschemes",
        priority = 1000,
        config = function()
            require("bamboo").setup {
                -- optional configuration here
                cmp_itemkind_reverse = true,
            }
        end,
    },

    {
        "akinsho/horizon.nvim",
        lazy = true,
        event = "User LoadAllColorschemes",
        version = "*",
    },

    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
    },
    {
        "ful1e5/onedark.nvim",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
    },
    {
        "sainnhe/everforest",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
    },
    {
        "sainnhe/sonokai",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
    },
    {
        "savq/melange-nvim",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
    },
    {
        "rebelot/kanagawa.nvim",
        build = ":KanagawaCompile",
        event = "User LoadAllColorschemes",
        priority = 1000,
        lazy = true,
        opts = {
            compile = true,
            overrides = function(colors)
                local theme = colors.theme
                local makeDiagnosticColor = function(color)
                    local c = require("kanagawa.lib.color")
                    return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
                end
                return {
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                    TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                    TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

                    DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
                    DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
                    DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
                    DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

                    GitSignsAddInline = { bg = colors.palette.winterGreen },
                    GitSignsChangeInline = { bg = colors.palette.winterYellow },
                    GitSignsDeleteInline = { bg = colors.palette.winterRed },
                    -- GitSignsAddLnInline = { bg = colors.palette.winterGreen },
                    -- GitSignsChangeLnInline= { bg = colors.palette.winterYellow },
                    -- GitSignsDeleteLnInline = { bg = colors.palette.winterRed },
                }
            end,
        },
    },
    {
        "shaunsingh/moonlight.nvim",
        priority = 1000,
        lazy = true,
        event = "User LoadAllColorschemes",
    },

    -- Remembers the last colorscheme set
    {
        "raddari/last-color.nvim",
        priority = 9999,
        lazy = false,
    },
}
