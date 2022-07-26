---@diagnostic disable: lowercase-global
local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end

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

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
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
        F = {
            name = "+telescope  ",
            f = { "<cmd>Telescope find_files<cr>", "Files" },
            b = { "<cmd>Telescope buffers<cr>", "Buffers" },
            g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
            h = { "<cmd>Telescope help_tags<cr>", "Help" },
            r = { "<cmd>Telescope lsp_references<cr>", "References" },
            s = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Symbols" },
            d = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Diagntics" },
            c = {
                "<cmd>lua require('telescope.builtin').colorscheme({enable_preview=true})<cr>",
                "Colorschemes",
            },
        },
        x = {
            name = "+trouble  ",
            x = {"<cmd>Trouble<cr>", "Trouble"},
            w = {"<cmd>Trouble workspace_diagnostics<cr>", "Workspace"},
            d = {"<cmd>Trouble document_diagnostics<cr>", "Document"},
            l = {"<cmd>Trouble loclist<cr>", "Loclist"},
            q = {"<cmd>Trouble quickfix<cr>", "Quickfix"},
            c = {"<cmd>TroubleClose<cr>", "Close"},
        },
        G = {
            name = "+git  ",
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
            R = {"Reset buffer index"},
            y = {"Link buffer"},
        },
        -- TODO: t: add ultest--[[  ]]
        O = {
            name = "+options",
            t = {"<cmd>Twilight<cr>", "Twilight"},
            z = {"<cmd>ZenMode<cr>", "Zen Mode"},
            i = {"<cmd>IlluminationToggle<cr>", "Illuminate"},
            l = {"<cmd>IndentBlanklineToggle<cr>", "Indent Line"},
            c = {"<cmd>lua require('cmp').setup.buffer { enabled = false }<cr>", "Autocompletion Off"},
            C = {"<cmd>lua require('cmp').setup.buffer { enabled = true }<cr>", "Autocompletion On"},
        },
        p = {
            name = "+perf  ",
        }
    },
})

wk.register({
    d = {
        name = "+debug  ",
        a = {
            function()
                require'dap'.set_breakpoint()
                require'dap'.run({type='python', request='attach', host='127.0.0.1', port=5678})
                require'hydra'.spawn('dap-hydra')
            end,
            'Attach (localhost, 5678)'
        },
        s = {
            name = "Step",
            c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
            v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
            i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
            o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
        },
        h = {
            name = "Hover",
            h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
            v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
        },
        u = {
            name = "UI",
            h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
            f = { "local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Float" },
        },
        r = {
            name = "Repl",
            o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
            l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
        },
        b = {
            name = "Breakpoints",
            c = {
                "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
                "Breakpoint Condition",
            },
            m = {
                "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
                "Log Point Message",
            },
            t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
        },
        c = { "<cmd>lua require('dap').scopes()<CR>", "Scopes" },
        i = { "<cmd>lua require('dap').toggle()<CR>", "Toggle" },
    },
    t = {
        name = "+test  ",
        a = { "<Plug>(ultest-run-file)", "Test file" },
        t = { "<Plug>(ultest-run-nearest)", "Test nearest" },
        l = { "<Plug>(ultest-run-last)", "Test last" },
        o = { "<Plug>(ultest-output-show)", "Show output" },
        s = { "<Plug>(ultest-summary-toggle)", "Summary" },
        A = { "<Plug>(ultest-attach)", "Attach" },
        S = { "<Plug>(ultest-stop-file)", "Stop file" },
        X = { "<Plug>(ultest-stop-nearest)", "Stop nearest" },
        D = { "<Plug>(ultest-debug)", "Debug file" },
        d = { "<Plug>(ultest-debug)", "Debug nearest" },
    },
    s = {
        name = "+snip run  ",
        r = {":SnipRun<cr>", "Run"},
        i = {":SnipInfo<cr>", "Info"},
        d = {":SnipReset<cr>", "Reset"},
        l = {":SnipLive<cr>", "Live"},
        s = {"<Plug>RestNvim", "Rest Request"},
        p = {"<Plug>RestNvimPreview", "Rest Preview"},
        S = {"<Plug>RestNvimLast", "Rest Last"},
    },
    r = {
        name = "+refactor  ",
        n = {"<cmd> lua vim.lsp.buf.rename()<cr>", "Rename"},
    }
}, { prefix = "<leader>", noremap = false })

wk.register({
    name = "Insert mode completion",
    ['<c-l>'] = "Lines",
    ['<c-n>'] = "Current file",
    ['<c-k>'] = "Dictionary",
    ['<c-t>'] = "Thesarus",
    ['<c-i>'] = "Included",
    ['<c-]>'] = "Tags",
    ['<c-f>'] = "File names",
    ['<c-d>'] = "Defintions",
    ['<c-v>'] = "Vim CMD",
    ['<c-u>'] = "User defined",
    ['<c-o>'] = "Omni",
    ['s'] = "Spell suggest",
    ['<c-z>'] = "Stop Completion",
}, {mode = 'i', prefix = '<C-x>'})

wk.register({
    ["co"] = "Select ours",
    ["ct"] = "Select theirs",
    ["cb"] = "Select both",
    ["c0"] = "Select none",
    ["[x"] = "Previous Conflict",
    ["]x"] = "Next conflict",
}, {mode = "n"})


wk.register({
    name = "Show mappings",
    o = {"<cmd>WhichKey '' o<cr>", "Operators"},
    i = {"<cmd>WhichKey '' i<cr>", "Insert Mode"},
    v = {"<cmd>WhichKey '' v<cr>", "Visual Mode"},
    n = {"<cmd>WhichKey '' n<cr>", "Normal Mode"},
    x = {"<cmd>WhichKey '' x<cr>", "Mode"},
}, {prefix = "<space><space>", mode = "n"})

-- vim: foldmethod=marker sw=4
