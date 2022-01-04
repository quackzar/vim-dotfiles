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


vim.opt.list = true
vim.opt.listchars:append("tab:▷⋅")
vim.opt.listchars:append("nbsp:␣")
vim.opt.listchars:append("trail:⋅")

vim.opt.fillchars:append("eob: ")
vim.opt.showbreak = "↪"


-- some pluginless keymaps
vim.api.nvim_set_keymap('', '<cr>', ':', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'Q', ':close<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gQ', ':bd<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'X', '"_X', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gb', ':bn<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gB', ':bp<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<C-l>', ':noh<cr>', { noremap = true, silent = true })
vim.g.mapleader = ' '


vim.g.neomolokai_no_bg = true
vim.g.neomolokai_inv_column = true
vim.cmd('colorscheme neomolokai')
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

require('plugins')
require('cfg.treesitter')
require('cfg.gitsigns')
require('cfg.telescope')
require('cfg.dap')
require('cfg.lsp')

require('windline.bubblegum')


local wk = require('which-key')
wk.register({
    ["<leader>"] = {
	f = {
	    name = "+find",
	    f = { "<cmd>Telescope find_files<cr>", "Find File" },
	    b = { "<cmd>Telescope buffers<cr>", "Find Buffer" },
	    g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
	    h = { "<cmd>Telescope help_tags<cr>", "Find help" },
	},
    },
})
-- vim: foldmethod=marker sw=4
