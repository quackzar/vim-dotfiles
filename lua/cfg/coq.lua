vim.g.coq_settings = {
    auto_start = 'shut-up',
    display = {
        pum = {
            fast_close = false
        }
    },
    ["keymap.recommended"] = false,
    ["display.icons.mappings"] = {
        Class         = " ",
        Color         = " ",
        Constant      = " ",
        Constructor   = " ",
        Enum          = " ",
        EnumMember    = " ",
        Event         = " ",
        Field         = " ",
        File          = " ",
        Folder        = " ",
        Function      = " ",
        Interface     = " ",
        Keyword       = " ",
        Method        = " ",
        Module        = " ",
        Operator      = " ",
        Property      = " ",
        Reference     = " ",
        Snippet       = " ",
        Struct        = " ",
        Text          = " ",
        TypeParameter = " ",
        Unit          = " ",
        Value         = " ",
        Variable      = " ",
    }
}

function map(...) vim.api.nvim_set_keymap(...) end
opts = {noremap=true, silent=true, expr=true}
map("i", "<Esc>",  "pumvisible() ? '<C-e><Esc>' : '<Esc>'", opts)
map("i", "<C-c>",  "pumvisible() ? '<C-e><C-c>' : '<C-c>'", opts)
map("i", "<BS>",   "pumvisible() ? '<C-e><BS>'  : '<BS>'", opts)
-- map("i", "<CR>", [[pumvisible() ? (complete_info().selected == -1 ? "<C-e><CR>" : "<C-y>") : "<CR>"]], opts)
map("i", "<CR>", [[pumvisible() ? (complete_info().selected == -1 ? "<C-e><Cmd>lua require('pairs.enter').type()<CR>" : "<C-y>") : "<Cmd>lua require('pairs.enter').type()<CR>"]], opts)

