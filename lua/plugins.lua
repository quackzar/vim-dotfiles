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
                        windows = true, -- default bindings on <c-w>
                        nav = true, -- misc bindings to work with windows
                        z = true, -- bindings for folds, spelling and others prefixed with z
                        g = true, -- bindings for prefixed with g
                    },
                },
                hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ ", "<Plug>"}, -- hide mapping boilerplate
                operators = { gc = "Comments" },
                key_labels = {
                    -- override the label used to display some keys. It doesn't effect WK in any other way.
                    ["<space>"] = "SPC",
                    ["<cr>"] = "RET",
                    ["<tab>"] = "TAB",
                },
            }
        end
    }

    use  {'gelguy/wilder.nvim', run = ':UpdateRemotePlugins' }
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

    -- use {'karb94/neoscroll.nvim', config = function()
    --     require('neoscroll').setup() -- smooth scrolling
    -- end}
    use {
        'declancm/cinnamon.nvim',
        config = function()
            require('cinnamon').setup({
                extra_keymaps = true,
                extended_keymaps = true,
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
    -- use {"petertriho/nvim-scrollbar",
    --     requires = 'kevinhwang91/nvim-hlslens',
    --     config = function()
    --         require("scrollbar").setup({
    --             folds = 2000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    --             handle = {
    --                 text = " ",
    --                 color = "grey",
    --             },
    --             handlers = {
    --                 diagnostic = true,
    --                 search = true, -- Requires hlslens to be loaded
    --             },
    --         })
    --     end
    -- }

    use { 'bennypowers/nvim-regexplainer',
        config = function() require'regexplainer'.setup()  end,
        requires = {
            'nvim-lua/plenary.nvim',
            'MunifTanjim/nui.nvim',
        } }

    use{ 'anuvyklack/pretty-fold.nvim',
        requires = 'anuvyklack/nvim-keymap-amend', -- only for preview
        config = function()
            vim.opt.fillchars:append('fold: ')
            require('pretty-fold').setup {
                ft_ignore = {'neorg', 'tex'},
                fill_char = ' ',
                sections = {
                    left = {
                        'content',
                    },
                    right = {
                        ' ', 'number_of_folded_lines', ': ', 'percentage', ' ',
                        function(config) return config.fill_char:rep(3) end
                    }
                },
                remove_fold_markers = true,
                keep_indentation = true,
                process_comment_signs = 'spaces',
                add_close_pattern = true,
                matchup_patterns = {
                    { '{', '}' },
                    { '%(', ')' },
                    { '%[', ']' },
                }
            }
            require('pretty-fold').ft_setup('lua', {
                fill_char = ' ',
                matchup_patterns = {
                    { '^%s*do$', 'end' }, -- do ... end blocks
                    { '^%s*if', 'end' },  -- if ... end
                    { '^%s*for', 'end' }, -- for
                    { 'function%s*%(', 'end' }, -- 'function( or 'function (''
                    {  '{', '}' },
                    { '%(', ')' }, -- % to escape lua pattern char
                    { '%[', ']' }, -- % to escape lua pattern char
                },
            })
            require('pretty-fold').ft_setup('cpp', {
                fill_char = ' ',
                process_comment_signs = false,
                comment_signs = {
                    '/**', -- C++ Doxygen comments
                },
                stop_words = {
                    -- ╟─ "*" ──╭───────╮── "@brief" ──╭───────╮──╢
                    --          ╰─ WSP ─╯              ╰─ WSP ─╯
                    '%*%s*@brief%s*',
                },
            })
            require('pretty-fold.preview').setup()
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
    use 'mhartington/oceanic-next'
    use 'rose-pine/neovim'
    use 'tanvirtin/monokai.nvim'
    use 'nanotech/jellybeans.vim'
    use 'morhetz/gruvbox'
    use 'ful1e5/onedark.nvim'
    use 'sainnhe/everforest'
    use 'sainnhe/sonokai'
    use "savq/melange"

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
            require('gitlinker').setup()
        end}
    use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}

    use {'akinsho/git-conflict.nvim', config = function()
        require('git-conflict').setup()
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
                fast_wrap = {
                    map = '<M-e>',
                    chars = { '{', '[', '(', '"', "'" },
                    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                    end_key = '$',
                    keys = 'qwertyuiopzxcvbnmasdfghjkl',
                    check_comma = true,
                    highlight = 'Search',
                    highlight_grey='Comment'
                },

            }
            local Rule = require('nvim-autopairs.rule')
            local npairs = require('nvim-autopairs')
            npairs.add_rule(Rule("\\(","\\)","tex"))
            npairs.add_rule(Rule("\\[","\\]","tex"))
            npairs.add_rule(Rule("\\left","\\right","tex"))
        end
    }

    use 'windwp/nvim-ts-autotag'

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

    use {'neovim/nvim-lspconfig', after = 'nvim-lsp-installer'}
    use 'williamboman/nvim-lsp-installer'
    use 'weilbith/nvim-code-action-menu'
    use 'kosayoda/nvim-lightbulb'
    use 'nvim-lua/lsp-status.nvim'
    use {'Mofiqul/trld.nvim', config = function()
        require('trld').setup({
            auto_cmds = true,
            -- position = 'bottom',
        })
    end}
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
    use {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        "narutoxy/dim.lua",
        requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
        config = function()
            require('dim').setup({})
        end
    }

    -- use { 'RRethy/vim-illuminate' }

    -- use {'github/copilot.vim', config = function()
    --     map("i", "<C-J>", [[copilot#Accept('<CR>')]],
    --         { noremap = false, silent = true, expr = true, script = true }
    --     )
    --     vim.g.copilot_no_tab_map = true
    -- end}
    -- use 'hrsh7th/cmp-copilot'
    use{
        "zbirenbaum/copilot.lua",
        event = {"VimEnter"},
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
    }
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "nvim-cmp" },
    }
    use 'hrsh7th/cmp-omni'
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


    -- use 'rstacruz/vim-closer' -- only closes delimiters on <cr>


    -- }}}
    -- Testing and Debugging {{{

    -- use {'meain/vim-printer'} -- Only debugger you will ever need

    use {'vim-test/vim-test', config =
        function()
            vim.g['test#strategy'] = 'neovim'
        end,
    }
    use { "rcarriga/vim-ultest",
        requires = {"vim-test/vim-test"},
        run = ":UpdateRemotePlugins",
        config = function()
            vim.g.ultest_use_pty = 1
            vim.g.ultest_virtual_text = 0
            vim.g.ultest_pass_sign = ''
            vim.g.ultest_fail_sign = ''
            vim.g.ultest_running_sign = ''
            vim.g.ultest_not_run_sign = ''
            map('', ']t', '<Plug>(ultest-next-fail)', {silent=true})
            map('', '[t', '<Plug>(ultest-prev-fail)', {silent=true})
            map('n', '<leader>ta', '<Plug>(ultest-run-file)', {silent=true})
            map('n', '<leader>tt', '<Plug>(ultest-run-nearest)', {silent=true})
            map('i', '<C-g>tt', '<Plug>(ultest-run-nearest)', {silent=true})
        end
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

    use {'t-troebst/perfanno.nvim', config = function()
        require('cfg.perfanno')
    end
    }

    use 'voldikss/vim-floaterm' -- NOTE: Maybe unused?
    -- use 'samjwill/nvim-unception'-- NOTE: screws with multiple instances
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

    use 'jaxbot/selective-undo.vim'

    use 'aca/vidir.nvim'
    use {'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                ignore = '^$'
            })
        end
    }
    -- use 'tpope/vim-speeddating' -- allows <C-A> <C-X> for dates

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
    use 'tpope/vim-unimpaired'
    use 'AndrewRadev/switch.vim'
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

    use 'mbbill/undotree'
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
    use 'tpope/vim-abolish' -- like substitute
    use 'reedes/vim-litecorrect' -- autocorrection! Fixes stupid common mistakes
    use 'reedes/vim-lexical' -- NOTE: Maybe unused.
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
        end}
    -- use 'arp242/jumpy.vim' -- Maps [[ and ]]
    use 'farmergreg/vim-lastplace'
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function()
            require'nvim-tree'.setup {
                hijack_cursor = true,
                diagnostics = {
                    enable = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    }
                }
            }
            map("n", "<leader>z", ":NvimTreeToggle<CR>", opts)
        end
    }
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
    -- ======== TYPESCRIPT =======
    use {'leafgarland/typescript-vim', ft = 'typescript'}
    -- ======== PYTHON =======
    use {'tmhedberg/SimpylFold', ft = 'python'}
    -- ======== SWIFT ======
    use {'keith/swift.vim', ft = 'swift'}
    -- ======= R =======
    use {'jalvesaq/Nvim-R', ft = 'R'} -- R IDE
    -- ======= OCAML ======
    use {'ELLIOTTCABLE/vim-menhir', ft = {'ocaml', 'reasonml'}}
    -- ====== LLVM ====
    use {'rhysd/vim-llvm', ft = 'llvm'}
    use {'cespare/vim-toml', ft = 'toml'}
    -- === LUA ===
    use 'folke/lua-dev.nvim'
    -- === kitty ===
    use 'fladson/vim-kitty'
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
    use {'KeitaNakamura/tex-conceal.vim', ft = 'tex'}
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
