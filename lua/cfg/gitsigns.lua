require('gitsigns').setup{
    signs = {
        add          = {text  = '▎'},
        change       = {text  = '▎'},
        delete       = {text  = '◢'},
        topdelete    = {text  = '◥'},
        changedelete = {text  = '◢'},
    },
    numhl = false,
    linehl = false,
    watch_gitdir = {
        interval = 1000,
        follow_files = true
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr=true, desc="next hunk"})

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr=true, desc="prev hunk"})

        -- Actions
        map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', {desc="stage hunk"})
        map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', {desc="reset hunk"})
        map('n', '<leader>gS', gs.stage_buffer, {desc="stage buffer"})
        map('n', '<leader>gu', gs.undo_stage_hunk, {desc="undo stage hunk"})
        map('n', '<leader>gR', gs.reset_buffer, {desc="reset buffer"})
        map('n', '<leader>gp', gs.preview_hunk, {desc="preview hunk"})
        map('n', '<leader>gb', function() gs.blame_line{full=true} end)
        -- map('n', '<leader>ob', gs.toggle_current_line_blame)
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<leader>gD', function() gs.diffthis('~') end)

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc="inner hunk"})
    end
}
