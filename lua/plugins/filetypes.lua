return {
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

    {
        "0xferrous/ansi.nvim",
        config = function()
            require("ansi").setup {
                auto_enable = false, -- Auto-enable for configured filetypes
                auto_enable_stdin = true, -- Auto-enable for piped stdin content
                filetypes = { "log", "ansi" },
            }
        end,
    },

    -- ====== LLVM ====
    { "rhysd/vim-llvm", ft = "llvm" },
    { "cespare/vim-toml", ft = "toml" },

    -- === LUA ===
    "DrKJeff16/wezterm-types",

    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                "lazy.nvim",
                { path = "LazyVim", words = { "LazyVim" } },
                -- Load the wezterm types when the `wezterm` module is required
                -- Needs `DrKJeff16/wezterm-types` to be installed
                { path = "wezterm-types", mods = { "wezterm" } },
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    -- === kitty ===
    "fladson/vim-kitty",

    -- === text ===

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

    "https://github.com/dcharbon/vim-flatbuffers",
}
