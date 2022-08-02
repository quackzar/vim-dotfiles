---@diagnostic disable: lowercase-global
local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end
vim.opt.shadafile = "NONE"

prequire('impatient')

vim.o.shell = "/bin/zsh"
vim.o.termguicolors = true
vim.o.guifont = "JetBrainsMono Nerd Font:h11"
vim.o.guioptions = 'ad'
vim.g.neovide_transparency=0.8
vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.linebreak = true
vim.o.number = true
vim.o.wildmenu = true
vim.o.showmode = false
vim.o.breakindent = true

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
vim.o.guicursor = table.concat({
      [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
      [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
      [[sm:block-blinkwait175-blinkoff150-blinkon175]]
    }, ','
)

vim.wo.signcolumn = 'auto:1'

vim.o.cursorlineopt = 'number'
vim.o.cursorline = true

vim.o.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.backupdir="/tmp/backup//"
vim.o.directory="/tmp/swap//"
vim.o.undodir="/tmp/undo//"

vim.o.shortmess = "AIOTWaotc"

vim.o.pumblend = 0
vim.o.winblend = 0

vim.o.conceallevel = 2

vim.o.dictionary="/usr/share/dict/words"
vim.o.thesaurus=vim.fn.stdpath('config') .. '/thesaurus/words.txt'

vim.g.loaded_matchit = 1

vim.opt.list = true
vim.opt.listchars:append("tab:▷⋅")
vim.opt.listchars:append("nbsp:␣")
vim.opt.listchars:append("trail:⋅")

vim.opt.fillchars:append("eob: ")
vim.opt.fillchars:append("fold: ")
vim.opt.fillchars:append("foldopen:")
vim.opt.fillchars:append("foldclose:")
vim.opt.fillchars:append("foldsep: ")

vim.opt.showbreak = "↪"

vim.o.foldenable = true
-- vim.o.foldmethod = 'expr'
-- vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldminlines=5
vim.o.foldnestmax=5
vim.o.foldlevelstart = -1
vim.o.foldlevel=99

vim.o.scrolloff = 10

-- vim.o.globalstatus = true
vim.o.laststatus = 3
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- some pluginless keymaps
vim.keymap.set({'n', 'v'}, 'Q', '<nop>')
vim.keymap.set('n', '<c-w>q', ':close<cr>')
vim.keymap.set({'n', 'v'}, 'x', '"_x')
vim.keymap.set({'n', 'v'}, 'X', '"_X')
vim.keymap.set({'n', 'v', 'i'}, '<C-l>', ':noh<cr>')
vim.keymap.set('i', '<C-l>', '<C-o>:noh<cr>')
vim.keymap.set('v', '@', ':normal @')
-- vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
-- vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('t', '<C-z>', '<C-\\><C-n>')
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('term_settings', {clear = true}),
    callback = function ()
        vim.wo.number = false
        vim.cmd.startinsert()
    end
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {clear = true}),
    callback = function ()
        vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
    end
})
vim.cmd( -- TODO: use api
[[

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
]])

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
-- require('cfg.coq')
require('cfg.tree')

require('windline.bubblegum')

vim.cmd.colorscheme('tokyodark')

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

require('cfg.whichkey')

vim.opt.shadafile = ""
-- vim: foldmethod=marker sw=4
