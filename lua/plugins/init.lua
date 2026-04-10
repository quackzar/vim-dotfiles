return {
    {
        "vladdoster/remember.nvim",
        lazy = false,
        config = true,
    },

    {
        "folke/persistence.nvim",
        enabled = true,
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = true,
    },

    {
        "miversen33/netman.nvim",
        lazy = false,
    },

    { -- autoclose unused buffers
        "axkirillov/hbac.nvim",
        config = true,
        event = "VeryLazy",
        opts = {
            autoclose = true,
            threshold = 10,
        },
    },

    {
        "HakonHarnes/img-clip.nvim",
        cmd = "PasteImage",
        opts = {
            -- add options here
            -- or leave it empty to use the default settings
        },
        keys = {
            -- suggested keymap
            { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
        },
    },

    {
        "sustech-data/wildfire.nvim",
        keys = { "<CR>" },
        opts = {
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                node_decremental = "<S-CR>",
            },
        },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = true,
    },

    {
        "nacro90/numb.nvim",
        keys = { ":" },
        config = true,
    },

    {
        "chrishrb/gx.nvim",
        event = { "BufEnter" },
        config = true, -- default settings
    },

    {
        "gbprod/stay-in-place.nvim",
        --  is a Neovim plugin that prevent the cursor from moving when using shift and filter actions.
        config = true,
    },

    -- Language Specific Plugins {{{

    {
        "susensio/magic-bang.nvim",
        config = true,
    },

    -- ==== Hex ===
    {
        "RaafatTurki/hex.nvim",
        config = true,
    },

    -- ======== MARKDOWN ========
    {
        "gaoDean/autolist.nvim",
        ft = {
            "markdown",
            "text",
            "tex",
            "plaintex",
            "norg",
            "typst",
        },
        config = true,
    },

    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        priority = 49,
        opts = function()
            local presets = require("markview.presets")
            return {
                preview = {
                    icon_provider = "mini",
                    modes = { "n", "i", "no", "c" },
                    hybrid_modes = { "n", "i" }, -- Uses this feature on
                    callbacks = {
                        on_enable = function(_, win)
                            vim.wo[win].conceallevel = 2
                            vim.wo[win].conecalcursor = "nc"
                        end,
                    },
                },
                markdown = {
                    headings = presets.headings.arrowed,
                },
                latex = {
                    enable = false,
                },
                typst = {
                    enable = false,
                    code_blocks = {
                        enable = false,
                        style = "simple",
                        text = "",
                        pad_amount = 0,
                        width = 80,
                    },
                    labels = { enable = false },
                    reference_links = { enable = false },
                    list_items = { enable = false },
                    headings = {
                        enable = false,
                    },
                },
            }
        end,
    },

    {
        "OXY2DEV/helpview.nvim",
        lazy = false, -- Recommended

        -- In case you still want to lazy load
        -- ft = "help",

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },

    -- ====== LLVM ====
    { "rhysd/vim-llvm", ft = "llvm" },
    { "cespare/vim-toml", ft = "toml" },

    -- === LUA ===
    "folke/neodev.nvim",

    -- === kitty ===
    "fladson/vim-kitty",

    -- === rust ===
    {
        "mrcjkb/rustaceanvim",
        version = "^8", -- Recommended
        enabled = true,
        init = function()
            local cfg = require("rustaceanvim.config")

            local codelldb_path = vim.env.HOME .. "/.local/share/nvim/mason/bin/codelldb"
            local liblldb_path = vim.env.HOME .. "/.local/share/nvim/mason/bin/liblldb"
            vim.g.rustaceanvim = {
                server = {
                    default_settings = {
                        ["rust-analyzer"] = {
                            assist = {
                                importEnforceGranularity = true,
                                importPrefix = "crate",
                            },
                            inlayHints = {
                                maxLength = 10,
                                locationLinks = true,
                                discriminantHints = true,
                                bindingModeHints = true,
                                closureReturnTypeHints = true,
                                implicitDrops = true,
                                lifetimeElisionHints = true,
                                closureCaptureHints = true,
                            },
                            diagnostics = {
                                enable = true,
                                experimental = {
                                    enable = true,
                                },
                                disabled = {
                                    "inactive-code",
                                    "unused_variables",
                                    "dead_code",
                                },
                            },
                            cargo = {
                                features = "all",
                                buildScripts = { enable = true },
                            },
                            check = {
                                allTargets = true,
                                command = "clippy",
                                workspace = true,
                            },
                            completion = {
                                fullFunctionSignatures = { enable = true },
                            },
                        },
                    },
                },
            }
        end,
    },

    -- {
    --     'cordx56/rustowl',
    --     version = '*', -- Latest stable version
    --     -- build = 'cargo install rustowl',
    --     lazy = false,  -- This plugin is already lazy
    --     opts = {
    --         -- colors = {
    --         --     lifetime = '#98BB6C',   -- Lime green
    --         --     imm_borrow = '#A3D4D5', -- Royal blue
    --         --     mut_borrow = '#D27E99', -- Hot pink
    --         --     move = '#FFA066',       -- Orange
    --         --     call = '#E6C384',       -- Gold
    --         --     outlive = '#FF5D62',    -- Crimson
    --         -- },
    --     },
    -- },

    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        config = true,
    },
    -- === text ===

    {
        "jhofscheier/ltex-utils.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        opts = {},
    },

    -- TeX
    {
        "lervag/vimtex",
        config = function()
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_format_enabled = 1
            vim.g.vimtex_syntax_nospell_comments = 1
            vim.g.vimtex_complete_bib = { simple = 1 }
            vim.g.vimtex_skim_sync = 1
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_quickfix_mode = 0
            if vim.fn.executable("pplatex") then
                vim.g.vimtex_quickfix_method = "pplatex"
            end
            vim.g.vimtex_toc_config = {
                split_pos = "vert rightbelow",
                show_help = 0,
            }
            vim.g.vimtex_compiler_latexmk = {
                options = {
                    "-pdf",
                    "-shell-escape",
                    "-verbose",
                    "-synctex=1",
                    "-interaction=nonstopmode",
                },
                out_dir = "out",
            }

            vim.g.vimtex_syntax_custom_cmds = {
                { name = "vct", mathmode = 1, argstyle = "bold" },
                { name = "R", mathmode = 1, concealchar = "ℝ" },
                { name = "C", mathmode = 1, concealchar = "ℂ" },
                { name = "Z", mathmode = 1, concealchar = "ℤ" },
                { name = "N", mathmode = 1, concealchar = "ℕ" },
                { name = "mathnote", mathmode = 1, nextgroup = "texMathTextArg" },
                { name = "nospell", argspell = 0 },
            }
        end,
    },

    -- Typst
    {
        "kaarmu/typst.vim",
        ft = "typst",
        lazy = false,
    },

    {
        "chomosuke/typst-preview.nvim",
        ft = "typst",
        version = "1.*",
        opts = {
            port = 65000,
            dependencies_bin = {
                ["tinymist"] = "tinymist", -- from Mason
            },
        },
        build = function()
            require("typst-preview").update()
        end,
    },

    -- Mac OS / Xcode
    "darfink/vim-plist",
    {
        "tami5/xbase", -- Consider a way to load this when opening a project.
        build = "make install",
        lazy = true,
        config = true,
        ft = "plist",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    -- }}}
}
-- vim: foldmethod=marker
