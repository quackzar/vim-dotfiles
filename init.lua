---@diagnostic disable: lowercase-global
vim.opt.shadafile = "NONE"

vim.o.shell = "/bin/zsh"
vim.o.termguicolors = true
-- GUI options
-- vim.o.guifont = "Monaspace Neon,DejaVuSansM Nerd Font,nonicons,codicon,LegacyComputing"
-- vim.o.guifont = "JetBrainsMono Nerd Font:h13,codicons,nonicons,Iosevka"
-- vim.o.guioptions = "ad" -- BUG: Breaks nvim from source
vim.g.mapleader = " "

if vim.fn.exists("g:neovide") then
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_underline_automatic_scaling = true
    vim.g.neovide_scroll_animation_length = 0.4
    --vim.keymap.set({"n", "v"}, "<C-z>", "<cmd>ToggleTerm size=50<cr><cmd>startinsert!<cr>", {desc = "Terminal"})
    --vim.keymap.set("t", "<C-z>", "<cmd>ToggleTerm", { buffer = 0 })

    vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
    vim.keymap.set("v", "<D-c>", '"+y') -- Copy
    vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
    vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
    vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
    vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
end

vim.o.mouse = "a"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.number = true
vim.o.wildmenu = true
vim.o.showmode = false
vim.o.breakindent = true
vim.o.formatoptions = "jcroqlnt" -- tcqj
vim.o.jumpoptions = "stack,view"
vim.o.autowrite = true
vim.o.completeopt = "menuone,noselect"

vim.o.title = true

vim.o.virtualedit = "block,onemore"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.o.autoread = true

vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.guicursor = table.concat({
    [[n-v:block,i-ci-c-ve:ver20,r-cr:hor20,o:hor50]],
    -- [[a:Cursor/lCursor]],
    [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}, ",")

-- vim.wo.signcolumn = "auto:1"

vim.o.cursorlineopt = "number"
vim.o.cursorline = true

vim.o.undofile = true
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.backupdir = "/tmp/backup//"
vim.o.directory = "/tmp/swap//"
vim.o.undodir = "/tmp/undo//"

vim.o.shortmess = "AIOTWaotc"

vim.o.pumblend = 0
vim.o.winblend = 0

vim.o.conceallevel = 2

vim.o.dictionary = "/usr/share/dict/words"
vim.o.thesaurus = vim.fn.stdpath("config") .. "/thesaurus/words.txt"

vim.g.loaded_matchit = 1

vim.opt.list = true
vim.opt.listchars:append("tab:▷⋅")
vim.opt.listchars:append("nbsp:␣")
vim.opt.listchars:append("trail:⋅")

vim.opt.showbreak = "↪"

vim.o.foldenable = true
vim.o.foldminlines = 5
vim.o.foldnestmax = 5
vim.o.foldlevel = 99

vim.o.scrolloff = 10
vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,terminal,localoptions"

vim.o.laststatus = 3

vim.o.colorcolumn = "+0"

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

-- if vim.fn.has('nvim-0.10') then
--     vim.g.clipboard = {
--         name = 'OSC 52',
--         copy = {
--             ['+'] = require('vim.clipboard.osc52').copy,
--             ['*'] = require('vim.clipboard.osc52').copy,
--         },
--         paste = {
--             ['+'] = require('vim.clipboard.osc52').paste,
--             ['*'] = require('vim.clipboard.osc52').paste,
--         },
--     }
-- end

-- some pluginless keymaps
vim.keymap.set({ "n", "x" }, "Q", "<nop>")
vim.keymap.set("n", "<c-w>q", ":close<cr>", { silent = true })
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_X')
vim.keymap.set({ "n", "x", "i" }, "<C-l>", "<cmd>noh|diffupdate|normal! <C-l><cr>", { silent = true })
vim.keymap.set("i", "<C-l>", "<C-o><cmd>noh|diffupdate|normal! <C-l><cr>", { silent = true })
vim.keymap.set("v", "@", ":normal @")
vim.keymap.set("t", "<C-z>", "<C-\\><C-n>")
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<localleader>q", "<cmd>copen<cr>", { silent = true, desc = "Open quickfix" })
vim.keymap.set({ "n", "v" }, "<localleader>K", "<cmd>Inspect<cr>")

vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { silent = true, desc = "next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", { silent = true, desc = "prev quickfix" })
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { silent = true, desc = "next locationlist" })
vim.keymap.set("n", "[l", "<cmd>lprevious<cr>", { silent = true, desc = "prev locationlist" })
vim.api.nvim_create_user_command("Diagnostics", vim.diagnostic.setqflist, {})
vim.api.nvim_create_user_command("LocalDiagnostics", vim.diagnostic.setloclist, {})

vim.keymap.set("n", "<localleader>pp", function()
    vim.notify("Started profilling")
    require("plenary.profile").start("profile.log", { flame = true })
end, { desc = "plenary profile" })
vim.keymap.set("n", "<localleader>pq", function()
    require("plenary.profile").stop()
    vim.notify("Stopped profilling")
end, { desc = "plenary stop profile" })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 }
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { ".qf", "help" },
    group = vim.api.nvim_create_augroup("easy_close", { clear = true }),
    callback = function()
        vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "VimResume", "TermLeave" }, {
    group = vim.api.nvim_create_augroup("improved_autoread", { clear = true }),
    callback = function()
        vim.cmd.checktime()
    end,
})

-- Color the terminals background neovims background
-- https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
    callback = function()
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if not normal.bg then
            return
        end
        io.write(string.format("\027]11;#%06x\027\\", normal.bg))
    end,
})

vim.api.nvim_create_autocmd("UILeave", {
    callback = function()
        io.write("\027]111\027\\")
    end,
})

-- setup for ripgrep as grepper
if vim.fn.executable("rg") then
    vim.o.grepprg = "rg --vimgrep -g='!*.pdf' -g='!*.eps' --no-heading --smart-case"
    vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
    command = [[call mkdir(expand('<afile>:p:h'), 'p')]],
})

-- load custom options (non-standard vim globals)
require("options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
require("functions")
require("lazy").setup("plugins", {
    concurrency = 50,
    git = { timeout = 120 },
    install = { colorscheme = { "kanagawa" } },
})
-- loads all plugins

-- load specific configs
require("mason").setup()
require("cfg.lsp")
require("ts-grammars")

local theme = require("last-color").recall() or "kanagawa"
vim.cmd(("colorscheme %s"):format(theme))

-- vim: foldmethod=marker sw=4
