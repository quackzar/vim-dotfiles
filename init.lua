vim.opt.encoding = "utf8"
vim.opt.shell = "/bin/zsh"
vim.g.mapleader = ' '
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.wrap = false
vim.opt.number = true
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.wildmenu = true

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- ui.vim {{{
    use 'norcalli/nvim-colorizer.lua'
    use 'kyazdani42/nvim-web-devicons'
    use 'yamatsum/nvim-web-nonicons'
    use 'glepnir/dashboard-nvim'
    use 'rcarriga/nvim-notify'
    use 'folke/which-key.nvim'
    use  {'gelguy/wilder.nvim', run = ':UpdateRemotePlugins' }
    use 'folke/twilight.nvim'
    use 'folke/neoscroll.nvim'
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
    use 'TimUntersberger/neogit'
    use 'ruifm/gitlinker.nvim'
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
    use 'folke/trouble.nvim'
    use 'ray-x/lsp_signature.nvim'
    use 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
    use 'simrat39/symbols-outline.nvim'
    use 'folke/lsp-colors.nvim'
    use 'jose-elias-alvarez/null-ls.nvim'
    use {'filipdutescu/renamer.nvim',  branch = 'master' }
    use {'ms-jpq/coq_nvim', branch = 'coq'} -- 9000+ Snippets
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
    use {'ms-jpq/coq.thirdparty', branch = '3p'}
    use 'github/copilot.vim'
    use 'honza/vim-snippets'
    use 'vim-test/vim-test'
    use {'rcarriga/vim-ultest',  run = ':UpdateRemotePlugins' }
    use 'mfussenegger/nvim-dap'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'rcarriga/nvim-dap-ui'
    use 'Pocco81/DAPInstall.nvim'
    use 'mfussenegger/nvim-dap-python'
    use 'voldikss/vim-floaterm'
    -- }}}


    -- editor.vim {{{
    use 'duggiefresh/vim-easydir'
    use 'aca/vidir.nvim'
    use 'numToStr/Comment.nvim'
    use 'tpope/vim-speeddating' -- allows <C-A> <C-X> for dates
    use 'tpope/vim-repeat' -- Improves dot
    use 'tpope/vim-eunuch' -- Basic (Delete, Move, Rename) unix commands
    use 'tpope/vim-unimpaired'
    use 'AndrewRadev/switch.vim'
    use 'j5shi/CommandlineComplete.vim'
    use 'machakann/vim-sandwich' -- Surround replacment, with previews and stuff
    use 'wellle/targets.vim'
    use 'andymass/vim-matchup'
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
    use 'nvim-telescope/telescope.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'dstein64/nvim-scrollview'
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUPDATE' }
    use 'romgrk/fzy-lua-native' -- for use with wilder
    use 'romgrk/nvim-treesitter-context'
    use 'RRethy/nvim-treesitter-textsubjects'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'nvim-telescope/telescope-z.nvim'
    use 'luukvbaal/stabilize.nvim'
    use 'folke/todo-comments.nvim'

    use 'Konfekt/FastFold' -- Faster folding
    use 'arecarn/vim-clean-fold'
    -- use 'scr1pt0r/crease.vim'
    -- }}}


    -- navigation.vim {{{
    use 'dstein64/vim-win'
    use 'nacro90/numb.nvim'
    use 'voldikss/vim-skylight'
    use 'ggandor/lightspeed.nvim'
    use 'arp242/jumpy.vim' -- Maps [[ and ]]
    use 'farmergreg/vim-lastplace'
    use 'kyazdani42/nvim-tree.lua'
    use {'ripxorip/aerojump.nvim',  run = ':UpdateRemotePlugins' }
    -- languages.vim {{{
    -- ==========  C  ==========
    use 'justinmk/vim-syntax-extra'
    use 'shirk/vim-gas'
    use 'ARM9/arm-syntax-vim'
    -- ======== MARKDOWN ========
    use {'plasticboy/vim-markdown', ft = 'markdown'}
    -- ======== ASCIIDOC =======
    use {'habamax/vim-asciidoctor', ft = 'asciidoctor'}
    -- ======== GRAPHVIZ ========
    use {'liuchengxu/graphviz.vim', ft = 'dot'}
    -- ======== TYPESCRIPT =======
    use {'leafgarland/typescript-vim', ft = 'typescript'}
    -- ======== PYTHON =======
    use {'tmhedberg/SimpylFold', ft = 'python'}
    use 'jpalardy/vim-slime'
    use {'hanschen/vim-ipython-cell',  ft = 'python' }
    -- ======== SWIFT ======
    use {'keith/swift.vim', ft = 'swift'}
    use {'kentaroi/ultisnips-swift', ft = 'swift'}
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
    use 'simrat39/rust-tools.nvim'
    -- === Coq ===
    use {'whonore/Coqtail', ft = 'coq'}
    -- === text ===
    use 'brymer-meneses/grammar-guard.nvim'

    -- TeX
    use {'lervag/vimtex', ft = 'tex'}
    use {'KeitaNakamura/tex-conceal.vim', ft = 'tex'}
    -- }}}

    if packer_bootstrap then
        require('packer').sync()
    end
end)
