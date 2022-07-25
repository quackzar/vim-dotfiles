local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then -- check if packer is installed
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- because the other way is way too long
function map(...) vim.api.nvim_set_keymap(...) end
opts = {noremap=true, silent=true}

require('packer').init {
    max_jobs = 50,
}


-- auto compile when this file is modified
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({function()

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'lewis6991/impatient.nvim' -- speed up startup
    use 'nathom/filetype.nvim' -- faster filetype detection

    use 'antoinemadec/FixCursorHold.nvim'

    use({
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup()
        end,
    })

    -- ui.vim {{{
    use {'stevearc/dressing.nvim'}
    use 'windwp/windline.nvim'


    use 'famiu/bufdelete.nvim'
    use {'akinsho/bufferline.nvim', tag = 'v2.*', requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require("cfg.bufferline")
        end
    }

    use {"b0o/incline.nvim",
        config = function()
            require('incline').setup()
        end
    }


    use {'norcalli/nvim-colorizer.lua', config = function()
        require('colorizer').setup()
    end}


    use  'rktjmp/lush.nvim'

    use 'meznaric/conmenu'

    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-web-nonicons'

    use {'goolord/alpha-nvim', config = function()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end}

    use 'rcarriga/nvim-notify'
    use {'folke/which-key.nvim',
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
                hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>"}, -- hide mapping boilerplate
                operators = { gc = "Comments" },
                ignore_missing = true, -- fun if one decides to register everything
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    ["<space>"] = "SPC",
                    ["<cr>"] = "RET",
                    ["<tab>"] = "TAB",
                },
            }
        end
    }

    use 'sindrets/winshift.nvim'
    use {'mrjones2014/smart-splits.nvim',
        config = function()
            require('smart-splits').setup({})
        end
    }

    use { 'anuvyklack/hydra.nvim', 
        requires = 'anuvyklack/keymap-layer.nvim', -- needed only for pink hydras
        config = function()
            require('cfg.hydra')
        end
    }

    use {'folke/twilight.nvim',
        config = function()
            require("twilight").setup {}
        end
    }
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {}
        end
    }

    use {
        'declancm/cinnamon.nvim',
        config = function()
            require('cinnamon').setup({
                extra_keymaps = true,
                extended_keymaps = false,
            })
        end
    }

    use {'kevinhwang91/nvim-hlslens',
        config = function()
            map('', 'n', "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", opts)
            map('', 'N', "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", opts)
            map('', '*', "*<Cmd>lua require('hlslens').start()<CR>", opts)
            map('', '#', "#<Cmd>lua require('hlslens').start()<CR>", opts)
            map('', 'g*', "*<Cmd>lua require('hlslens').start()<CR>", opts)
            map('', 'g#', "#<Cmd>lua require('hlslens').start()<CR>", opts)
        end
    }
    use { 'bennypowers/nvim-regexplainer',
        config = function() require'regexplainer'.setup({})  end,
        requires = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        } }

    use {'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        after = {'nvim-lspconfig'},
        config = function()
            vim.wo.foldcolumn = '0'
            require('ufo').setup({
                {'lsp', 'treesitter'}
            })
        end
    }


    --- }}}
    -- colorschemes {{{
    use {'folke/tokyonight.nvim',
        config = function()
            vim.g.tokyonight_style = 'night'
        end
    }
    use {'tiagovla/tokyodark.nvim',
        config = function()
            vim.g.tokyodark_transparent_background = false
        end
    }
    use {
    'meliora-theme/neovim',
        as = 'melioria',
        requires = {'rktjmp/lush.nvim'}
    }
    use "rafamadriz/neon"
    use 'mhartington/oceanic-next'
    use {
        'rose-pine/neovim',
        as = 'rose-pine'
    }
    use 'tanvirtin/monokai.nvim'
    use 'nanotech/jellybeans.vim'
    use 'ellisonleao/gruvbox.nvim' 
    use 'ful1e5/onedark.nvim'
    use 'sainnhe/everforest'
    use 'sainnhe/sonokai'
    use 'savq/melange'
    use 'projekt0n/github-nvim-theme'
    use "EdenEast/nightfox.nvim"
    use "rebelot/kanagawa.nvim"



    -- }}}
    -- git.vim {{{
    use 'tpope/vim-fugitive'
    use {'lewis6991/gitsigns.nvim',
        config = function() require('cfg.gitsigns') end
    }
    use 'junegunn/gv.vim'
    -- use 'rickhowe/diffchar.vim'
    use {'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('neogit').setup {
                kind = 'split',
                integrations = {
                    diffview = true
                }
            }
            map("n", "<leader>gg", "<cmd>Neogit<cr>", opts)
            map("n", "<leader>gl", "<cmd>Neogit log<cr>", opts)
            map("n", "<leader>gc", "<cmd>Neogit commit<cr>", opts)
        end
    }
    use {'f-person/git-blame.nvim',
        config = function()
            vim.g.gitblame_enabled = 0
        end
    }

    use {'ruifm/gitlinker.nvim',
        config = function()
            require('gitlinker').setup({
                callbacks = {
                    ["github.com"] = require"gitlinker.hosts".get_github_type_url,
                    ["gitlab.com"] = require"gitlinker.hosts".get_gitlab_type_url,
                    ["try.gitea.io"] = require"gitlinker.hosts".get_gitea_type_url,
                    ["codeberg.org"] = require"gitlinker.hosts".get_gitea_type_url,
                    ["bitbucket.org"] = require"gitlinker.hosts".get_bitbucket_type_url,
                    ["try.gogs.io"] = require"gitlinker.hosts".get_gogs_type_url,
                    ["git.sr.ht"] = require"gitlinker.hosts".get_srht_type_url,
                    ["git.launchpad.net"] = require"gitlinker.hosts".get_launchpad_type_url,
                    ["repo.or.cz"] = require"gitlinker.hosts".get_repoorcz_type_url,
                    ["git.kernel.org"] = require"gitlinker.hosts".get_cgit_type_url,
                    ["git.savannah.gnu.org"] = require"gitlinker.hosts".get_cgit_type_url,
                    ["git.fish.princh.com"] = require"gitlinker.hosts".get_gitlab_type_url,
                },
            })
        end
    }

    use {
        'lewis6991/satellite.nvim',
        config = function()
            require('satellite').setup()
        end
    }
    -- use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}

    use {'akinsho/git-conflict.nvim', config = function()
        require('git-conflict').setup({
            default_mappings = true, -- disable buffer local mapping created by this plugin
            disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
            highlights = { -- They must have background color, otherwise the default color will be used
                incoming = 'DiffText',
                current = 'DiffAdd',
            }
        })
    end}
    --- }}}
    -- treesitter {{{
    use {'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('cfg.treesitter') end
    }
    use {'romgrk/nvim-treesitter-context', -- Repo moved to nvim-treesitter
        config = function()
            require'treesitter-context'.setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
                patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                    default = {
                        'class',
                        'function',
                        'method',
                        'for',
                        'while',
                        'if',
                        'switch',
                        'case',
                    },
                    lua = {
                        'require',
                    },
                    python = {
                        'def',
                    },
                    latex = {
                        '\\begin',
                        '\\end',
                        '\\section',
                        '\\subsection'
                    },
                    rust = {
                        'mod',
                        'trait',
                        'struct',
                        'match',
                        'impl',
                    },
                }
            }
        end
    }
    use 'RRethy/nvim-treesitter-textsubjects'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'
    use "nvim-treesitter/nvim-treesitter-angular"


    use {'RRethy/nvim-treesitter-endwise',
        config = function()
            require('nvim-treesitter.configs').setup {
                endwise = {
                    enable = true,
                },
            }
        end
    }

    use {'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup{
                disable_filetype = { "TelescopePrompt" , "guihua", "guihua_rust", "clap_input" },
                check_ts = true,
                enable_check_bracket_line = true,
                fast_wrap = { },
            }
            local Rule = require('nvim-autopairs.rule')
            local npairs = require('nvim-autopairs')
            npairs.add_rule(Rule("\\(","\\)","tex"))
            npairs.add_rule(Rule("\\[","\\]","tex"))
            npairs.add_rule(Rule("\\left","\\right","tex"))
        end
    }

    use {'windwp/nvim-ts-autotag',
                config = function()
                       require'nvim-treesitter.configs'.setup {
                            autotag = {
                                 enable = true,
                               }
                        }
                end
    }

    use {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup {
                tabkey = '<Tab>', -- key to trigger tabout, set to an empty string to disable
                backwards_tabkey = '<S-Tab>', -- key to trigger backwards tabout, set to an empty string to disable
                act_as_tab = true, -- shift content if tab out is not possible
                act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                default_tab = '<C-t>', -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
                default_shift_tab = '<C-d>', -- reverse shift default action,
                enable_backwards = true, -- well ...
                completion = true, -- if the tabkey is used in a completion pum
                tabouts = {
                    {open = "'", close = "'"},
                    {open = '"', close = '"'},
                    {open = '`', close = '`'},
                    {open = '(', close = ')'},
                    {open = '[', close = ']'},
                    {open = '{', close = '}'},
                    {open = '\\(', close = '\\)'},
                    {open = '\\{', close = '\\}'},
                    {open = '\\[', close = '\\]'},
                },
                ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
                exclude = {} -- tabout will ignore these filetypes
            }
        end,
        wants = {'nvim-treesitter'}, -- or require if not used so far
        after = {'nvim-cmp'} -- if a completion plugin is using tabs load it before
    }
    use {
        "danymat/neogen",
        config = function()
            map("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
            map("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
            map("n", "<C-n>", ":lua require('neogen').jump_next()<CR>", opts)
            map("n", "<C-p>", ":lua require('neogen').jump_prev()<CR>", opts)
            require('neogen').setup {
                enabled = true
            }
        end,
        requires = "nvim-treesitter/nvim-treesitter"

    }
    use {"ziontee113/syntax-tree-surfer", config = function()
        require('cfg.syntax-tree-surfer')
    end}

    use {'ray-x/sad.nvim',
        requires = {'ray-x/guihua.lua'},
        config = function()
            require'sad'.setup({
                diff = 'delta', -- you can use `diff`, `diff-so-fancy`
                ls_file = 'fd', -- also git ls_file
                exact = false, -- exact match
                vsplit = true, -- split sad window the screen vertically, when set to number
                -- it is a threadhold when window is larger than the threshold sad will split vertically,
                height_ratio = 0.6, -- height ratio of sad window when split horizontally
                width_ratio = 0.6, -- height ratio of sad window when split vertically

            })
        end}

    -- }}}
    -- LSP {{{
    use 'skywind3000/asyncrun.vim'
    use 'skywind3000/asynctasks.vim'

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use 'weilbith/nvim-code-action-menu'
    use 'kosayoda/nvim-lightbulb'
    use 'nvim-lua/lsp-status.nvim'
    
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    }

    use { 'Issafalcon/lsp-overloads.nvim'}
    use {'folke/trouble.nvim', config = function()
        map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
        map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
        map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
        map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
        map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
        map("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)
        require("trouble").setup {
            use_diagnostic_signs = true,
        }
    end}
    use 'ray-x/lsp_signature.nvim'

    use({
        "andrewferrier/textobj-diagnostic.nvim",
        config = function()
            require("textobj-diagnostic").setup()
        end,
    })

    use {'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim', config = function()
        require('toggle_lsp_diagnostics').init()
    end}

    use {'j-hui/fidget.nvim', config = function()
        require('fidget').setup{
            text = {
                spinner = "triangle",         -- animation shown when tasks are ongoing
            },
        }
    end}
    -- use 'simrat39/symbols-outline.nvim'
    use 'folke/lsp-colors.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'

    use { "johmsalas/text-case.nvim",
        config = function()
            require('textcase').setup {}
        end
    }

    use {
        "narutoxy/dim.lua",
        requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
        config = function()
            require('dim').setup({})
        end
    }

    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
        config = function()
            vim.g.navic_silence = true
            require('nvim-navic').setup({
                separator = " ",
                icons = {
                    File = ' ',
                    Module = ' ',
                    Namespace = ' ',
                    Package = ' ',
                    Class = ' ',
                    Method = ' ',
                    Property = ' ',
                    Field = ' ',
                    Constructor = ' ',
                    Enum = ' ',
                    Interface = ' ',
                    Function = ' ',
                    Variable = ' ',
                    Constant = ' ',
                    String = ' ',
                    Number = ' ',
                    Boolean = ' ',
                    Array = ' ',
                    Object = ' ',
                    Key = ' ',
                    Null = ' ',
                    EnumMember = ' ',
                    Struct = ' ',
                    Event = ' ',
                    Operator = ' ',
                    TypeParameter = ' '
                }
            })
        end
    }

    -- use{
    --     "zbirenbaum/copilot.lua",
    --     event = {"VimEnter"},
    --     config = function()
    --         vim.defer_fn(function()
    --             require("copilot").setup()
    --         end, 100)
    --     end,
    -- }
    -- use {
    --     "zbirenbaum/copilot-cmp",
    --     after = { "copilot.lua", "nvim-cmp" },
    -- }
    use 'hrsh7th/cmp-omni'
    use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}

    use { 'saadparwaiz1/cmp_luasnip' }
    use 'onsails/lspkind-nvim'
    use {'hrsh7th/nvim-cmp', config = function()
        require('cfg.cmp')
    end,
        requires = {
            'neovim/nvim-lspconfig',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
    }

    use {'L3MON4D3/LuaSnip',
        config = function()
            require('cfg.luasnip')
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end,
        requires = {'rafamadriz/friendly-snippets'},
    }

    use {'sidebar-nvim/sections-dap'}
    use {'sidebar-nvim/sidebar.nvim',
        config = function()
            require('cfg.sidebar')
        end
    }

    -- }}}
    -- Testing and Debugging {{{

    use { -- TODO: Wait upon more support for neotest
        "rcarriga/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim"
        }
    }

    use { 'michaelb/sniprun', run = 'bash ./install.sh',
        config = function()
            require'sniprun'.setup({
                display = {
                    "VirtualTextOk",
                    "NvimNotify"
                }
            })
            map("n", "<C-c>", "<Plug>SnipRunOperator", {silent=true})
            map("n", "<C-c><C-c>", "<Plug>SnipRun", {silent=true})
            map("v", "<C-c>", "<Plug>SnipRun", {silent=true})
        end
    }


    use 'mfussenegger/nvim-dap'
    use {'theHamsta/nvim-dap-virtual-text', requires = {"mfussenegger/nvim-dap"} }
    use {'rcarriga/nvim-dap-ui', requires = {"mfussenegger/nvim-dap"} }
    use {'Pocco81/DAPInstall.nvim', requires = {"mfussenegger/nvim-dap"} }
    use {'mfussenegger/nvim-dap-python', requires = {"mfussenegger/nvim-dap"} }

    -- use {'t-troebst/perfanno.nvim', config = function()
    --     require('cfg.perfanno')
    -- end
    -- }

    use 'voldikss/vim-floaterm' -- NOTE: Maybe unused?
    -- }}}
    -- editor.vim {{{
    use 'duggiefresh/vim-easydir'

    use {'linty-org/readline.nvim',
        config = function()
            local readline = require 'readline'
            vim.keymap.set('!', '<M-f>', readline.forward_word)
            vim.keymap.set('!', '<M-b>', readline.backward_word)
            vim.keymap.set('!', '<C-a>', readline.beginning_of_line)
            vim.keymap.set('!', '<C-e>', readline.end_of_line)
            vim.keymap.set('!', '<M-d>', readline.kill_word)
            vim.keymap.set('!', '<C-w>', readline.backward_kill_word)
            -- vim.keymap.set('!', '<C-k>', readline.kill_line)
            vim.keymap.set('!', '<C-u>', readline.backward_kill_line)
        end
    }

    use 'aca/vidir.nvim'
    use {'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ignore = '^$'
            })
        end
    }

    use {'monaqa/dial.nvim',
        config = function()
            vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), {noremap = true})
            vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), {noremap = true})
            vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), {noremap = true})
            vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), {noremap = true})
            vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), {noremap = true})
            vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), {noremap = true})
        end
    }
    use 'tpope/vim-repeat' -- Improves dot
    use 'tpope/vim-eunuch' -- Basic (Delete, Move, Rename) unix commands
    use 'tpope/vim-unimpaired' -- TODO: Reconsider some mappings
    use 'AndrewRadev/switch.vim' -- TODO: Unused
    use 'machakann/vim-sandwich' -- Surround replacment, with previews and stuff
    use 'wellle/targets.vim'
    use {'andymass/vim-matchup', event = 'VimEnter',
        config = function()
            vim.g.matchup_surround_enabled = 0
            vim.g.matchup_transmute_enabled = 1
            vim.g.matchup_matchparen_deferred = 1
            vim.g.matchup_override_vimtex = 1
            vim.g.matchup_matchparen_offscreen = {method = 'popup'}
        end}
    use {'junegunn/vim-easy-align',
        config = function()
            map('x', 'ga', '<Plug>(EasyAlign)', {silent=true})
            map('n', 'ga', '<Plug>(EasyAlign)', {silent=true})
            map('v', 'ga', '<Plug>(EasyAlign)', {silent=true})
        end
    }
    use 'markonm/traces.vim'
    use 'Konfekt/vim-sentence-chopper'
    use 'AndrewRadev/splitjoin.vim' -- NOTE: Consider lua + treesitter version
    use {'flwyd/vim-conjoin', after = 'splitjoin.vim'}

    -- use 'kshenoy/vim-signature' -- marks in the sign column
    use {'lukas-reineke/indent-blankline.nvim',
        config = function()
            vim.g.indent_blankline_char = '▏'
            vim.g.indent_blankline_filetype_exclude = { 'help', 'packer', 'undotree', 'text', 'dashboard', 'man' }
            vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
            vim.g.indent_blankline_show_trailing_blankline_indent = true
            vim.g.indent_blankline_show_first_indent_level = false
            require("indent_blankline").setup {
                -- for example, context is off by default, use this to turn it on
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,

            }
        end
    }
    use 'reedes/vim-litecorrect' -- autocorrection! Fixes stupid common mistakes
    use 'kevinhwang91/nvim-bqf'
    use 'nvim-lua/popup.nvim'

    use {'luukvbaal/stabilize.nvim', config = function()
        require("stabilize").setup()
    end }
    use {'folke/todo-comments.nvim',
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup{}
        end}

    use {
        'pianocomposer321/yabs.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('cfg.yabs')
        end
    }

    use {'editorconfig/editorconfig-vim'}

    -- }}}
    -- Telescope {{{
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('cfg.telescope')
        end
    }
    use "willthbill/opener.nvim"
    use 'romgrk/fzy-lua-native' -- for use with wilder
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope-z.nvim'

    use({
        "ziontee113/icon-picker.nvim",
        config = function()
            require("icon-picker")
        end,
    })
    use {
        "max397574/colortils.nvim",
        cmd = "Colortils",
        config = function()
            require("colortils").setup()
        end,
    }

    -- }}}
    -- navigation.vim {{{
    use {'dstein64/vim-win',
        config = function()
            map("n", "<space>w", "<plug>WinWin", {silent = true, noremap = false})
        end
    }
    use {'nacro90/numb.nvim', config = function()
        require('numb').setup()
    end}
    use {'ggandor/lightspeed.nvim',
        config = function()
            vim.g.lightspeed_no_default_keymaps = true
            require('lightspeed').setup({})
            map("n", "L", "<Plug>Lightspeed_s", {silent = true})
            map("n", "H", "<Plug>Lightspeed_S", {silent = true})
            map("n", "f", "<Plug>Lightspeed_f", {silent = true})
            map("n", "F", "<Plug>Lightspeed_F", {silent = true})
            map("n", "t", "<Plug>Lightspeed_t", {silent = true})
            map("n", "T", "<Plug>Lightspeed_T", {silent = true})
            map("o", "x", "<Plug>Lightspeed_x", {silent = true})
            map("o", "X", "<Plug>Lightspeed_X", {silent = true})
            map("n", "S", "<Plug>Lightspeed_omni_s", {silent = true})
        end}
    -- use 'arp242/jumpy.vim' -- Maps [[ and ]]
    use 'farmergreg/vim-lastplace'
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                tag = "1.*",
                config = function()
                    require'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal' },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end,
            }
        }
    }
    -- }}}
    -- languages.vim {{{
    -- ==========  C  ==========
    use 'justinmk/vim-syntax-extra'
    use 'shirk/vim-gas'
    use 'ARM9/arm-syntax-vim'
    -- use {'p00f/clangd_extensions.nvim'}
    -- ======== MARKDOWN ========
    use {'plasticboy/vim-markdown', ft = 'markdown',
        config = function()
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_toml_frontmatter = 1
            vim.g.vim_markdown_json_frontmatter = 1
            vim.g.vim_markdown_math = 1
            vim.g.vim_markdown_strikethrough = 1
            -- vim.g.vim_markdown_fenced_languages = {'go', 'c', 'python', 'tex', 'bash=sh', 'sh', 'fish', 'javascript', 'viml=vim', 'html'}
        end
    }
    use {'dhruvasagar/vim-table-mode'}
    -- ======== ASCIIDOC =======
    use {'habamax/vim-asciidoctor', ft = 'asciidoc',
        config = function()
            vim.g.asciidoctor_fenced_languages = {
                'go', 'c', 'python', 'tex', 'sh', 'fish', 'javascript', 'vim', 'html', 'java'
            }
            vim.g.asciidoctor_syntax_conceal = 1
            vim.g.asciidoctor_folding = 1
        end
    }
    use {
        "nvim-neorg/neorg",
        config = function()
            require('neorg').setup {
                -- Tell Neorg what modules to load
                load = {
                    ["core.defaults"] = {}, -- Load all the default modules
                    ["core.norg.concealer"] = {}, -- Allows for use of icons
                    ["core.norg.dirman"] = { -- Manage your directories with Neorg
                        config = {
                            workspaces = {
                                my_workspace = "~/neorg"
                            }
                        }
                    }
                },
            }
        end,
        requires = "nvim-lua/plenary.nvim"
    }

    -- ==========  fish  ==========
    use({ "mtoohey31/cmp-fish", ft = "fish" })

    -- ======== GRAPHVIZ ========
    use {'liuchengxu/graphviz.vim', ft = 'dot'}
    -- ======== PYTHON =======
    use {'tmhedberg/SimpylFold', ft = 'python'}
    -- ======= OCAML ======
    use {'ELLIOTTCABLE/vim-menhir', ft = {'ocaml', 'reasonml'}}
    -- ====== LLVM ====
    use {'rhysd/vim-llvm', ft = 'llvm'}
    use {'cespare/vim-toml', ft = 'toml'}
    -- === LUA ===
    use 'folke/lua-dev.nvim'
    -- === kitty ===
    use 'fladson/vim-kitty'
    -- === GLSL ===
    use 'tikhomirov/vim-glsl'
    -- === rust ===
    use {'simrat39/rust-tools.nvim'}
    use {
        'saecki/crates.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        event = { "BufRead Cargo.toml" },
    }
    -- == rest client ===
    use {
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("rest-nvim").setup({
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
                env_file = '.env',
                custom_dynamic_variables = {},
                yank_dry_run = true,
            })
        end
    }

    -- === Coq ===
    use {'whonore/Coqtail', ft = 'coqt',
        config = function()
            vim.g.coqtail_auto_set_proof_diffs = 'on'
            vim.g.coqtail_map_prefix = ','
            vim.g.coctail_imap_prefix = '<C-c>'
        end
    }
    -- === text ===
    -- TeX
    use {'lervag/vimtex',
        config = function()
            vim.g.tex_flavor = 'latex'
            vim.g.vimtex_fold_enabled = 1
            vim.g.vimtex_format_enabled = 1
            vim.g.tex_comment_nospell = 1
            vim.g.vimtex_complete_bib = { simple = 1 }
            vim.g.vimtex_skim_sync = 1
            vim.g.vimtex_view_method = 'skim'
            vim.g.vimtex_quickfix_mode = 0

            vim.g.vimtex_quickfix_method = 'pplatex'
            vim.g.vimtex_compiler_latexmk = {
                options = {
                    '-pdf',
                    '-shell-escape',
                    '-verbose',
                    '-synctex=1',
                    '-interaction=nonstopmode',
                },
                build_dir = 'out',
            }

            vim.g.vimtex_syntax_custom_cmds = {
                { name = 'vct', mathmode = 1, argstyle = 'bold' },
                { name = 'R', mathmode = 1, concealchar = 'ℝ' },
                { name = 'C', mathmode = 1, concealchar = 'ℂ' },
                { name = 'Z', mathmode = 1, concealchar = 'ℤ' },
                { name = 'N', mathmode = 1, concealchar = 'ℕ' },
                { name = 'mathnote', mathmode = 1, nextgroup = 'texMathTextArg' },
                { name = 'nospell', argspell = 0 },
            }
        end
    }
    -- Mac OS / Xcode
    use {
        'tami5/xbase',
        run = 'make install',
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    }
    -- }}}

    if packer_bootstrap then
        require('packer').sync()
    end
end, config = {
        -- Move to lua dir so impatient.nvim can cache it
        compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
        git = {
            subcommands ={
                update = 'pull --progress --rebase=false --allow-unrelated-histories'
            }
        }
    }
})
-- vim: foldmethod=marker
