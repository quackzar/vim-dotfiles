local luasnip = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-s><C-o>", function()
    require("luasnip.extras.select_choice")()
end, { desc = "select snip-choice" })

vim.keymap.set({ "i", "s" }, "<C-s><C-l>", "<Plug>luasnip-next-choice")
vim.keymap.set({ "i", "s" }, "<C-s><C-h>", "<Plug>luasnip-prev-choice")

vim.keymap.set({ "i", "s" }, "<C-s><C-j>", function()
    require("luasnip").expand()
end, { desc = "expand snippet" })

vim.keymap.set({ "i", "s", "n" }, "<C-s><C-n>", function()
    require("luasnip").jump(1)
end, { desc = "jump next placeholder" })

vim.keymap.set({ "i", "s", "n" }, "<C-s><C-p>", function()
    require("luasnip").jump(-1)
end, { desc = "jump prev placeholder" })

vim.keymap.set({ "i", "n", "v" }, "<C-s><C-l>", function()
    require("luasnip").unlink_current()
end, { desc = "stop snippeting" })

vim.keymap.set(
    { "v" },
    "<C-s><C-f>",
    '"sc<cmd>lua require("luasnip.extras.otf").on_the_fly()<cr>',
    { desc = "on-the-fly snip" }
)
vim.keymap.set(
    { "i" },
    "<C-s><C-f>",
    '<cmd>lua require("luasnip.extras.otf").on_the_fly("s")<cr>',
    { desc = "on-the-fly snip" }
)
-- TODO: Make generic register version
local types = require("luasnip.util.types")

vim.keymap.set({ "i" }, "<C-s>", "<nop>")

luasnip.config.setup {
    enable_autosnippets = true,
    store_selection_keys = "<c-s>",
    history = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "󰬸", "Special" } },
            },
            passive = {
                virt_text = { { "󰬸", "Nontext" } },
            },
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "Statement" } },
            },
            passive = {
                virt_text = { { "●", "NonText" } },
            },
        },
    },
    -- ext_opts = {
    --     [types.choiceNode] = {
    --         active = {
    --             virt_text = { { "", "Conceal" } },
    --             hl_group = "DiffText",
    --             virt_text_pos = "inline",
    --             priority = 0,
    --         },
    --         visited = {
    --             virt_text = { { "󰆤 ", "Conceal" } },
    --             virt_text_pos = "inline",
    --             hl_group = "DiffAdd",
    --         },
    --         unvisited = {
    --             virt_text = { { "󰆣 ", "Conceal" } },
    --             virt_text_pos = "inline",
    --             hl_group = "DiffDelete",
    --         },
    --     },
    --     [types.insertNode] = {
    --         active = {
    --             virt_text = { { "", "Conceal" } },
    --             hl_group = "DiffText",
    --             priority = 0,
    --         },
    --         visited = {
    --             virt_text = { { "󰆤 ", "Conceal" } },
    --             hl_group = "DiffAdd",
    --             virt_text_pos = "inline",
    --         },
    --         -- passive = {
    --         --     virt_text = { { "󰆣 ", "Label" } },
    --         --     hl_group = "DiffDelete",
    --         -- },
    --         unvisited = {
    --             virt_text = { { "󰆣 ", "Conceal" } },
    --             hl_group = "DiffDelete",
    --             virt_text_pos = "inline",
    --         },
    --     },
    -- },
}

local select_next = false
vim.keymap.set({ "i", "s", "n" }, "<C-s><C-s>", function()
    -- the meat of this mapping: call ls.activate_node.
    -- strict makes it so there is no fallback to activating any node in the
    -- snippet, and select controls whether the text associated with the node is
    -- selected.
    local ok, _ = pcall(luasnip.activate_node, {
        strict = true,
        -- select_next is initially unset, but set within the first second after
        -- activating the mapping, so activating it again in that timeframe will
        -- select the text of the found node.
        select = select_next,
    })
    -- ls.activate_node throws on failure.
    if not ok then
        print("No node.")
        return
    end

    -- once the node is activated, we are either done (if text is SELECTed), or
    -- we briefly highlight the text associated with the node so one can know
    -- which node was activated.
    -- TODO: this highlighting does not show up if the node has no text
    -- associated (ie ${1:asdf} vs $1), a cool extension would be to also show
    -- something if there was no text.
    if select_next then
        return
    end

    local curbuf = vim.api.nvim_get_current_buf()
    local hl_duration_ms = 100

    local node = luasnip.session.current_nodes[curbuf]
    -- get node-position, raw means we want byte-columns, since those are what
    -- nvim_buf_set_extmark expects.
    local from, to = node:get_buf_position { raw = true }

    -- highlight snippet for 1000ms
    local id = vim.api.nvim_buf_set_extmark(curbuf, luasnip.session.ns_id, from[1], from[2], {
        -- one line below, at col 0 => entire last line is highlighted.
        end_row = to[1],
        end_col = to[2],
        hl_group = "Visual",
    })
    -- disable highlight by removing the extmark after a short wait.
    vim.defer_fn(function()
        vim.api.nvim_buf_del_extmark(curbuf, luasnip.session.ns_id, id)
    end, hl_duration_ms)

    -- set select_next for the next second.
    select_next = true
    vim.uv.new_timer():start(1000, 0, function()
        select_next = false
    end)
end)
