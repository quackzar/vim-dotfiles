vim.bo.makeprg = "cargo build"
vim.bo.textwidth = 100

vim.keymap.set("n", "<C-K>", require("rust-tools").hover_actions.hover_actions)

vim.keymap.set("v", "<C-K>", require("rust-tools").hover_range.hover_range)

-- NOTE: Fun thing, maybe a toggle?

local unsafe_ray = false
function toggle_unsafe_ray()
    unsafe_ray = not unsafe_ray
    if unsafe_ray then
        vim.cmd([[
        hi link @lsp.mod.unsafe.rust @exception
        ]])
        require("tsnode-marker").set_automark(0, {
            target = { "unsafe_block" },
            hl_group = "DiffDelete",
        })
    else
        vim.cmd([[
        hi link @lsp.mod.unsafe.rust @lsp.mod.unsafe.rust
        ]])
        require("tsnode-marker").unset_automark(0)
    end
end

vim.keymap.set("n", "<localleader>le", toggle_unsafe_ray, { desc = "Toggle unsafe highligting" })
