---@diagnostic disable: lowercase-global
vim.opt.shadafile = "NONE"

vim.o.shell = "/bin/zsh"
vim.o.termguicolors = true
-- GUI options
vim.o.guifont = "Cascadia Code,codicons,nonicons:h15"
-- vim.o.guifont = "JetBrainsMono Nerd Font:h13,codicons,nonicons,Iosevka"
vim.o.guioptions = "ad"
vim.g.mapleader = " "

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
require("lazy").setup("plugins", {
    concurrency = 50,
    git = { timeout = 120 },
    install = { colorscheme = { "kanagawa" } },
})

if vim.fn.exists("g:neovide") then
    vim.g.neovide_transparency = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_underline_automatic_scaling = true
    vim.g.neovide_scroll_animation_length = 0.4
    vim.g.neovide_input_macos_alt_is_meta = true
end

vim.o.mouse = "a"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.number = true
vim.o.wildmenu = true
vim.o.showmode = false
vim.o.breakindent = true

-- vim.o.title = true

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
    [[n-v:block,i-ci-c-ve:ver25,r-cr:hor20,o:hor50]],
    -- [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
    [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}, ",")

vim.wo.signcolumn = "auto:1"

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

vim.o.laststatus = 3

vim.o.colorcolumn = "+0"

-- some pluginless keymaps
vim.keymap.set({ "n", "x" }, "Q", "<nop>")
vim.keymap.set("n", "<c-w>q", ":close<cr>", { silent = true })
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_X')
vim.keymap.set({ "n", "x", "i" }, "<C-l>", ":noh<cr>", { silent = true })
vim.keymap.set("i", "<C-l>", "<C-o>:noh<cr>", { silent = true })
vim.keymap.set("v", "@", ":normal @")
vim.keymap.set("t", "<C-z>", "<C-\\><C-n>")
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<space>q", "<cmd>copen<cr>", { silent = true, desc = "Open quickfix" })

vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { silent = true, desc = "Next quickfix" })
vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", { silent = true, desc = "Previous quickfix" })
vim.keymap.set("n", "]l", "<cmd>lnext<cr>", { silent = true, desc = "Next locationlist" })
vim.keymap.set("n", "[l", "<cmd>lprevious<cr>", { silent = true, desc = "Previous locationlist" })

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

vim.api.nvim_create_autocmd("ModeChanged", {
    callback = function()
        local modes = {
            ["n"] = vim.g.terminal_color_1, -- red
            ["i"] = vim.g.terminal_color_2, -- green
            ["ti"] = vim.g.terminal_color_2, -- green
            ["tn"] = vim.g.terminal_color_1, -- green
            ["v"] = vim.g.terminal_color_3, -- yellow
            ["V"] = vim.g.terminal_color_3, -- yellow
            ["�"] = vim.g.terminal_color_3, -- yellow
            ["s"] = vim.g.terminal_color_6, -- cyan
            ["S"] = vim.g.terminal_color_6, -- cyan
            ["R"] = vim.g.terminal_color_4, -- blue
            ["c"] = vim.g.terminal_color_5, -- magenta
        }
        local colors = vim.api.nvim_get_hl_by_name("CursorLineNr", true)
        vim.api.nvim_set_hl(0, "CursorLineNr", {
            foreground = modes[vim.api.nvim_get_mode().mode] or nil,
            background = colors.background,
        })
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

-- loads all plugins

require("functions")

-- load specific configs
require("mason").setup()
require("cfg.lsp")
require("ts-grammars")
require("windline.bubblegum")
require("cfg.whichkey")

local theme = require("last-color").recall() or "kanagawa"
vim.cmd(("colorscheme %s"):format(theme))

vim.opt.shadafile = ""
-- vim: foldmethod=marker sw=4
