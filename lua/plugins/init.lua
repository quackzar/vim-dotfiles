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
    -- User Interface {{{
    "stevearc/dressing.nvim",
    "windwp/windline.nvim",

    --TODO: requires: v0.9
    -- use({
    --     "luukvbaal/statuscol.nvim",
    --     config = function() require("statuscol").setup() end
    -- })

    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require("windows").setup {
                autowidth = {
                    enable = false,
                },
                ignore = {
                    buftype = { "quickfix" },
                    filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "packer", "OverseerList" },
                },
            }
        end,
    },

    "famiu/bufdelete.nvim",
    {
        "akinsho/bufferline.nvim",
        version = "v2.*",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("cfg.bufferline")
        end,
    },

    {
        "tiagovla/scope.nvim", -- Makes tabs work like other editors
        config = true,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = true,
    },

    "rktjmp/lush.nvim",

    "kyazdani42/nvim-web-devicons",

    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha-themes.theta").config)
        end,
    },

    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
        end,
    },

    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup {
                text = {
                    spinner = "dots",
                    done = " ", -- character shown when all tasks are complete
                },
            }
        end,
    },

    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup()
            vim.keymap.set(
                "",
                "n",
                "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
                { desc = "next" }
            )
            vim.keymap.set(
                "",
                "N",
                "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
                { desc = "prev" }
            )
            vim.keymap.set("", "*", "*<Cmd>lua require('hlslens').start()<CR>", { desc = "star-search" })
            vim.keymap.set("", "#", "#<Cmd>lua require('hlslens').start()<CR>", { desc = "hash-search" })
            vim.keymap.set("", "g*", "*<Cmd>lua require('hlslens').start()<CR>", { desc = "g-star-search" })
            vim.keymap.set("", "g#", "#<Cmd>lua require('hlslens').start()<CR>", { desc = "g-hash-search" })
        end,
    },

    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                plugins = {
                    marks = true, -- shows a list of your marks on ' and `
                    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                    spelling = {
                        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                        suggestions = 20, -- how many suggestions should be shown in the list?
                    },
                    presets = {
                        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                        motions = true, -- adds help for motions
                        text_objects = true, -- help for text objects triggered after entering an operator
                        windows = false, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true, -- bindings for prefixed with g
                    },
                },
                hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>" }, -- hide mapping boilerplate
                operators = { gc = "Comments" },
                ignore_missing = false, -- fun if one decides to register everything
            }
        end,
    },

    "sindrets/winshift.nvim", -- Used in a Hydra
    {
        "mrjones2014/smart-splits.nvim", -- Used in a Hydra
        config = true,
    },

    {
        "anuvyklack/hydra.nvim",
        dependencies = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
        config = function()
            require("cfg.hydra")
        end,
    },

    {
        "folke/twilight.nvim",
        config = true,
    },

    {
        "folke/zen-mode.nvim",
        config = true,
    },

    {
        "declancm/cinnamon.nvim",
        config = {
            extra_keymaps = true,
            extended_keymaps = false,
            scroll_limit = 100,
            hide_cursor = false,
            default_delay = 5,
            max_length = 500,
        },
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = "kevinhwang91/promise-async",
        config = function()
            local keymap = vim.keymap
            keymap.amend = require("keymap-amend")
            vim.wo.foldcolumn = "0"
            local ftMap = {
                tex = "treesitter",
            }
            require("ufo").setup {
                { "lsp", "treesitter" },
                preview = {
                    win_config = {
                        border = { "", "─", "", "", "", "─", "", "" },
                        winhighlight = "Normal:Folded",
                        winblend = 0,
                    },
                    mappings = {
                        scrollU = "<C-u>",
                        scrollD = "<C-d>",
                    },
                },
                provider_selector = function(_, ft, _)
                    return ftMap[ft]
                end,
            }
            vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Minimize all folds" })
            vim.keymap.set("n", "zr", require("ufo").openAllFolds, { desc = "Open all folds under cursor" })
            vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close all folds under cursor" }) -- closeAllFolds == closeFoldsWith(0)
            vim.keymap.amend("n", "l", function(fallback)
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    fallback()
                end
            end)
        end,
    },

    "eandrju/cellular-automaton.nvim",

    --- }}}
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
    -- Generic Editor Plugins {{{
    "tpope/vim-repeat",
    "tpope/vim-eunuch", -- Basic (Delete, Move, Rename unix commands
    -- 'tpope/vim-unimpaired'

    {
        "linty-org/readline.nvim",
        config = function()
            local readline = require("readline")
            vim.keymap.set("!", "<M-f>", readline.forward_word)
            vim.keymap.set("!", "<M-b>", readline.backward_word)
            vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
            vim.keymap.set("!", "<C-e>", readline.end_of_line)
            vim.keymap.set("!", "<M-d>", readline.kill_word)
            vim.keymap.set("!", "<C-w>", readline.backward_kill_word)
            vim.keymap.set("!", "<C-k>", readline.kill_line)
            vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
        end,
    },

    "aca/vidir.nvim",

    {
        "numToStr/Comment.nvim",
        config = {
            ignore = "^$",
        },
    },

    {
        "monaqa/dial.nvim",
        config = function()
            vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal, { desc = "Dial up" })
            vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal, { desc = "Dial down" })
            vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual, { desc = "Dial up" })
            vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual, { desc = "Dial down" })
            vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual, { desc = "Dial up relative" })
            vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual, { desc = "Dial down relative" })
        end,
    },

    {
        "kylechui/nvim-surround",
        config = true,
    },

    {
        "andymass/vim-matchup",
        event = "VimEnter",
        config = function()
            vim.g.matchup_surround_enabled = 0
            vim.g.matchup_transmute_enabled = 1
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_override_vimtex = 1
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },

    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { silent = true })
            vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { silent = true })
            vim.keymap.set("v", "ga", "<Plug>(EasyAlign)", { silent = true })
        end,
    },

    "Konfekt/vim-sentence-chopper",
    "flwyd/vim-conjoin",

    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.g.indent_blankline_char = "▏"
            vim.g.indent_blankline_filetype_exclude = { "help", "packer", "undotree", "text", "dashboard", "man" }
            vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
            vim.g.indent_blankline_show_trailing_blankline_indent = true
            vim.g.indent_blankline_show_first_indent_level = false
            require("indent_blankline").setup {
                -- for example, context is off by default, use this to turn it on
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            }
        end,
    },

    "reedes/vim-litecorrect", -- autocorrection! Fixes stupid common mistakes

    {
        "kevinhwang91/nvim-bqf",
        config = {
            auto_enable = true,
            auto_resize_height = true,
            func_map = {
                fzffilter = "",
            },
        },
    },

    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        dependencies = "nvim-lua/plenary.nvim",
        config = true,
    },

    { "gpanders/editorconfig.nvim" },

    -- }}}
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
                config = {
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
        config = {
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
        filetype = { "tex" },
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
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
    -- }}}
}
-- vim: foldmethod=marker
