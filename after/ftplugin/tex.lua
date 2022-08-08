vim.bo.omnifunc = "vimtex#complete#omnifunc"

local lspkind = require("lspkind")

require("cmp").setup.buffer {
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind)
            vim_item.menu = ({
                omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                buffer = "[BUF]",
                luasnip = "[SNIP]",
                copilot = "[COP]",
                nvim_lsp = "[TeXLab]",
                -- formatting for other sources
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot", group_index = 2 },
        { name = "omni", group_index = 2 },
        { name = "luasnip", group_index = 2 }, -- For luasnip users.
        { name = "crates", group_index = 2 },
        { name = "cmp_tabnine", group_index = 2 },
        -- other sources
    },
}
