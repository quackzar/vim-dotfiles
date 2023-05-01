vim.bo.omnifunc = "vimtex#complete#omnifunc"

local lspkind = require("lspkind")

-- TODO: find a method to set this for this buffer only
-- vim.diagnostic.config {
--     virtual_lines = false,
--     signs = true,
-- }

require("cmp").setup.buffer {
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format {
            mode = "symbol_text",
            max_width = 40,
            before = function(entry, vim_item)
                local strings = vim.split(lspkind.presets.default[vim_item.kind], "%s", { trimempty = true })
                if strings[1] then
                    vim_item.kind = strings[1] .. " "
                end

                vim_item.menu = ({
                    omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                    buffer = "BUF",
                    copilot = "COP",
                    luasnip = "SNIP",
                    nvim_lsp = "TeXLab",
                    -- formatting for other sources
                })[entry.source.name]
                return vim_item
            end,
        },
    },
    sources = {
        { name = "nvim_lsp", group_index = 1 },
        -- { name = "copilot", group_index = 2 },
        { name = "omni", group_index = 1 },
        -- { name = "cmp_tabnine", group_index = 2 },
        -- other sources
    },
}
