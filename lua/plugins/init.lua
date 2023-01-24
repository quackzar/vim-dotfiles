return {
    -- Meta {{{
    -- Packer can manage itself
    "antoinemadec/FixCursorHold.nvim",
    "anuvyklack/keymap-amend.nvim",
    "stevearc/stickybuf.nvim",

    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = true,
    },
    -- }}}
    -- Version Control and Git {{{
    "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("cfg.gitsigns")
        end,
    },

    { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },

    {
        "akinsho/git-conflict.nvim",
        version = "*",
        config = function()
            local conflict = require("git-conflict")
            require("git-conflict").setup {
                default_mappings = true, -- disable buffer local mapping created by this plugin
                disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
                highlights = { -- They must have background color, otherwise the default color will be used
                    incoming = "DiffText",
                    current = "DiffAdd",
                },
            }
            vim.api.nvim_create_autocmd("User", {
                pattern = "GitConflictDetected",
                callback = function()
                    -- vim.notify('Conflict detected in '..vim.fn.expand('<afile>'))
                    vim.keymap.set("n", "cww", function()
                        conflict.engage.conflict_buster()
                        conflict.create_buffer_local_mappings()
                    end)
                end,
            })
        end,
    },
    {
        "TimUntersberger/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("neogit").setup {
                kind = "split",
                integrations = {
                    diffview = true,
                },
            }
            vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
            vim.keymap.set("n", "<leader>gl", "<cmd>Neogit log<cr>", { desc = "Neogit log" })
            vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Neogit commit" })
        end,
    },
    {
        "f-person/git-blame.nvim",
        init = function()
            vim.g.gitblame_enabled = 0
        end,
    },

    {
        "ruifm/gitlinker.nvim",
        config = function()
            require("gitlinker").setup {
                callbacks = {
                    ["github.com"] = require("gitlinker.hosts").get_github_type_url,
                    ["gitlab.com"] = require("gitlinker.hosts").get_gitlab_type_url,
                    ["try.gitea.io"] = require("gitlinker.hosts").get_gitea_type_url,
                    ["codeberg.org"] = require("gitlinker.hosts").get_gitea_type_url,
                    ["bitbucket.org"] = require("gitlinker.hosts").get_bitbucket_type_url,
                    ["try.gogs.io"] = require("gitlinker.hosts").get_gogs_type_url,
                    ["git.sr.ht"] = require("gitlinker.hosts").get_srht_type_url,
                    ["git.launchpad.net"] = require("gitlinker.hosts").get_launchpad_type_url,
                    ["repo.or.cz"] = require("gitlinker.hosts").get_repoorcz_type_url,
                    ["git.kernel.org"] = require("gitlinker.hosts").get_cgit_type_url,
                    ["git.savannah.gnu.org"] = require("gitlinker.hosts").get_cgit_type_url,
                    ["git.fish.princh.com"] = require("gitlinker.hosts").get_gitlab_type_url,
                },
            }
        end,
    },

    -- {
    --     "lewis6991/satellite.nvim",
    --     event = "BufRead",
    --     config = function()
    --         require("satellite").setup {
    --             winblend = 80,
    --             handlers = {
    --                 marks = {
    --                     enable = true,
    --                     show_builtins = true,
    --                 },
    --             },
    --         }
    --     end,
    -- },
    -- { 'petertriho/nvim-scrollbar',
    --     config = function()
    --         require("scrollbar").setup()
    --     end
    -- },

    --- }}}
    -- Navigation {{{
    {
        "nacro90/numb.nvim",
        config = true,
    },

    "chaoren/vim-wordmotion",
    "anuvyklack/vim-smartword",

    {
        "ggandor/leap.nvim",
        config = function()
            vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })
            require("leap").set_default_keymaps()
        end,
    },

    {
        "phaazon/hop.nvim", -- let's try hop too
        branch = "v2", -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
            vim.keymap.set({ "n", "v" }, "<cr>", "<cmd>HopChar2<cr>", { remap = true })
        end,
    },

    {
        "LeonHeidelbach/trailblazer.nvim",
        opts = {
            mappings = {
                nv = { -- Mode union: normal & visual mode. Can be extended by adding i, x, ...

                    motions = {
                        new_trail_mark = "<space>mm",
                        track_back = "<space>mo",
                        peek_move_next_down = "<space>mj",
                        peek_move_previous_up = "<space>mk",
                    },
                    actions = {
                        delete_all_trail_marks = "<space>mD",
                        paste_at_last_trail_mark = "<space>mp",
                        paste_at_all_trail_marks = "<space>mP",
                        set_trail_mark_select_mode = "<space>ms",
                    },
                },
            },
        },
    },

    "farmergreg/vim-lastplace",
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
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
                            buftype = { "terminal" },
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
        "AckslD/nvim-FeMaco.lua",
        config = 'require("femaco").setup()',
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

    -- === Coq ===
    {
        "whonore/Coqtail",
        ft = "coqt",
        config = function()
            vim.g.coqtail_auto_set_proof_diffs = "on"
            vim.g.coqtail_map_prefix = ","
            vim.g.coctail_imap_prefix = "<C-c>"
        end,
    },
    -- === text ===
    { "barreiroleo/ltex-extra.nvim" },

    -- TeX
    {
        "lervag/vimtex",
        ft = { "tex" },
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
                build_dir = "out",
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
    -- Mac OS / Xcode
    "darfink/vim-plist",
    {
        "tami5/xbase",
        build = "make install",
        event = "VimEnter",
        config = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    -- }}}
}
-- vim: foldmethod=marker
