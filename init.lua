vim.o.encoding = "utf8"
vim.o.shell = "/bin/zsh"
vim.o.termguicolors = true
vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.number = true
vim.o.foldenable = true
vim.o.wildmenu = true
vim.o.showmode = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.autoread = true
vim.o.shiftwidth = 4

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

vim.api.nvim_set_keymap('', '<cr>', ':', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'Q', ':close<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gQ', ':bd<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'X', '"_X', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gb', ':bn<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', 'gB', ':bp<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('', '<Space><Space>', ':noh<cr>', { noremap = true, silent = true })
vim.g.mapleader = ' '

vim.g.indent_blankline_char = '▏'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer', 'undotree', 'text', 'dashboard', 'man' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = true
vim.g.indent_blankline_show_first_indent_level = false

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

require('plugins')

require('impatient')
require('cfg.treesitter')
require('cfg.gitsigns')
require('cfg.telescope')
require('cfg.dap')
require('cfg.lsp')
require('toggle_lsp_diagnostics').init()
require('neogit').setup {}
require('nvim-tree').setup {}
require('numb').setup()
require('gitlinker').setup()
require('Comment').setup()
require("stabilize").setup()
require('rust-tools').setup({})
require("todo-comments").setup{}
require("renamer").setup{}
require("twilight").setup {}
require('neoscroll').setup()
require('colorizer').setup()

require('windline.bubblegum')

local wk = require("which-key")
wk.setup {
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

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)


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
vim.g.copilot_no_tab_map = true
vim.api.nvim_exec([[
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
]], false) -- HACK: seriosly fix this

if vim.fn.executable('rg') then
    vim.o.grepprg="rg --vimgrep -g='!*.pdf' -g='!*.eps' --no-heading --smart-case"
    vim.o.grepformat="%f:%l:%c:%m,%f:%l:%m"
end

-- vim: foldmethod=marker sw=4
