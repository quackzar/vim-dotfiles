-- vim.bo.omnifunc='vimtex#complete#omnifunc'

local lspkind = require('lspkind')

require('cmp').setup.buffer {
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind)
            vim_item.menu = ({
                omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                buffer = "[BUF]",
                luasnip = "[SNIP]",
                copilot = "[COP]",
                -- formatting for other sources
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'omni' },
        { name = 'buffer' },
        { name = 'luasnip' },
        { name = 'copilot' },
        -- other sources
    },
}
