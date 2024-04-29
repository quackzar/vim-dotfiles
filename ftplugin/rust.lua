vim.bo.makeprg = "cargo build"
vim.bo.textwidth = 100
vim.bo.spelloptions = "camel"

local unsafe_ray = false
function toggle_unsafe_ray()
    unsafe_ray = not unsafe_ray
    if unsafe_ray then
        -- TODO: Better highlighting? DiffDelete + exception?
        vim.notify("Unsafe-o-Vision: Activated")
        vim.cmd([[
        hi link @lsp.mod.unsafe.rust @exception
        ]])
        require("tsnode-marker").set_automark(0, {
            target = { "unsafe_block" },
            hl_group = "DiffDelete",
        })
    else
        vim.notify("Unsafe-o-Vision: Deactivated")
        vim.cmd([[
        hi link @lsp.mod.unsafe.rust @lsp.mod.unsafe.rust
        ]])
        require("tsnode-marker").unset_automark(0)
    end
end

vim.keymap.set("n", "<localleader>le", toggle_unsafe_ray, { desc = "Toggle unsafe highligting" })

local cmp_lsp_rs = require("cmp_lsp_rs")
local comparators = cmp_lsp_rs.comparators

local cmp = require("cmp")
cmp.setup.buffer {
    sorting = {
        comparators = {
            comparators.inscope_inherent_import,
            comparators.sort_by_label_but_underscore_last,
            cmp.config.compare.score,
            cmp.config.compare.order,
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.length,
            cmp.config.compare.sort_text,
        },
    },
}

vim.keymap.set(
    "n",
    "<leader>bc",
    "<cmd>lua require'cmp_lsp_rs'.combo()<cr>",
    { desc = "(nvim-cmp) switch comparators" }
)
