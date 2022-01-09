local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
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

    -- ui.vim {{{
    use 'windwp/windline.nvim'
    use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function()
        map('n', '<A-,>', ':BufferPrevious<CR>', opts)
        map('n', '<A-.>', ':BufferNext<CR>', opts)
        map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
        map('n', '<A->>', ':BufferMoveNext<CR>', opts)
        map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
        map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
        map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
        map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
        map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
        map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
        map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
        map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
        map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
        map('n', '<A-0>', ':BufferLast<CR>', opts)
        map('n', '<A-c>', ':BufferClose<CR>', opts)
        map('n', '<C-p>', ':BufferPick<CR>', opts)
        map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
        map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
        map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)
    end
    }
    use {'norcalli/nvim-colorizer.lua', config = function()
        require('colorizer').setup()
    end}

    -- use({
    --     "narutoxy/themer.lua",
    --     branch = "dev", -- I recommend dev branch because it has more plugin support currently
    --     module = "themer",  -- load it as fast as possible
    --     config = function()
    --         require("themer")({colorscheme = "rose_pine"})
    --     end,
    -- })
    use  'rktjmp/lush.nvim'

    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-web-nonicons'
    use 'glepnir/dashboard-nvim'
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
    use {'folke/twilight.nvim', config = function()
        require("twilight").setup {}
    end}
    use {'karb94/neoscroll.nvim', config = function()
        require('neoscroll').setup() -- smooth scrolling
    end}

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
    use {"petertriho/nvim-scrollbar",
        requires = 'kevinhwang91/nvim-hlslens',
        config = function()
            require("scrollbar").setup({
                handle = {
                    text = " ",
                    color = "grey",
                },
                handlers = {
                    diagnostic = true,
                    search = true, -- Requires hlslens to be loaded
                },
            })
        end
    }

    use 'Konfekt/FastFold' -- Faster folding
    use{ 'anuvyklack/pretty-fold.nvim',
        config = function()
            require('pretty-fold').setup {
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
                comment_signs = 'spaces',
                stop_words = {
                    '@brief%s*', -- (for cpp) Remove '@brief' and all spaces after.
                },
                add_close_pattern = true,
                matchup_patterns = {
                    { '{', '}' },
                    { '%(', ')' }, -- % to escape lua pattern char
                    { '%[', ']' }, -- % to escape lua pattern char
                    { 'if%s', 'end' },
                    { 'do%s', 'end' },
                    { 'for%s', 'end' },
                },
            }
            require('pretty-fold.preview').setup_keybinding()
        end
    }

    use {
        'nyngwang/NeoZoom.lua'
    }

    -- colorschemes
    use 'RRethy/nvim-base16'
    use 'folke/tokyonight.nvim'
    use 'tiagovla/tokyodark.nvim'
    use 'mhartington/oceanic-next'
    use 'rose-pine/neovim'
    use 'tanvirtin/monokai.nvim'
    use 'nanotech/jellybeans.vim'
    use 'morhetz/gruvbox'
    -- }}}
    -- git.vim {{{
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'
    use 'junegunn/gv.vim'
    use 'rickhowe/diffchar.vim'
    use {'TimUntersberger/neogit',
    config = function()
        require('neogit').setup {}
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

    use {'ruifm/gitlinker.nvim', config = function()
    require('gitlinker').setup()
    end}
    use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}
    --- }}}
    -- ide.vim {{{
    use 'skywind3000/asyncrun.vim'
    use 'skywind3000/asynctasks.vim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'weilbith/nvim-code-action-menu'
    use 'kosayoda/nvim-lightbulb'
    use 'nvim-lua/lsp-status.nvim'
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
    use 'simrat39/symbols-outline.nvim'
    use 'folke/lsp-colors.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use {'filipdutescu/renamer.nvim',  branch = 'master',
    config = function()
        require("renamer").setup()
    end}

    use {'ms-jpq/coq_nvim', branch = 'coq',
    config = function()
        vim.g.coq_settings = {
             auto_start = 'shut-up',
             display = {
                    pum = {
                    fast_close = false
                 }
            },
            ["display.icons.mappings"] = {
                Class         = " ",
                Color         = " ",
                Constant      = " ",
                Constructor   = " ",
                Enum          = " ",
                EnumMember    = " ",
                Event         = " ",
                Field         = " ",
                File          = " ",
                Folder        = " ",
                Function      = " ",
                Interface     = " ",
                Keyword       = " ",
                Method        = " ",
                Module        = " ",
                Operator      = " ",
                Property      = " ",
                Reference     = " ",
                Snippet       = " ",
                Struct        = " ",
                Text          = " ",
                TypeParameter = " ",
                Unit          = " ",
                Value         = " ",
                Variable      = " ",
            }
        }
        local coq = require ("coq")
    end
    } -- 9000+ Snippets
    use {'ms-jpq/coq.artifacts',
        branch = 'artifacts',
        config = function()
            require("coq_3p") {
                { src = "copilot", short_name = "COP", accept_key = "<c-f>" },
                { src = "vimtex", short_name = "vTEX" },
                { src = "nvimlua", short_name = "nLUA", conf_only = false },
                { src = "dap" },
            }
        end
    }
    use {'ms-jpq/coq.thirdparty', branch = '3p'}
    use {'github/copilot.vim', config = function()
        map("i", "<C-J>", [[copilot#Accept('<CR>')]],
            { noremap = false, silent = true, expr = true, script = true }
        )
        vim.g.copilot_no_tab_map = true
    end}
    use 'honza/vim-snippets'

    use 'vim-test/vim-test'
    use { "rcarriga/vim-ultest", requires = {"vim-test/vim-test"}, run = ":UpdateRemotePlugins" }

    use 'mfussenegger/nvim-dap'
    use {'theHamsta/nvim-dap-virtual-text', requires = {"mfussenegger/nvim-dap"} }
    use { 'rcarriga/nvim-dap-ui', requires = {"mfussenegger/nvim-dap"} }
    use {'Pocco81/DAPInstall.nvim', requires = {"mfussenegger/nvim-dap"} }
    use {'mfussenegger/nvim-dap-python', requires = {"mfussenegger/nvim-dap"} }

    use 'voldikss/vim-floaterm'
    -- }}}
    -- editor.vim {{{
    use 'duggiefresh/vim-easydir'
    use 'aca/vidir.nvim'
    use {'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
                ignore = '^$'
            })
    end
    }
    use 'tpope/vim-speeddating' -- allows <C-A> <C-X> for dates
    use 'tpope/vim-repeat' -- Improves dot
    use 'tpope/vim-eunuch' -- Basic (Delete, Move, Rename) unix commands
    use 'tpope/vim-unimpaired'
    use 'AndrewRadev/switch.vim'
    use 'j5shi/CommandlineComplete.vim'
    use 'machakann/vim-sandwich' -- Surround replacment, with previews and stuff
    use 'wellle/targets.vim'
    use {'andymass/vim-matchup', event = 'VimEnter',
    config = function()
        vim. g.loaded_matchit = 1
        vim.g.matchup_surround_enabled = 0
        vim.g.matchup_transmute_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_override_vimtex = 1
        vim.g.matchup_matchparen_offscreen = {method = 'popup'}
    end
    }
    use 'junegunn/vim-easy-align'
    use 'Konfekt/vim-sentence-chopper'
    use 'markonm/traces.vim'
    use 'AndrewRadev/splitjoin.vim'
    use 'flwyd/vim-conjoin'
    use 'mbbill/undotree'
    -- use 'kshenoy/vim-signature' -- marks in the sign column
    use 'andymass/vim-visput'
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
    use 'reedes/vim-lexical'
    use 'kevinhwang91/nvim-bqf'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUPDATE' }
    use 'romgrk/fzy-lua-native' -- for use with wilder
    use {'romgrk/nvim-treesitter-context',
        config = function()
            require'treesitter-context'.setup{
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                throttle = true, -- Throttles plugin updates (may improve performance)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
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
                }
            }
        end
    }
    use 'RRethy/nvim-treesitter-textsubjects'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-telescope/telescope-z.nvim'
    use {'luukvbaal/stabilize.nvim', config = function()
        require("stabilize").setup()
    end }
    use {'folke/todo-comments.nvim', config = function()
        require("todo-comments").setup{}
    end}

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
            map("n", "+", "<Plug>Lightspeed_s", {silent = true})
            map("n", "-", "<Plug>Lightspeed_S", {silent = true})
            map("n", "f", "<Plug>Lightspeed_f", {silent = true})
            map("n", "F", "<Plug>Lightspeed_F", {silent = true})
            map("n", "t", "<Plug>Lightspeed_t", {silent = true})
            map("n", "T", "<Plug>Lightspeed_T", {silent = true})
        end}
    use 'arp242/jumpy.vim' -- Maps [[ and ]]
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
    use {'ripxorip/aerojump.nvim',  run = ':UpdateRemotePlugins',
    config = function()
        map("n", "<leader>/", ":AerojumpSpace<CR>", {noremap = false})
        map("n", "<leader>?", ":AerojumpBolt<CR>", {noremap = false})
    end
    }
    -- }}}
    -- languages.vim {{{
    -- ==========  C  ==========
    use 'justinmk/vim-syntax-extra'
    use 'shirk/vim-gas'
    use 'ARM9/arm-syntax-vim'
    -- ======== MARKDOWN ========
    use {'plasticboy/vim-markdown', ft = 'markdown',
    config = function()
        vim.g.vim_markdown_frontmatter = 1
        vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_toml_frontmatter = 1
        vim.g.vim_markdown_json_frontmatter = 1
        vim.g.vim_markdown_math = 1
        vim.g.vim_markdown_strikethrough = 1
        vim.g.vim_markdown_fenced_languages = {'go', 'c', 'python', 'tex', 'bash=sh', 'sh', 'fish', 'javascript', 'viml=vim', 'html'}
    end
    }
    -- ======== ASCIIDOC =======
    use {'habamax/vim-asciidoctor', ft = 'asciidoc',
    config = function()
        vim.g.asciidoctor_fenced_languages = {
        'go',
        'c',
        'python',
        'tex',
        'sh',
        'fish',
        'javascript',
        'vim',
        'html',
        'java',
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
    -- === kitty ===
    use 'fladson/vim-kitty'
    -- === rust ===
    use {'simrat39/rust-tools.nvim', config = function()
    require('rust-tools').setup({})
    end}
    -- === Coq ===
    use {'whonore/Coqtail', ft = 'coq',
    config = function()
        vim.g.coqtail_auto_set_proof_diffs = 'on'
        vim.g.coqtail_map_prefix = ','
        vim.g.coctail_imap_prefix = '<C-c>'
    end
    }
    -- === text ===
    use 'brymer-meneses/grammar-guard.nvim'

    -- TeX
    use {'lervag/vimtex', ft = 'tex',
    config = function()
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
    end
    }
    use {'KeitaNakamura/tex-conceal.vim', ft = 'tex'}
    -- }}}

    if packer_bootstrap then
        require('packer').sync()
    end
end, config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
  }
})
-- vim: foldmethod=marker
