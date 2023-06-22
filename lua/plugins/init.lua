return {
    -- Meta {{{
    "antoinemadec/FixCursorHold.nvim",
    "anuvyklack/keymap-amend.nvim",

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
        opts = {
            autoclose = true,
            threshold = 10,
        },
    },

    -- }}}
    -- Navigation {{{
    {
        "nacro90/numb.nvim",
        config = true,
    },

    -- "chaoren/vim-wordmotion",
    -- "anuvyklack/vim-smartword",

    {
        "ggandor/leap.nvim",
        enabled = true,
        config = function()
            -- vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })
            -- vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' }) -- or some grey
            -- vim.api.nvim_set_hl(0, 'LeapMatch', {
            --     -- For light themes, set to 'black' or similar.
            --     fg = 'white', bold = true, nocombine = true,
            -- })
            -- -- Of course, specify some nicer shades instead of the default "red" and "blue".
            -- vim.api.nvim_set_hl(0, 'LeapLabelPrimary', {
            --     fg = 'red', bold = true, nocombine = true,
            -- })
            -- vim.api.nvim_set_hl(0, 'LeapLabelSecondary', {
            --     fg = 'blue', bold = true, nocombine = true,
            -- })
            -- Try it without this setting first, you might find you don't even miss it.
            require("leap").opts.highlight_unlabeled_phase_one_targets = true

            require("leap").set_default_keymaps()
        end,
    },

    -- {
    --     "phaazon/hop.nvim", -- let's try hop too
    --     branch = "v2", -- optional but strongly recommended
    --     config = function()
    --         -- you can configure Hop the way you like here; see :h hop-config
    --         require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    --         vim.keymap.set({ "n", "x" }, "s", "<cmd>HopChar2<cr>", { remap = true })
    --     end,
    -- },

    -- {
    --     "echasnovski/mini.jump2d",
    --     version = "*",
    --     opts = {
    --         mappings = { start_jumping = "s" },
    --         allowed_windows = { non_current = false },
    --         view = { dim = true },
    --     },
    -- },

    {
        "folke/flash.nvim",
        enabled = true,
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        keys = {
            {
                "<space>s",
                -- "s",
                mode = { "n", "x", "o" },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require("flash").jump()
                end,
            },
            {
                -- This is really cool but the keymap 'S' conflicts with surround in [ox] mode
                "<space>S",
                -- "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
            },
        },
    },

    {
        "cbochs/portal.nvim",
        -- Ootional dependencies
        dependencies = { "cbochs/grapple.nvim" },
        config = function()
            vim.keymap.set("n", "<C-S-o>", "<cmd>Portal jumplist backward<cr>", { desc = "Portal backward" })
            vim.keymap.set("n", "<C-S-i>", "<cmd>Portal jumplist forward<cr>", { desc = "Portal forward" })
        end,
        keys = { { "<C-S-o>" }, { "<C-S-i>" } },
    },

    {
        "rgroli/other.nvim",
        main = "other-nvim",
        opts = {
            mappings = {
                -- Default
                "livewire",
                "angular",
                "laravel",
                "rails",
                "golang",
                -- C(++)
                { pattern = "(.*).c$", target = "%1.h", context = "header" },
                { pattern = "(.*).h$", target = "%1.c", context = "source" },
                { pattern = "(.*).cpp$", target = "%1.hpp", context = "header" },
                { pattern = "(.*).hpp$", target = "%1.cpp", context = "source" },
            },
        },
        keys = { -- TODO: Make relevant hydra?
            { "<leader>ll", "<cmd>Other<cr>", { desc = "Other" } },
            { "<leader>lp", "<cmd>OtherSplit<cr>", { desc = "Other split" } },
            { "<leader>lv", "<cmd>OtherVSplit<cr>", { desc = "Other v-split" } },
            { "<leader>lc", "<cmd>OtherClear<cr>", { desc = "Other clear" } },
        },
    },

    -- {
    --     'tzachar/local-highlight.nvim',
    --     config = function()
    --         require('local-highlight').setup({
    --             file_types = {'python', 'cpp', 'c', 'rust', 'lua'}
    --         })
    --     end
    -- },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
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

    -- ==========  C  ==========
    "justinmk/vim-syntax-extra",
    "shirk/vim-gas",
    "ARM9/arm-syntax-vim",
    -- {'p00f/clangd_extensions.nvim'},

    -- ======== MARKDOWN ========
    {
        "gaoDean/autolist.nvim",
        config = true,
    },
    {
        "plasticboy/vim-markdown",
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
        "Zeioth/markmap.nvim",
        build = "npm install --global markmap-cli",
        cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
        opts = {
            html_output = "/tmp/markmap.html", -- (default) Setting a empty string "" here means: [Current buffer path].html
            hide_toolbar = false, -- (default)
            grace_period = 3600000, -- (default) Stops markmap watch after 60 minutes. Set it to 0 to disable the grace_period.
        },
    },

    {
        "AckslD/nvim-FeMaco.lua",
        config = true,
    },

    {
        "atusy/tsnode-marker.nvim",
        lazy = true,
        filetype = "markdown",
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

    -- ======== ASCIIDOC =======
    {
        "habamax/vim-asciidoctor",
        ft = "asciidoc",
        config = function()
            vim.g.asciidoctor_fenced_languages = {
                "go",
                "c",
                "python",
                "tex",
                "sh",
                "fish",
                "javascript",
                "vim",
                "html",
                "java",
            }
            vim.g.asciidoctor_syntax_conceal = 1
            vim.g.asciidoctor_folding = 1
        end,
    },

    -- ==========  fish  ==========
    { "mtoohey31/cmp-fish", ft = "fish" },

    -- ======== GRAPHVIZ ========
    { "liuchengxu/graphviz.vim", ft = "dot" },

    -- ======= OCAML ======
    { "ELLIOTTCABLE/vim-menhir", ft = { "ocaml", "reasonml" } },

    -- ====== LLVM ====
    { "rhysd/vim-llvm", ft = "llvm" },
    { "cespare/vim-toml", ft = "toml" },

    -- === LUA ===
    "folke/neodev.nvim",

    -- === kitty ===
    "fladson/vim-kitty",

    -- === GLSL ===
    "tikhomirov/vim-glsl",

    -- === rust ===
    { "simrat39/rust-tools.nvim" },
    {
        "saecki/crates.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        event = { "BufRead Cargo.toml" },
    },

    -- == rest client ===
    {
        "NTBBloodbath/rest.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- Open request results in a horizontal split
            result_split_horizontal = false,
            -- Skip SSL verification, useful for unknown certificates
            skip_ssl_verification = false,
            -- Highlight request on run
            highlight = {
                enabled = true,
                timeout = 150,
            },
            result = {
                -- toggle showing URL, HTTP info, headers at top the of result window
                show_url = true,
                show_http_info = true,
                show_headers = true,
            },
            -- Jump to request line on run
            jump_to_request = false,
            env_file = ".env",
            custom_dynamic_variables = {},
            yank_dry_run = true,
        },
    },

    -- === text ===
    { "barreiroleo/ltex-extra.nvim" },

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

    -- Mac OS / Xcode
    "darfink/vim-plist",
    {
        "tami5/xbase", -- Consider a way to load this when opening a project.
        build = "make install",
        lazy = true,
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    -- }}}
}
-- vim: foldmethod=marker
