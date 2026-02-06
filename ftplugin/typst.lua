vim.keymap.set("n", "<localleader>LL", "<cmd>TypstWatch<cr>", { buffer = true })
vim.keymap.set("n", "<localleader>LV", function()
    local filename = vim.fn.expand("%:t:r")
    vim.cmd("!open " .. filename .. ".pdf")
end, { buffer = true })

vim.keymap.set("n", "<localleader>ll", "<cmd>TypstPreviewToggle<cr>", { buffer = true, desc = "Toggle preview" })
vim.keymap.set("n", "<localleader>lv", "<cmd>TypstPreviewSyncCursor<cr>", { buffer = true, desc = "Sync cursor" })
vim.keymap.set("n", "<localleader>lf", "<cmd>TypstPreviewFollowCursor<cr>", { buffer = true, desc = "Follow cursor" })
vim.keymap.set(
    "n",
    "<localleader>lF",
    "<cmd>TypstPreviewNoFollowCursor<cr>",
    { buffer = true, desc = "Unfollow cursor" }
)

vim.keymap.set("n", "<localleader>lp", function()
    vim.lsp.buf.execute_command { command = "tinymist.pinMain", arguments = { vim.api.nvim_buf_get_name(0) } }
end, { buffer = true, desc = "Pin main" })
vim.keymap.set("n", "<localleader>lP", function()
    vim.lsp.buf.execute_command { command = "tinymist.pinMain", arguments = { nil } }
end, { buffer = true, desc = "Unpin main" })

vim.bo.spelllang = "en"
vim.wo.spell = true
vim.bo.textwidth = 100
vim.wo.colorcolumn = "100"

vim.keymap.set("n", "<localleader>lt", "<cmd>LspStart ltex<cr>", { buffer = true })
vim.keymap.set("n", "<localleader>lT", "<cmd>LspStop ltex<cr>", { buffer = true })

vim.treesitter.start()
