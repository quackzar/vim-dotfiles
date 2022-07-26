require("neotest").setup({
    default_strategy = 'overseer',
    adapters = {
        require("neotest-rust"),
        require("neotest-python")({
            dap = { justMyCode = false },
        }),
        require('neotest-jest')({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
        }),
    },
})

vim.keymap.set('n', '<leader>tt', require("neotest").run.run, {desc = 'Run nearest test'})
vim.keymap.set('n', '<leader>td',
    function() require("neotest").run.run({strategy = "dap"}) end,
    {desc = 'Debug nearest test'})

vim.keymap.set('n', '<leader>ts', require("neotest").run.stop, {desc = 'Stop nearest test'})
vim.keymap.set('n', '<leader>ta', require("neotest").run.attach, {desc = 'Attach nearest test'})
vim.keymap.set('n', '<leader>to', require("neotest").summary.toggle, {desc = 'Toggle test summary'})

vim.keymap.set('n', ']t', require("neotest").jump.next, {desc = 'next test'})
vim.keymap.set('n', '[t', require("neotest").jump.prev, {desc = 'prev test'})
vim.keymap.set('n', ']T',
    function() require("neotest").jump.next({status='failed'}) end,
    {desc = 'next failed test'})
vim.keymap.set('n', '[T',
    function() require("neotest").jump.prev({status='failed'}) end,
    {desc = 'prev failed test'})
