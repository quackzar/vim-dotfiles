-- Prelude {{{
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then -- check if packer is installed
    packer_bootstrap =
        fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
end

require("packer").init {
    max_jobs = 50,
}

-- auto compile when this file is modified
vim.cmd([[
  augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
-- }}}

return require("packer").startup {
    function()
        -- Meta {{{
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        use("lewis6991/impatient.nvim") -- speed up startup
        use("nathom/filetype.nvim") -- faster filetype detection

        use("antoinemadec/FixCursorHold.nvim")
        use("anuvyklack/keymap-amend.nvim")

        use {
            "folke/persistence.nvim",
            event = "BufReadPre", -- this will only start session saving when an actual file was opened
            module = "persistence",
            config = function()
                require("persistence").setup()
            end,
        }
        -- }}}
        -- User Interface {{{
        use { "stevearc/dressing.nvim" }
        use("windwp/windline.nvim")

        --  Sadly doesn't quite work with statusline
        -- use { 'levouh/tint.nvim', config = function()
        --         require("tint").setup({
        --             ignore = {"StatusLine*"}
        --         })
        --     end
        -- }
        use { "anuvyklack/windows.nvim",
            requires = {
                "anuvyklack/middleclass",
                "anuvyklack/animation.nvim"
            },
            config = function()
                vim.o.winwidth = 10
                vim.o.winminwidth = 10
                vim.o.equalalways = false
                require('windows').setup({
                    autowidth = {
                        enable = false
                    },
                    ignore = {
                        buftype = { "quickfix" },
                        filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "packer", "OverseerList" }
                    },
                })
            end
        }

        use("famiu/bufdelete.nvim")
        use {
            "akinsho/bufferline.nvim",
            tag = "v2.*",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("cfg.bufferline")
            end,
        }
        use {
            "tiagovla/scope.nvim", -- Makes tabs work like other editors
            config = function()
                require("scope").setup()
            end,
        }

        use {
            "norcalli/nvim-colorizer.lua",
            config = function()
                require("colorizer").setup()
            end,
        }

        use("rktjmp/lush.nvim")

        use("meznaric/conmenu")

        use("kyazdani42/nvim-web-devicons")

        use {
            "goolord/alpha-nvim",
            config = function()
                require("alpha").setup(require("alpha.themes.dashboard").config)
            end,
        }

        -- use { 'melkster/modicator.nvim',
        --     after = 'catppuccin', -- Add your colorscheme plugin here
        --     config = function()
        --         local modicator = require('modicator')
        --         modicator.setup({
        --             highlights = {
        --                 modes = {
        --                     ['i'] = vim.g.terminal_color_2, -- green
        --                     ['v'] = vim.g.terminal_color_3, -- yellow
        --                     ['V'] = vim.g.terminal_color_3,
        --                     ['�'] = vim.g.terminal_color_3,
        --                     ['s'] = vim.g.terminal_color_6, -- cyan
        --                     ['S'] = vim.g.terminal_color_6,
        --                     ['R'] = vim.g.terminal_color_4, -- blue
        --                     ['c'] = vim.g.terminal_color_5, -- magenta
        --                 },
        --             }
        --         })
        --     end
        -- }

        use {
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
            end,
        }

        -- use({
        --     "folke/noice.nvim",
        --     event = "VimEnter",
        --     config = function()
        --         require("noice").setup({
        --             popupmenu = {
        --                 enabled = false
        --             }
        --         })
        --     end,
        --     requires = {
        --         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        --         "MunifTanjim/nui.nvim",
        --         "rcarriga/nvim-notify",
        --         "hrsh7th/nvim-cmp",
        --     }
        -- })

        use {
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
        }

        use("sindrets/winshift.nvim") -- Used in a Hydra
        use {
            "mrjones2014/smart-splits.nvim", -- Used in a Hydra
            config = function()
                require("smart-splits").setup {}
            end,
        }

        use {
            "anuvyklack/hydra.nvim",
            requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
            config = function()
                require("cfg.hydra")
            end,
        }

        use {
            "folke/twilight.nvim",
            config = function()
                require("twilight").setup {}
            end,
        }
        use {
            "folke/zen-mode.nvim",
            config = function()
                require("zen-mode").setup {}
            end,
        }

        use {
            "declancm/cinnamon.nvim",
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
        }

        use {
            "kevinhwang91/nvim-hlslens",
            config = function()
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
        }

        use {
            "kevinhwang91/nvim-ufo",
            requires = "kevinhwang91/promise-async",
            after = { "nvim-lspconfig" },
            config = function()
                local keymap = vim.keymap
                keymap.amend = require("keymap-amend")
                vim.wo.foldcolumn = "0"
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
        }

        --- }}}
        -- Colorschemes {{{
        use {
            "folke/tokyonight.nvim",
            config = function()
                vim.g.tokyonight_style = "night"
            end,
        }
        use {
            "tiagovla/tokyodark.nvim",
            config = function()
                vim.g.tokyodark_transparent_background = false
            end,
        }
        use {
            "meliora-theme/neovim",
            as = "melioria",
            requires = { "rktjmp/lush.nvim" },
        }
        use {
            "catppuccin/nvim",
            as = "catppuccin",
            config = function()
                vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
                require("catppuccin").setup()
            end
        }
        use("rafamadriz/neon")
        use("mhartington/oceanic-next")
        use {
            "rose-pine/neovim",
            as = "rose-pine",
        }
        use("tanvirtin/monokai.nvim")
        use("nanotech/jellybeans.vim")
        use("ellisonleao/gruvbox.nvim")
        use("ful1e5/onedark.nvim")
        use("sainnhe/everforest")
        use("sainnhe/sonokai")
        use("savq/melange")
        use("projekt0n/github-nvim-theme")
        use("EdenEast/nightfox.nvim")
        use("rebelot/kanagawa.nvim")
        use("shaunsingh/moonlight.nvim")

        -- }}}
        -- Version Control and Git {{{
        use("tpope/vim-fugitive")
        use {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("cfg.gitsigns")
            end,
        }

        use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }

        use {
            "akinsho/git-conflict.nvim",
            tag = "*",
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
        }
        use("junegunn/gv.vim")
        use {
            "TimUntersberger/neogit",
            requires = "nvim-lua/plenary.nvim",
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
        }
        use {
            "f-person/git-blame.nvim",
            config = function()
                vim.g.gitblame_enabled = 0
            end,
        }

        use {
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
        }

        use {
            "lewis6991/satellite.nvim",
            event = "BufRead",
            config = function()
                require("satellite").setup {
                    winblend = 80,
                    handlers = {
                        marks = {
                            enable = true,
                            show_builtins = false,
                        },
                    },
                }
            end,
        }
        --- }}}
        -- Treesitter {{{
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("cfg.treesitter")
            end,
        }
        use {
            "romgrk/nvim-treesitter-context", -- Repo moved to nvim-treesitter
            config = function()
                require("treesitter-context").setup {
                    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                    throttle = true, -- Throttles plugin updates (may improve performance)
                    max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
                    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                        default = {
                            "class",
                            "function",
                            "method",
                            "for",
                            "while",
                            "if",
                            "switch",
                            "case",
                        },
                        lua = {
                            "require",
                        },
                        python = {
                            "def",
                        },
                        latex = {
                            "\\begin",
                            "\\end",
                            "\\section",
                            "\\subsection",
                        },
                        rust = {
                            "mod",
                            "trait",
                            "struct",
                            "match",
                            "impl",
                        },
                    },
                }
            end,
        }
        use("RRethy/nvim-treesitter-textsubjects")
        use("nvim-treesitter/nvim-treesitter-textobjects")
        use("nvim-treesitter/nvim-treesitter-refactor")
        use("nvim-treesitter/playground")
        use { "nvim-treesitter/nvim-treesitter-angular", ft = { "html", "ts" } }

        use {
            "RRethy/nvim-treesitter-endwise",
            event = "InsertEnter",
            config = function()
                require("nvim-treesitter.configs").setup {
                    endwise = {
                        enable = true,
                    },
                }
            end,
        }

        use {
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
        }

        use {
            "windwp/nvim-ts-autotag",
            event = "InsertEnter",
            config = function()
                require("nvim-treesitter.configs").setup {
                    autotag = {
                        enable = true,
                    },
                }
            end,
        }

        use {
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
            wants = { "nvim-treesitter" }, -- or require if not used so far
            after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
        }
        use {
            "danymat/neogen", -- TODO: research
            config = function()
                vim.keymap.set("n", "<Leader>nf", require("neogen").generate, { desc = "document function" })
                vim.keymap.set("n", "<Leader>nc", function()
                    require("neogen").generate { type = "class" }
                end, { desc = "document class" })
                vim.keymap.set("n", "<Leader>nF", function()
                    require("neogen").generate { type = "file" }
                end, { desc = "document file" })
                vim.keymap.set("n", "<Leader>nt", function()
                    require("neogen").generate { type = "type" }
                end, { desc = "document type" })
                require("neogen").setup {
                    enabled = true,
                    snippet_engine = "luasnip",
                }
            end,
            requires = "nvim-treesitter/nvim-treesitter",
        }
        use {
            "ziontee113/syntax-tree-surfer",
            config = function() -- TODO: redo keymaps
                require("cfg.syntax-tree-surfer")
            end,
        }

        use {
            "mizlan/iswap.nvim",
            config = function()
                vim.keymap.set("n", "g,", "<cmd>ISwap<cr>", { desc = "Swap" })
                vim.keymap.set("n", "g.", "<cmd>ISwapWith<cr>", { desc = "Swap with" })
            end,
        }

        -- }}}
        -- LSP + Snippets {{{
        use {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jayp0521/mason-nvim-dap.nvim",
            "neovim/nvim-lspconfig",
        }

        use("weilbith/nvim-code-action-menu")
        use("kosayoda/nvim-lightbulb")
        use("nvim-lua/lsp-status.nvim")
        use {
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            config = function()
                require("lsp_lines").setup()
            end,
        }

        use { "Issafalcon/lsp-overloads.nvim" } -- conflict with lsp_signature?

        use {
            "folke/trouble.nvim",
            config = function()
                vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { desc = "open trouble" })
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
        }
        use {
            "mrbjarksen/neo-tree-diagnostics.nvim",
            requires = "nvim-neo-tree/neo-tree.nvim",
            module = "neo-tree.sources.diagnostics",
            config = function()
                vim.keymap.set(
                    "n",
                    "<leader>xt",
                    "<cmd>Neotree diagnostics toggle bottom<cr>",
                    { desc = "neotree diagnostics" }
                )
            end,
        }

        use("ray-x/lsp_signature.nvim") -- confict with lsp_overload?

        use {
            "andrewferrier/textobj-diagnostic.nvim",
            config = function()
                require("textobj-diagnostic").setup()
            end,
        }

        use {
            "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
            config = function()
                require("toggle_lsp_diagnostics").init()
            end,
        }

        use {
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup {
                    text = {
                        spinner = "dots",
                        done = " ", -- character shown when all tasks are complete
                    },
                }
            end,
        }
        -- use 'simrat39/symbols-outline.nvim'
        use("folke/lsp-colors.nvim")
        use("jose-elias-alvarez/null-ls.nvim")
        use('raddari/last-color.nvim')


        use {
            "johmsalas/text-case.nvim",
            event = "VimEnter",
            config = function()
                require("textcase").setup {}
            end,
        }

        -- use {
        --     "narutoxy/dim.lua",
        --     requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
        --     config = function()
        --         require("dim").setup {}
        --     end,
        -- }

        use {
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig",
            config = function()
                vim.g.navic_silence = true
                require("nvim-navic").setup {
                    depth_limit = 4,
                    depth_limit_indicator = '',
                    separator = " ",
                    icons = {
                        File = " ",
                        Module = " ",
                        Namespace = " ",
                        Package = " ",
                        Class = " ",
                        Method = " ",
                        Property = " ",
                        Field = " ",
                        Constructor = " ",
                        Enum = " ",
                        Interface = " ",
                        Function = " ",
                        Variable = " ",
                        Constant = " ",
                        String = " ",
                        Number = " ",
                        Boolean = " ",
                        Array = " ",
                        Object = " ",
                        Key = " ",
                        Null = " ",
                        EnumMember = " ",
                        Struct = " ",
                        Event = " ",
                        Operator = " ",
                        TypeParameter = " ",
                    },
                }
            end,
        }

        -- use{
        --	   "zbirenbaum/copilot.lua",
        --	   event = {"VimEnter"},
        --	   config = function()
        --		   vim.defer_fn(function()
        --			   require("copilot").setup()
        --		   end, 100)
        --	   end,
        -- }
        -- use {
        --	   "zbirenbaum/copilot-cmp",
        --	   after = { "copilot.lua", "nvim-cmp" },
        -- }
        use {
            "tzachar/cmp-tabnine",
            run = "./install.sh",
            before = "nvim-cmp",
            config = function()
                local tabnine = require("cmp_tabnine")
                tabnine.setup {
                    show_prediction_strength = true,
                }
            end,
        }

        use { "saadparwaiz1/cmp_luasnip" }
        use { "onsails/lspkind-nvim" }
        use {
            "hrsh7th/nvim-cmp", -- TODO: https://github.com/hrsh7th/nvim-cmp/pull/1094
            config = function()
                require("cfg.cmp")
            end,
            requires = {
                "neovim/nvim-lspconfig",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-omni",
                "hrsh7th/cmp-cmdline",
            },
        }

        use {
            "L3MON4D3/LuaSnip",
            config = function()
                require("cfg.luasnip")
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_snipmate").lazy_load()
            end,
            requires = { "rafamadriz/friendly-snippets" },
            event = "InsertEnter",
        }

        -- }}}
        -- Running, Testing and Debugging {{{
        use {
            "stevearc/overseer.nvim",
            config = function()
                require("overseer").setup {
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
        }

        use { -- TODO: Setup mappings
            "rcarriga/neotest",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim",
                "rouge8/neotest-rust",
                "nvim-neotest/neotest-python",
                "haydenmeade/neotest-jest",
            },
            config = function()
                require("cfg.neotest")
            end,
        }

        -- So these three are very much alike
        -- SnipRun: supports more languages, requires rust
        use {
            "michaelb/sniprun",
            run = "bash ./install.sh",
            config = function()
                require("sniprun").setup {
                    display = {
                        "VirtualTextOk",
                        "NvimNotify",
                    },
                }
                vim.keymap.set({ "v", "n" }, "<leader>ee", "<Plug>SnipRun", { desc = "snip run" })
                vim.keymap.set("n", "<leader>e", "<Plug>SnipRunOperator", { desc = "snip run" })
                vim.keymap.set("n", "<leader>eR", "<cmd>SnipReset<cr>", { desc = "snip reset" })
                vim.keymap.set("n", "<leader>el", "<cmd>SnipLive<cr>", { desc = "snip live" })
            end,
        }

        -- Lab: seems promising for TS/JS
        use {
            "0x100101/lab.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            run = "cd js && npm ci",
        }

        -- Conjure: Seems like the biggest project, but mostly lisp and rust for some reason.
        -- use { "Olical/conjure", event = "VimEnter" }

        use("mfussenegger/nvim-dap") -- I really need to get this actually working at some point
        use { "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap" } }
        use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
        use { "mfussenegger/nvim-dap-python", requires = { "mfussenegger/nvim-dap" } }

        -- use {'t-troebst/perfanno.nvim', config = function()
        --	   require('cfg.perfanno')
        -- end
        -- }

        -- }}}
        -- Generic Editor Plugins {{{
        use("tpope/vim-repeat")
        use("tpope/vim-eunuch") -- Basic (Delete, Move, Rename) unix commands
        -- use 'tpope/vim-unimpaired'

        use("markonm/traces.vim") -- Consider relavance

        use {
            "linty-org/readline.nvim",
            config = function()
                local readline = require("readline")
                vim.keymap.set("!", "<M-f>", readline.forward_word)
                vim.keymap.set("!", "<M-b>", readline.backward_word)
                vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
                vim.keymap.set("!", "<C-e>", readline.end_of_line)
                vim.keymap.set("!", "<M-d>", readline.kill_word)
                vim.keymap.set("!", "<C-w>", readline.backward_kill_word)
                -- vim.keymap.set('!', '<C-k>', readline.kill_line)
                vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
            end,
        }

        use("aca/vidir.nvim")
        use {
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup {
                    ignore = "^$",
                }
            end,
        }

        use {
            "monaqa/dial.nvim",
            config = function()
                vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal, { desc = "Dial up" })
                vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal, { desc = "Dial down" })
                vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual, { desc = "Dial up" })
                vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual, { desc = "Dial down" })
                vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual, { desc = "Dial up relative" })
                vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual, { desc = "Dial down relative" })
            end,
        }
        use {
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup {
                    -- Configuration here, or leave empty to use defaults
                }
            end,
        }
        use {
            "andymass/vim-matchup",
            event = "VimEnter",
            config = function()
                vim.g.matchup_surround_enabled = 0
                vim.g.matchup_transmute_enabled = 1
                vim.g.matchup_matchparen_deferred = 1
                vim.g.matchup_override_vimtex = 1
                vim.g.matchup_matchparen_offscreen = { method = "popup" }
            end,
        }
        use {
            "junegunn/vim-easy-align",
            config = function()
                vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { silent = true })
                vim.keymap.set("n", "ga", "<Plug>(EasyAlign)", { silent = true })
                vim.keymap.set("v", "ga", "<Plug>(EasyAlign)", { silent = true })
            end,
        }
        use("Konfekt/vim-sentence-chopper")
        use("flwyd/vim-conjoin")
        use {
            "AckslD/nvim-trevJ.lua",
            config = function()
                require("trevj").setup()
                vim.keymap.set("n", "gS", require("trevj").format_at_cursor, { desc = "Split line" })
            end,
        }

        use {
            "ThePrimeagen/refactoring.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" },
            },
            config = function()
                require("refactoring").setup {}
                -- Used in a Hydra
            end,
        }

        use {
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
        }

        use("lcheylus/overlength.nvim")

        use("reedes/vim-litecorrect") -- autocorrection! Fixes stupid common mistakes
        use("kevinhwang91/nvim-bqf")
        use("nvim-lua/popup.nvim")

        use {
            "luukvbaal/stabilize.nvim",
            config = function()
                require("stabilize").setup()
            end,
        }
        use {
            "folke/todo-comments.nvim",
            event = "BufRead",
            requires = "nvim-lua/plenary.nvim",
            config = function()
                require("todo-comments").setup {}
            end,
        }

        use { "gpanders/editorconfig.nvim" }

        -- }}}
        -- Telescope {{{
        use {
            "nvim-telescope/telescope.nvim",
            requires = { { "nvim-lua/plenary.nvim" } },
            event = "VimEnter",
            config = function()
                require("cfg.telescope")
            end,
        }
        use("willthbill/opener.nvim")
        use("romgrk/fzy-lua-native") -- for use with wilder
        use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
        use("nvim-telescope/telescope-z.nvim")

        use {
            "ziontee113/icon-picker.nvim",
            config = function()
                require("icon-picker")
            end,
        }
        use {
            "max397574/colortils.nvim",
            cmd = "Colortils",
            config = function()
                require("colortils").setup {}
            end,
        }

        -- }}}
        -- Navigation {{{
        use {
            "nacro90/numb.nvim",
            config = function()
                require("numb").setup()
            end,
        }

        use 'chaoren/vim-wordmotion'
        use 'anuvyklack/vim-smartword'

        use {
            "ggandor/leap.nvim",
            config = function()
                vim.api.nvim_set_hl(0, "LeapBackdrop", { fg = "#707070" })
                require("leap").set_default_keymaps()
            end,
        }

        use("farmergreg/vim-lastplace")
        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
                {
                    -- only needed if you want to use the commands with "_with_window_picker" suffix
                    "s1n7ax/nvim-window-picker",
                    tag = "1.*",
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
        }

        use {
            "gbprod/stay-in-place.nvim",
            config = function()
                require("stay-in-place").setup {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                }
            end,
        }
        -- }}}
        -- Language Specific Plugins {{{
        use {
            'krady21/compiler-explorer.nvim', requires = { 'nvim-lua/plenary.nvim' }
        }
        -- ==========  C  ==========
        use("justinmk/vim-syntax-extra")
        use("shirk/vim-gas")
        use("ARM9/arm-syntax-vim")
        -- use {'p00f/clangd_extensions.nvim'}
        -- ======== MARKDOWN ========
        use {
            "gaoDean/autolist.nvim",
            config = function()
                require("autolist").setup {}
            end,
        }
        use {
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
        }
        use {
            "AckslD/nvim-FeMaco.lua",
            config = 'require("femaco").setup()',
        }

        -- ======== ASCIIDOC =======
        use {
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
        }
        -- use {
        --     "nvim-neorg/neorg",
        --     config = function()
        --         require("neorg").setup {
        --             -- Tell Neorg what modules to load
        --             load = {
        --                 ["core.defaults"] = {}, -- Load all the default modules
        --                 ["core.norg.concealer"] = {}, -- Allows for use of icons
        --                 ["core.norg.dirman"] = { -- Manage your directories with Neorg
        --                     config = {
        --                         workspaces = {
        --                             my_workspace = "~/neorg",
        --                         },
        --                     },
        --                 },
        --             },
        --         }
        --     end,
        --     requires = "nvim-lua/plenary.nvim",
        -- }

        -- ==========  fish  ==========
        use { "mtoohey31/cmp-fish", ft = "fish" }

        -- ======== GRAPHVIZ ========
        use { "liuchengxu/graphviz.vim", ft = "dot" }
        -- ======= OCAML ======
        use { "ELLIOTTCABLE/vim-menhir", ft = { "ocaml", "reasonml" } }
        -- ====== LLVM ====
        use { "rhysd/vim-llvm", ft = "llvm" }
        use { "cespare/vim-toml", ft = "toml" }
        -- === LUA ===
        use("folke/lua-dev.nvim")
        -- === kitty ===
        use("fladson/vim-kitty")
        -- === GLSL ===
        use("tikhomirov/vim-glsl")
        -- === rust ===
        use { "simrat39/rust-tools.nvim" }
        use {
            "saecki/crates.nvim",
            requires = { { "nvim-lua/plenary.nvim" } },
            event = { "BufRead Cargo.toml" },
        }
        -- == rest client ===
        use {
            "NTBBloodbath/rest.nvim",
            requires = { "nvim-lua/plenary.nvim" },
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
        }

        -- === Coq ===
        use {
            "whonore/Coqtail",
            ft = "coqt",
            config = function()
                vim.g.coqtail_auto_set_proof_diffs = "on"
                vim.g.coqtail_map_prefix = ","
                vim.g.coctail_imap_prefix = "<C-c>"
            end,
        }
        -- === text ===
        use { "barreiroleo/ltex-extra.nvim" }

        -- TeX
        use {
            "lervag/vimtex",
            config = function()
                vim.g.tex_flavor = "latex"
                vim.g.vimtex_fold_enabled = 1
                vim.g.vimtex_format_enabled = 1
                vim.g.tex_comment_nospell = 1
                vim.g.vimtex_complete_bib = { simple = 1 }
                vim.g.vimtex_skim_sync = 1
                vim.g.vimtex_view_method = "skim"
                vim.g.vimtex_quickfix_mode = 0

                vim.g.vimtex_quickfix_method = "pplatex"
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
        }
        -- Mac OS / Xcode
        use("darfink/vim-plist")
        use {
            "tami5/xbase",
            run = "make install",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
            },
        }
        -- }}}

        if packer_bootstrap then
            require("packer").sync()
        end
    end,
    config = {
        -- Move to lua dir so impatient.nvim can cache it
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
        git = {
            subcommands = {
                update = "pull --progress --rebase=false --allow-unrelated-histories",
            },
        },
    },
}
-- vim: foldmethod=marker
