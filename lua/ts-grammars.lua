-- # This file is dedicated to keep track of custom treesitter parsers.
-- Thus they can easily be installed by the normal `TSInstall <parser>`

vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
        require("nvim-treesitter.parsers").vhs = {
            install_info = {
                url = "https://github.com/charmbracelet/tree-sitter-vhs.git",
                branch = "main",
            },
        }
    end,
})

vim.filetype.add { extension = { vhs = "vhs" } }
vim.treesitter.language.register("vhs", { "vhs" })

-- vim.api.nvim_create_autocmd('User', { pattern = 'TSUpdate',
-- callback = function()
--   require('nvim-treesitter.parsers').flatbuffers = {
--     install_info = {
--       url = 'https://github.com/emindeniz99/flatbuffers-format',
--       branch = 'main',
--       location = 'tree-sitter-flatbuffers',
--     },
--   }
-- end})
--
-- vim.filetype.add({ extension = { fbs = "flatbuffers" } })
-- vim.treesitter.language.register('flatbuffers', { 'fbs' })
