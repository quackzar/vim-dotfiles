vim.opt.encoding = "utf8"
vim.opt.shell = "/bin/zsh"
vim.g.mapleader = ' '
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.wrap = false
vim.opt.number = true
vim.opt.foldenable = true
vim.opt.wildmenu = true


vim.g.neomolokai_no_bg = true
vim.g.neomolokai_inv_column = true
vim.cmd('colorscheme neomolokai')
vim.g.python3_host_prog = '/usr/bin/python3'

require('plugins')

-- require('impatient')
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

-- require('windline.bubblegum')

wk = require("which-key")
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



-- vim: foldmethod=marker
