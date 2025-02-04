vim.bo.makeprg = "cargo build"
vim.bo.textwidth = 100
vim.bo.spelloptions = "camel"

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
