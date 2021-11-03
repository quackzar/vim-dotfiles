require('gitsigns').setup {
  signs = {
    add          = {hl = 'DiffAddGutter'   , text  = '▎', numhl='DiffAddGutter'   , linehl='DiffAdd'},
    change       = {hl = 'DiffChangeGutter', text  = '▎', numhl='DiffChangeGutter', linehl='DiffChange'},
    delete       = {hl = 'DiffDeleteGutter' , text = '◢', numhl='DiffDeleteGutter', linehl='DiffDelete'},
    topdelete    = {hl = 'DiffDeleteGutter', text  = '◥', numhl='DiffDeleteGutter', linehl='DiffDelete'},
    changedelete = {hl = 'DiffChangeGutter', text  = '◢', numhl='DiffChangeGutter', linehl='DiffChange'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,

    ['n ]h'] = { expr = true, "&diff ? ']h' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [h'] = { expr = true, "&diff ? '[h' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ["n <leader>gs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ["v <leader>gs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ["n <leader>gS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ["n <leader>gu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ["n <leader>gr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ["v <leader>gr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ["n <leader>gU"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ["n <leader>gR"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
    ["n <leader>gp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ["n <leader>gb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ["o ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ["x ih"] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
  },
  watch_index = {
    interval = 1000
  },
  sign_priority = 1,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
  use_internal_diff = true,  -- If luajit is present
}
