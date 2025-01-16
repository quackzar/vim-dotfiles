vim.keymap.set("n", "<localleader>LL", "<cmd>TypstWatch<cr>", { buffer = true })
vim.keymap.set("n", "<localleader>LV", function()
    local filename = vim.fn.expand("%:t:r")
    vim.cmd("!open " .. filename .. ".pdf")
end, { buffer = true })

vim.keymap.set("n", "<localleader>ll", "<cmd>TypstPreviewToggle<cr>", { buffer = true })
vim.keymap.set("n", "<localleader>lv", "<cmd>TypstPreviewSyncCursor<cr>", { buffer = true })
vim.keymap.set("n", "<localleader>lf", "<cmd>TypstPreviewFollowCursor<cr>", { buffer = true })
vim.keymap.set("n", "<localleader>lF", "<cmd>TypstPreviewNoFollowCursor<cr>", { buffer = true })

vim.bo.spelllang = "en"
vim.wo.spell = true
vim.bo.textwidth = 100
vim.wo.colorcolumn = "100"

require("cmp").setup.buffer {
    sources = {
        { name = "nvim_lsp", group_index = 1 },
    },
}

vim.keymap.set("n", "<localleader>lt", "<cmd>LspStart ltex<cr>", { buffer = true })
vim.keymap.set("n", "<localleader>lT", "<cmd>LspStop ltex<cr>", { buffer = true })
