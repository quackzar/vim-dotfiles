vim.bo.makeprg = "cargo build"
vim.bo.textwidth = 100
vim.bo.spelloptions = "camel"

vim.keymap.set("n", "<C-K>", require("rust-tools").hover_actions.hover_actions)

vim.keymap.set("v", "<C-K>", require("rust-tools").hover_range.hover_range)

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
