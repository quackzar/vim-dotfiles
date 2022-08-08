local luasnip = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-s><C-o>", function()
    require("luasnip.extras.select_choice")()
end, { desc = "Select choice" })
vim.keymap.set({ "i", "s" }, "<C-s><C-k>", "<Plug>luasnip-next-choice")
vim.keymap.set({ "i", "s" }, "<C-s><C-j>", function()
    require("luasnip").expand()
end, { desc = "Expand snippet" })
vim.keymap.set({ "i", "s", "n" }, "<C-s><C-n>", function()
    require("luasnip").jump(1)
end, { desc = "Jump next" })
vim.keymap.set({ "i", "s", "n" }, "<C-s><C-p>", function()
    require("luasnip").jump(-1)
end, { desc = "Jump prev" })
vim.keymap.set({ "i", "s", "n", "v" }, "<C-s><C-l>", function()
    require("luasnip").unlink_current_if_deleted()
end, { desc = "Stop" })
vim.keymap.set({ "v" }, "<C-s><C-f>", '"sc<cmd>lua require("luasnip.extras.otf").on_the_fly()<cr>')
vim.keymap.set({ "i" }, "<C-s><C-f>", '<cmd>lua require("luasnip.extras.otf").on_the_fly("s")<cr>')
-- TODO: Make generic register version
local types = require("luasnip.util.types")

vim.keymap.set("i", "<C-s>", "<nop>")
require("which-key").register({
    name = "Snippets",
    ["<C-o>"] = "Select choice",
    ["<C-k>"] = "Next choice",
    ["<C-j>"] = "Expand",
    ["<C-n>"] = "Jump next",
    ["<C-p>"] = "Jump previous",
    ["<C-f>"] = "Fly snippet",
    ["<C-l>"] = "Stop",
}, { mode = "i", prefix = "<C-s>" })

luasnip.config.setup {
    enable_autosnippets = true,
    store_selection_keys = "<c-s>",
    history = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { " ", "Special" } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { " ", "Special" } },
            },
        },
    },
}
