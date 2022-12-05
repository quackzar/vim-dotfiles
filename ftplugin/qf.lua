vim.keymap.set('n', 'zf', function()
    vim.cmd('close') -- close the quickfix window
    require('telescope.builtin').quickfix(
        require('telescope.themes').get_ivy()
    )
end, {buffer = true, nowait = true})
