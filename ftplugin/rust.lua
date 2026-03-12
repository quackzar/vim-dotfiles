vim.bo.makeprg = "cargo build"
vim.bo.textwidth = 100
vim.bo.spelloptions = "camel"
vim.treesitter.start()

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "<leader>a", function()
    vim.cmd.RustLsp("codeAction") -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { silent = true, buffer = bufnr })

vim.keymap.set(
    "n",
    "grh", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp("explainError")
    end,
    { silent = true, buffer = bufnr, desc = "Explain error" }
)

vim.keymap.set(
    "n",
    "gr]", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp("relatedDiagnostics")
    end,
    { silent = true, buffer = bufnr, desc = "Explain error" }
)

vim.keymap.set(
    "n",
    "grc", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    function()
        vim.cmd.RustLsp { "flycheck", "run" }
    end,
    { silent = true, buffer = bufnr, desc = "Flycheck" }
)

-- local cmp_lsp_rs = require("cmp_lsp_rs")
-- local comparators = cmp_lsp_rs.comparators

-- local cmp = require("cmp")
-- cmp.setup.buffer {
--     sorting = {
--         comparators = {
--             -- comparators.inscope_inherent_import,
--             -- comparators.sort_by_label_but_underscore_last,
--             cmp.config.compare.score,
--             cmp.config.compare.order,
--             cmp.config.compare.locality,
--             cmp.config.compare.recently_used,
--             cmp.config.compare.length,
--             cmp.config.compare.sort_text,
--         },
--     },
-- }

-- vim.keymap.set(
--     "n",
--     "<leader>bc",
--     "<cmd>lua require'cmp_lsp_rs'.combo()<cr>",
--     { desc = "(nvim-cmp) switch comparators" }
-- )
