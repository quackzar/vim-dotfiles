local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function map(...) vim.api.nvim_set_keymap(...) end
local opts = {noremap=true, silent=true}

return require('packer').startup(function()
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
    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-web-nonicons'
    use 'glepnir/dashboard-nvim'
    use 'rcarriga/nvim-notify'
    use 'folke/which-key.nvim'
    use  {'gelguy/wilder.nvim', run = ':UpdateRemotePlugins' }
    use {'folke/twilight.nvim', config = function()
	require("twilight").setup {}
    end}
    use {'folke/neoscroll.nvim', config = function()
	require('neoscroll').setup()
    end}
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
	    map("n", "<leader>gg", "<cmd>Neogit<cr>", opts)
	    map("n", "<leader>gl", "<cmd>Neogit log<cr>", opts)
	    map("n", "<leader>gc", "<cmd>Neogit commit<cr>", opts)
	    require('neogit').setup {}
	end
    }
    use {'ruifm/gitlinker.nvim', config = function()
	require('gitlinker').setup()
    end}
    use 'sindrets/diffview.nvim'
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
	    require("renamer").setup{}
    end}

    use {'ms-jpq/coq_nvim', branch = 'coq',
	config = function()
	    vim.g.coq_settings = {
		 ['auto_start'] = 'shut-up',
		 ['display'] = {
		     ['pum'] = {
			 ['fast_close'] = false
		     }
		},
		['display.icons.mappings'] = {
		    ["Class"]         = " ",
		    ["Color" ]        = " ",
		    ["Constant"]      = " ",
		    ["Constructor"]   = " ",
		    ["Enum"]          = " ",
		    ["EnumMember"]    = " ",
		    ["Event"]         = " ",
		    ["Field"]         = " ",
		    ["File"]          = " ",
		    ["Folder"]        = " ",
		    ["Function"]      = " ",
		    ["Interface"]     = " ",
		    ["Keyword"]       = " ",
		    ["Method"]        = " ",
		    ["Module"]        = " ",
		    ["Operator"]      = " ",
		    ["Property"]      = " ",
		    ["Reference"]     = " ",
		    ["Snippet"]       = " ",
		    ["Struct"]        = " ",
		    ["Text"]          = " ",
		    ["TypeParameter"] = " ",
		    ["Unit"]          = " ",
		    ["Value"]         = " ",
		    ["Variable"]      = " ",
		}
	    }
	end
    } -- 9000+ Snippets
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
    use {'ms-jpq/coq.thirdparty', branch = '3p'}
    use {'github/copilot.vim', config = function()
	vim.g.copilot_no_tab_map = true
	map("i", "<C-J>", [[copilot#Accept('\<CR>')]],
	    { noremap = false, silent = true, expr = true, script = true }
	)
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
	    require('Comment').setup()
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
    use 'kshenoy/vim-signature' -- marks in the sign column
    use 'andymass/vim-visput'
    use 'lukas-reineke/indent-blankline.nvim'
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
    use 'dstein64/nvim-scrollview'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUPDATE' }
    use 'romgrk/fzy-lua-native' -- for use with wilder
    use 'romgrk/nvim-treesitter-context'
    use 'RRethy/nvim-treesitter-textsubjects'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-telescope/telescope-z.nvim'
    use {'luukvbaal/stabilize.nvim', config = function()
	require("stabilize").setup()
    end }
    use {'folke/todo-comments.nvim', config = function()
	require("todo-comments").setup{}
    end}

    use 'Konfekt/FastFold' -- Faster folding
    use 'arecarn/vim-clean-fold'
    -- use 'scr1pt0r/crease.vim'
    -- }}}


    -- navigation.vim {{{
    use {'dstein64/vim-win',
	config = function()
	    vim.api.nvim_set_keymap("n", "<space>w", "<plug>WinWin",
		{silent = true, noremap = false}
	    )end
    }
    use {'nacro90/numb.nvim', config = function()
	require('numb').setup()
    end}
    use 'voldikss/vim-skylight'
    use 'ggandor/lightspeed.nvim'
    use 'arp242/jumpy.vim' -- Maps [[ and ]]
    use 'farmergreg/vim-lastplace'
    use {'kyazdani42/nvim-tree.lua',
	config=function()
	    require('nvim-tree').setup {}
	end}
    use {'ripxorip/aerojump.nvim',  run = ':UpdateRemotePlugins' }
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
    use {'habamax/vim-asciidoctor', ft = 'asciidoctor',
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
end)




-- vim: foldmethod=marker
