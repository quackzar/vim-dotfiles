return {
    -- Meta {{{
    -- Packer can manage itself
    "wbthomason/packer.nvim",

    -- "nathom/filetype.nvim", -- faster filetype detection

    "antoinemadec/FixCursorHold.nvim",
    "anuvyklack/keymap-amend.nvim",
    "stevearc/stickybuf.nvim",

    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    },
    -- }}}
    -- User Interface {{{
    "stevearc/dressing.nvim",
    "windwp/windline.nvim",

    --  Sadly doesn't quite work with statusline
    -- { 'levouh/tint.nvim', config = function()
    --         require("tint").setup({
    --             ignore = {"StatusLine*"}
    --         })
    --     end
    -- },

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
        config = function()
            require("scope").setup()
        end,
    },

    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },

    "rktjmp/lush.nvim",

    "kyazdani42/nvim-web-devicons",

    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.theta").config)
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

    -- use({
    --     "folke/noice.nvim",
    --     event = "VimEnter",
    --     config = function()
    --         require("noice").setup({
    --             messages = {
    --                 view = "mini",
    --                 view_warn = "notify",
    --                 view_error = "notify",
    --             },
    --             lsp = {
    --                 -- override = {
    --                 --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                 --     ["vim.lsp.util.stylize_markdown"] = true,
    --                 --     ["cmp.entry.get_documentation"] = true,
    --                 -- },
    --                 signature = {
    --                     enabled = false,
    --                 }
    --             }
    --         })
    --         require("telescope").load_extension("noice")
    --         vim.keymap.set("n", "<c-f>", function()
    --             if not require("noice.lsp").scroll(4) then
    --                 return "<c-f>",
    --             end
    --         end, { silent = true, expr = true })
    --         vim.keymap.set("n", "<c-b>", function()
    --             if not require("noice.lsp").scroll(-4) then
    --                 return "<c-b>",
    --             end
    --         end, { silent = true, expr = true })
    --     end,
    --     dependencies = {
    --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     after = { 'telescope.nvim' },
    -- })

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
        config = function()
            require("smart-splits").setup {}
        end,
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
        config = function()
            require("twilight").setup {}
        end,
    },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {}
        end,
    },

    {
        "declancm/cinnamon.nvim", -- FIX: Disable when running neovide
        -- cond = function()
        --     return not vim.fn.exists("g:neovide")
        -- end,
        config = function()
            require("cinnamon").setup {
                extra_keymaps = true,
                extended_keymaps = false,
                scroll_limit = 100,
                hide_cursor = false,
                default_delay = 5,
                max_length = 500,
            }
        end,
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
    -- Colorschemes {{{,
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.g.tokyonight_style = "night"
        end,
    },
    {
        "tiagovla/tokyodark.nvim",
        config = function()
            vim.g.tokyodark_transparent_background = false
        end,
    },
    {
        "meliora-theme/neovim",
        name = "melioria",
        dependencies = { "rktjmp/lush.nvim" },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup {
                flavour = "mocha",
                dim_inactive = {
                    enabled = false,
                },
                term_colors = true, -- ??? screws with windline
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
                    indent_blankline = { enabled = true },
                },
            }
            -- vim.g.terminal_color_0 = nil
            -- vim.g.terminal_color_8 = nil
        end,
    },

    "mhartington/oceanic-next",

    { "rose-pine/neovim", name = "rose-pine" },

    "ellisonleao/gruvbox.nvim",
    "ful1e5/onedark.nvim",
    "sainnhe/everforest",
    "sainnhe/sonokai",
    "savq/melange-nvim",
    "EdenEast/nightfox.nvim",
    "rebelot/kanagawa.nvim",
    "shaunsingh/moonlight.nvim",

    "raddari/last-color.nvim", -- last colorscheme set, really nice for swapping round a lot

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
        config = function()
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

    "nvim-treesitter/nvim-treesitter-refactor",

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
            -- TODO: Find approriate keymap
            vim.keymap.set({ "n", "x" }, "<leader>rs", function()
                require("ssr").open()
            end)
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
        "danymat/neogen", -- TODO: research
        config = function()
            require("neogen").setup {
                enabled = true,
                snippet_engine = "luasnip",
                languages = {
                    cs = { template = { annotation_convention = "xmldoc" } },
                },
            }

            vim.keymap.set("n", "<Leader>nn", require("neogen").generate, { desc = "document thing" })
            vim.keymap.set("n", "<Leader>nf", function()
                require("neogen").generate { type = "func" }
            end, { desc = "document function" })
            vim.keymap.set("n", "<Leader>nc", function()
                require("neogen").generate { type = "class" }
            end, { desc = "document class" })
            vim.keymap.set("n", "<Leader>nd", function()
                require("neogen").generate { type = "file" }
            end, { desc = "document file" })
            vim.keymap.set("n", "<Leader>nt", function()
                require("neogen").generate { type = "type" }
            end, { desc = "document type" })
        end,
        dependencies = "nvim-treesitter/nvim-treesitter",
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
        config = function()
            vim.keymap.set("n", "g,", "<cmd>ISwap<cr>", { desc = "Swap" })
            vim.keymap.set("n", "g.", "<cmd>ISwapWith<cr>", { desc = "Swap with" })
        end,
    },

    -- }}}
    -- LSP + Snippets {{{
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jayp0521/mason-nvim-dap.nvim",
        "jayp0521/mason-null-ls.nvim",
        "neovim/nvim-lspconfig",
    },

    "weilbith/nvim-code-action-menu",
    "kosayoda/nvim-lightbulb",

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "toggle trouble" })
            vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
            vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
            vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
            vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
            vim.keymap.set("n", "<leader>xc", "<cmd>TroubleClose<cr>")
            vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>")
            require("trouble").setup {
                use_diagnostic_signs = true,
            }
        end,
    },

    -- { 'Issafalcon/lsp-overloads.nvim'},
    "ray-x/lsp_signature.nvim",

    {
        "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
        config = function()
            require("toggle_lsp_diagnostics").init()
        end,
    },

    "jose-elias-alvarez/null-ls.nvim",

    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup {
                backends = { "treesitter", "lsp", "markdown", "man" },
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set("n", "[[", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "]]", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
            }
            vim.keymap.set("n", "<leader>v", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
        end,
    },

    -- use{
    --	   "zbirenbaum/copilot.lua",
    --	   event = {"VimEnter"},
    --	   config = function()
    --		   vim.defer_fn(function()
    --			   require("copilot").setup()
    --		   end, 100)
    --	   end,
    -- }
    -- {
    --	   "zbirenbaum/copilot-cmp",
    --	   after = { "copilot.lua", "nvim-cmp" },
    -- },

    -- {
    --     "tzachar/cmp-tabnine",
    --     build = "./install.sh",
    --     before = "nvim-cmp",
    --     config = function()
    --         local tabnine = require("cmp_tabnine")
    --         tabnine.setup {
    --             show_prediction_strength = true,
    --         }
    --     end,
    -- },

    { "onsails/lspkind-nvim" },
    {
        -- disable = true,
        "hrsh7th/nvim-cmp", -- TODO: https://github.com/hrsh7th/nvim-cmp/pull/1094
        config = function()
            require("cfg.cmp")
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
    },

    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("cfg.luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
        event = "InsertEnter",
    },

    {
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup {
                -- optional configuration
            }
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },

    -- }},}
    -- Running, Testing and Debugging {{{
    {
        "stevearc/overseer.nvim",
        config = function()
            require("overseer").setup {
                strategy = {
                    "toggleterm",
                },
                task_list = {
                    direction = "right",
                },
                log = {
                    {
                        type = "notify",
                        level = vim.log.levels.INFO,
                    },
                },
            }
            vim.keymap.set("n", "<leader>c", "<cmd>OverseerToggle<cr>", { desc = "Toggle Overseer" })
            vim.keymap.set("n", "<leader>C", "<cmd>OverseerRun<cr>", { desc = "Run a task" })
            vim.keymap.set("n", "<leader>A", "<cmd>OverseerQuickAction<cr>", { desc = "Overseer Action" })
        end,
    },

    { -- TODO: Setup mappings
        "rcarriga/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",

            -- Seperate test suites (should maybe be hot-loaded?)
            "rouge8/neotest-rust",
            "nvim-neotest/neotest-python",
            "haydenmeade/neotest-jest",
            "Issafalcon/neotest-dotnet",
        },
        config = function()
            require("cfg.neotest")
        end,
    },

    -- { "Olical/conjure", event = "VimEnter" },

    "mfussenegger/nvim-dap",
    { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" } },
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" } },
    { "mfussenegger/nvim-dap-python", dependencies = { "mfussenegger/nvim-dap" } },

    -- {'t-troebst/perfanno.nvim', config = function()
    --	   require('cfg.perfanno')
    -- end
    -- },
    --
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup {
                shell = "fish",
            }
            vim.keymap.set(
                { "n", "i", "v", "t", "t" },
                "<C-\\>",
                "<cmd>ToggleTerm<cr>",
                { silent = true, desc = "Toggle Terminal" }
            )
        end,
    },

    {
        "p00f/godbolt.nvim",
        config = function()
            require("godbolt").setup {
                quickfix = {
                    enable = true, -- whether to populate the quickfix list in case of errors
                    auto_open = true, -- whether to open the quickfix list in case of errors
                },
            }
        end,
    },

    -- }}}

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
        config = function()
            require("Comment").setup {
                ignore = "^$",
            }
        end,
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
        config = function()
            require("nvim-surround").setup {}
        end,
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
        config = function()
            require("refactoring").setup {}
            -- Used in a Hydra
        end,
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
        config = function()
            require("bqf").setup {
                auto_enable = true,
                auto_resize_height = true,
                func_map = {
                    fzffilter = "",
                },
            }
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end,
    },

    { "gpanders/editorconfig.nvim" },

    -- }}}
    -- Telescope {{{
    --
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } },
        event = "VimEnter",
        config = function()
            require("cfg.telescope")
        end,
    },

    "willthbill/opener.nvim",

    "romgrk/fzy-lua-native", -- for use with wilder

    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    -- "nvim-telescope/telescope-z.nvim",

    {
        "stevearc/resession.nvim",
        config = function()
            local resession = require("resession")
            resession.setup {
                autosave = {
                    enabled = true,
                    interval = 60,
                    notify = false,
                },
                tab_buf_filter = function(tabpage, bufnr)
                    local dir = vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tabpage))
                    return vim.startswith(vim.api.nvim_buf_get_name(bufnr), dir)
                end,
            }
            vim.keymap.set("n", "<leader>ss", resession.save_tab, { desc = "Save session" })
            vim.keymap.set("n", "<leader>sl", resession.load, { desc = "Load session" })
            vim.keymap.set("n", "<leader>sd", resession.delete, { desc = "Delete session" })
        end,
    },

    {

        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker")
        end,
    },

    {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = function()
            require("colortils").setup {}
        end,
    },

    -- }}}
    -- Navigation {{{
    {
        "nacro90/numb.nvim",
        config = function()
            require("numb").setup()
        end,
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
                config = function()
                    require("window-picker").setup {
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
                    }
                end,
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
        config = function()
            require("autolist").setup {}
        end,
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
        config = function()
            require("rest-nvim").setup {
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
            }
        end,
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
