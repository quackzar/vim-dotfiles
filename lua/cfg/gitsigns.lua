require('gitsigns').setup {
    signs = {
        add          = {text  = '▎'},
        change       = {text  = '▎'},
        delete       = {text  = '◢'},
        topdelete    = {text  = '◥'},
        changedelete = {text  = '◢'},
    },
    numhl = false,
    linehl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,

        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"},

        ["n <leader>gs"] = '<cmd>Gitsigns stage_hunk<CR>',
        ["v <leader>gs"] = ':Gitsigns stage_hunk<CR>',
        ["n <leader>gS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
        ["n <leader>gu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>gr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["v <leader>gr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
        ["n <leader>gU"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
        ["n <leader>gR"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
        ["n <leader>gp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>gb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

        -- Text objects
        ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
        ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>'
    },
    watch_index = {
        interval = 1000,
        follow_files = true
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    use_decoration_api = true,
    use_internal_diff = true,  -- If luajit is present
}
