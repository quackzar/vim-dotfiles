return {
    -- Meta {{{
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

    -- }}}
    -- Navigation {{{
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
        "folke/flash.nvim",
        enabled = true,
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            highlight = {
                backdrop = true,
            },
            modes = {
                search = {
                    enabled = false,
                },
            },
        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require("flash").jump {
                        search = { forward = true, wrap = false, multi_window = false },
                    }
                end,
            },
            {
                "S",
                mode = {
                    "n", --[[ "x", "o" ]]
                },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require("flash").jump {
                        search = { forward = false, wrap = false, multi_window = false },
                    }
                end,
            },
            {
                -- This is really cool but the keymap 'S' conflicts with surround in [ox] mode
                -- hopefully '.' isn't used for anything.
                ".",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter()
                end,
            },
        },
    },

    {
        -- But really cool though
        "cbochs/portal.nvim",
        lazy = true,
        config = true,
        keys = {
            { "<C-S-o>", "<cmd>Portal jumplist backward<cr>", desc = "Portal backward" },
            { "<C-S-i>", "<cmd>Portal jumplist forward<cr>", desc = "Portal forward" },
        },
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            {
                -- TODO:
                name = "neo-tree-neotest",
                dir = "~/Projects/misc/neo-tree-neotest",
            },
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
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
        config = function()
            require("stay-in-place").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    },
    -- }}}
    -- Language Specific Plugins {{{

    {
        "susensio/magic-bang.nvim",
        config = true,
    },

    {
        "rest-nvim/rest.nvim",
        ft = "http",
        opts = {
            result_split_in_place = false,
        },
        config = true,
        keys = {
            { "<localleader>r", "<Plug>RestNvim" },
            { "<localleader>p", "<Plug>RestNvimPreview" },
            { "<localleader>l", "<Plug>RestNvimLast" },
        },
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
        "plasticboy/vim-markdown",
        enabled = false,
        ft = "markdown",
        config = function()
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_toml_frontmatter = 1
            vim.g.vim_markdown_json_frontmatter = 1
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_strikethrough = 1
            -- vim.g.vim_markdown_fenced_languages = {'go', 'c', 'python', 'tex', 'bash=sh', 'sh', 'fish', 'javascript', 'viml=vim', 'html'}
        end,
    },

    {
        -- Does the same thing as tsnode-marker
        "lukas-reineke/headlines.nvim",
        enabled = false,
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = true,
        ft = { "markdown", "norg", "org" },
    },

    {
        "OXY2DEV/markview.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "AckslD/nvim-FeMaco.lua",
        enabled = false,
        config = true,
        ft = "markdown",
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
        version = "^4", -- Recommended
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
                    settings = {
                        ["rust-analyzer"] = {
                            assist = {
                                importEnforceGranularity = true,
                                importPrefix = "crate",
                            },
                            inlayHints = { locationLinks = true },
                            diagnostics = {
                                enable = true,
                                experimental = {
                                    enable = false,
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
        commit = "e4d0721", -- BUG: https://github.com/kaarmu/typst.vim/issues/64
        ft = "typst",
        lazy = false,
    },
    -- {
    --     "MrPicklePinosaur/typst-conceal.vim",
    --     init = function()
    --         vim.g.typst_conceal_math = true
    --         vim.g.typst_conceal_emoji = true
    --     end,
    -- },

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
