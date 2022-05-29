local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end

local luasnip = require('luasnip')
local cmp = require("cmp")

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_next_item()
    elseif luasnip and luasnip.expand_or_locally_jumpable() then
        return t("<Plug>luasnip-expand-or-jump")
    elseif check_back_space() then
        return t "<Tab>"
    else
        cmp.complete()
    end
    return ""
end
_G.s_tab_complete = function()
    if cmp and cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip and luasnip.jumpable(-1) then
        return t("<Plug>luasnip-jump-prev")
    else
        return t "<S-Tab>"
    end
    return ""
end

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-h>", "<cmd>lua require('luasnip').next-choice()<cr>", {})
vim.api.nvim_set_keymap("s", "<C-h>", "<cmd>lua require('luasnip').next-choice()<cr>", {})

-- vim.api.nvim_set_keymap("i", "<C-j>", "<cmd>lua require('luasnip').jump(1)<cr>", {})
-- vim.api.nvim_set_keymap("s", "<C-j>", "<cmd>lua require('luasnip').jump(1)<cr>", {})
vim.api.nvim_set_keymap("i", "<C-k>", "<cmd>lua require('luasnip').jump(-1)<cr>", {})
vim.api.nvim_set_keymap("s", "<C-k>", "<cmd>lua require('luasnip').jump(-1)<cr>", {})
local types = require("luasnip.util.types")

luasnip.config.setup({
    enable_autosnippets = true,
    store_selection_keys = '<c-s>',
    history = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {{" ", "Special"}}
            }
        },
        [types.insertNode] = {
            active = {
                virt_text = {{" ", "Special"}}
            }
        }
    }
})
