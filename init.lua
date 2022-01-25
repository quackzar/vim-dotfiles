---@diagnostic disable: lowercase-global
require('impatient')
vim.o.encoding = "utf8"
vim.o.shell = "/bin/zsh"
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.number = true
vim.o.foldenable = true
vim.o.wildmenu = true
vim.o.showmode = false

vim.o.title = true
vim.g.mapleader = ' '

vim.o.virtualedit='block,onemore'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.autoread = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true

vim.wo.signcolumn = 'yes'

vim.o.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.backupdir="/tmp/backup//"
vim.o.directory="/tmp/swap//"
vim.o.undodir="/tmp/undo//"

vim.o.shortmess = "AIOTWaotc"

vim.o.pumblend = 20
vim.o.winblend = 20

vim.o.conceallevel = 2

vim.o.dictionary="/usr/share/dict/words"
vim.o.thesaurus=vim.fn.stdpath('config') .. '/thesaurus/words.txt'

vim.g.loaded_matchit = 1

vim.opt.list = true
vim.opt.listchars:append("tab:▷⋅")
vim.opt.listchars:append("nbsp:␣")
vim.opt.listchars:append("trail:⋅")

vim.opt.fillchars:append("eob: ")
vim.opt.showbreak = "↪"

vim.o.foldexpr = 'foldexpr=nvim_treesitter#foldexpr()'
vim.o.foldmethod = 'expr'


-- some pluginless keymaps
vim.api.nvim_set_keymap('', '<cr>', ':', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'Q', ':close<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gQ', ':bd<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'X', '"_X', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gb', ':bn<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gB', ':bp<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('', '<C-l>', ':noh<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-l>', ':noh<cr>', { noremap = true, silent = true })


vim.g.neomolokai_no_bg = true
vim.g.neomolokai_inv_column = true
vim.cmd('colorscheme tokyonight')
vim.g.python3_host_prog = '/usr/bin/python3'


vim.api.nvim_exec( -- TODO: use api
[[
augroup term_settings
    autocmd TermOpen * startinsert
    autocmd TermOpen * setlocal nonumber
augroup END

augroup easy_close
    autocmd!
    autocmd FileType help,qf nnoremap <buffer> q :q<cr>
    autocmd FileType qf nnoremap <buffer> <Esc> :q<cr>
    autocmd FileType qf setlocal wrap
augroup END

autocmd FileType qf nnoremap <buffer> <C-]> <CR>
augroup improved_autoread
  autocmd!
  autocmd FocusGained * silent! checktime
  autocmd BufEnter    * silent! checktime
  autocmd VimResume   * silent! checktime
  autocmd TermLeave   * silent! checktime
augroup end

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]], false
)

-- setup for ripgrep as grepper
if vim.fn.executable('rg') then
    vim.o.grepprg="rg --vimgrep -g='!*.pdf' -g='!*.eps' --no-heading --smart-case"
    vim.o.grepformat="%f:%l:%c:%m,%f:%l:%m"
end

-- loads all plugins
require('plugins')
require('packer_compiled')

-- load specific configs
require('cfg.dap')
require('cfg.lsp')
require('cfg.tree')

require('windline.bubblegum')


function _sidebar_toggle()
    if not require('nvim-tree.view').win_open() then
        if require('sidebar-nvim.view').win_open() then
            require('bufferline.state').set_offset(0)
        else
            require('bufferline.state').set_offset(31, 'FileTree')
        end
        require('sidebar-nvim').toggle()
    end
end

function _tree_toggle()
    if require('nvim-tree.view').win_open() then
        require('bufferline.state').set_offset(0)
    else
        require('bufferline.state').set_offset(31, 'FileTree')
        if require('sidebar-nvim.view').win_open() then
            require('sidebar-nvim').close()
        end
        require('nvim-tree.lib').refresh_tree()
    end
    require('nvim-tree').toggle()
end

local wk = require('which-key')
wk.register({
    ["]b"] = {"<cmd>BufferLineCycleNext<CR>", "Next Buffer"},
    ["[b"] = {"<cmd>BufferLineCyclePrev<CR>", "Previous Buffer"},
    ["<A-1>"] = {"<Cmd>BufferLineGoToBuffer 1<CR>", "Goto buffer 1"},
    ["<A-2>"] = {"<Cmd>BufferLineGoToBuffer 2<CR>", "Goto buffer 2"},
    ["<A-3>"] = {"<Cmd>BufferLineGoToBuffer 3<CR>", "Goto buffer 3"},
    ["<A-4>"] = {"<Cmd>BufferLineGoToBuffer 4<CR>", "Goto buffer 4"},
    ["<A-5>"] = {"<Cmd>BufferLineGoToBuffer 5<CR>", "Goto buffer 5"},
    ["<A-6>"] = {"<Cmd>BufferLineGoToBuffer 6<CR>", "Goto buffer 6"},
    ["<A-7>"] = {"<Cmd>BufferLineGoToBuffer 7<CR>", "Goto buffer 7"},
    ["<A-8>"] = {"<Cmd>BufferLineGoToBuffer 8<CR>", "Goto buffer 8"},
    ["<A-9>"] = {"<Cmd>BufferLineGoToBuffer 9<CR>", "Goto buffer 9"},
    ["<leader>"] = {
        f = {
            name = "+telescope",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
            g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
            h = { "<cmd>Telescope help_tags<cr>", "Find help" },
        },
        z = {":NvimTreeToggle<cr>", "Toggle File Tree"},
        s = {":SidebarNvimToggle<cr>", "Toggle File Sidebar"},
        S = {":SymbolsOutline<cr>", "Toggle Symbols"},
        x = {
            name = "+trouble",
            x = {"<cmd>Trouble<cr>", "Trouble"},
            w = {"<cmd>Trouble workspace_diagnostics<cr>", "Workspace"},
            d = {"<cmd>Trouble document_diagnostics<cr>", "Document"},
            l = {"<cmd>Trouble loclist<cr>", "Loclist"},
            q = {"<cmd>Trouble quickfix<cr>", "Quickfix"},
        },
        g = {
            name = "+git",
            g = {"<cmd>Neogit<cr>", "Neogit"},
            l = {"<cmd>Neogit log<cr>", "Log"},
            c = {"<cmd>Neogit commit<cr>", "Commit"},
            p = {"<cmd>Neogit pull<cr>", "Pull"},
            P = {"<cmd>Neogit push<cr>", "Push"},
            D = {"<cmd>DiffviewOpen<cr>", "Diffview"},
            H = {"<cmd>DiffviewFileHistory<cr>", "History"},
            b = {"<cmd>Gitsigns blame_line<cr>", "Blame line"},
            B = {"<cmd>GitBlameToggle<cr>", "Toggle Blame"},
            s = {"<cmd>Gitsigns stage_hunk<cr>", "Stage hunk"},
            S = {"<cmd>Gitsigns stage_buffer<cr>", "Stage buffer"},
            u = {"<cmd>Gitsigns undo_stage_buffer<cr>", "Undo stage"},
            r = {"<cmd>Gitsigns reset_hunk<cr>", "Reset hunk"},
        },
        -- TODO: t: add ultest--[[  ]]
    },
    -- TODO: <C-C>: add SnipRun
})

-- vim: foldmethod=marker sw=4
