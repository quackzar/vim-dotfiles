return {
    {
        "stevearc/stickybuf.nvim",
        config = true,
    },

    "farmergreg/vim-lastplace",

    {
        "folke/persistence.nvim",
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
        keys = { "<cr>" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = true,
    },

    {
        "nacro90/numb.nvim",
        keys = { ":" },
        config = true,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            -- {
            --     -- TODO:
            --     name = "neo-tree-neotest",
            --     dir = "~/Projects/misc/neo-tree-neotest",
            -- },
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                "s1n7ax/nvim-window-picker",
                version = "1.*",
                opts = {
                    autoselect_one = true,
                    include_current = false,
                    filter_rules = {
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "nofile" },
                        },
                    },
                    other_win_hl_color = "#e35e4f",
                },
            },
        },
        config = function()
            require("cfg.neotree")
            local group = vim.api.nvim_create_augroup("refresh-neotree", { clear = true })
            -- This ensures neo-tree is updated after <C-z> or other things that could change things.
            -- This is mostly an issue with git commands that stage or unstage things, as file changes are detected.
            vim.api.nvim_create_autocmd({ "FocusGained", "VimResume", "TermLeave" }, {
                group = group,
                callback = function()
                    require("neo-tree.sources.manager").refresh()
                end,
            })
            -- This ensures that neo-tree is updated whenever neo-git does 'something'.
            -- Usually this means staging/unstaging files will be reflected immediately.
            vim.api.nvim_create_autocmd({ "User" }, {
                pattern = "NeogitStatusRefreshed",
                group = group,
                callback = function()
                    require("neo-tree.sources.manager").refresh()
                end,
            })
        end,
        lazy = true,
        cmd = "Neotree",
        init = function()
            vim.keymap.set("n", "<leader>z", "<cmd>Neotree focus<cr>", { desc = "Focus file tree" })
            vim.keymap.set("n", "<leader>Z", "<cmd>Neotree toggle<cr>", { desc = "Toggle file tree" })
            vim.keymap.set("n", "<leader>v", "<cmd>Neotree focus document_symbols<cr>", { desc = "Focus symbols" })
            vim.keymap.set("n", "<leader>V", "<cmd>Neotree toggle document_symbols<cr>", { desc = "Toggle symbols" })
        end,
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
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
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

    -- ==========  fish  ==========
    { "mtoohey31/cmp-fish", ft = "fish" },

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
        version = "^6", -- Recommended
        enabled = true,
        ft = { "rust" },
        init = function()
            local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.10.0/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb"
            local this_os = vim.loop.os_uname().sysname
            -- The path is different on Windows
            if this_os:find("Windows") then
                codelldb_path = extension_path .. "adapter\\codelldb.exe"
                liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
            else
                -- The liblldb extension is .so for Linux and .dylib for MacOS
                liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
            end

            local cfg = require("rustaceanvim.config")

            vim.g.rustaceanvim = {
                dap = {
                    adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
                },
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
                            },
                            diagnostics = {
                                enable = true,
                                experimental = {
                                    enable = true,
                                },
                                disabled = {
                                    "inactive-code",
                                    "unused_variables",
                                },
                            },
                            cargo = {
                                features = "all",
                                buildScripts = { enable = true },
                            },
                            check = {
                                command = "clippy",
                                workspace = false,
                            },
                            checkOnSave = {
                                command = "clippy",
                                workspace = false,
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

    {
        "saecki/crates.nvim",
        tag = "stable",
        event = { "BufRead Cargo.toml" },
        config = true,
    },

    -- === text ===

    {
        "barreiroleo/ltex_extra.nvim",
        lazy = true,
        dependencies = { "neovim/nvim-lspconfig" },
        -- yes, you can use the opts field, just I'm showing the setup explicitly
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

    {
        "tamarin-prover/editors",
        name = "tamarin",
    },
    -- }}}
}
-- vim: foldmethod=marker
