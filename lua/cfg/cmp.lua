local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local lspkind = require("lspkind")
local cmp = require("cmp")
cmp.setup {
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete {}, { "i", "c" }),
        ["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete {}, { "i", "c" }),
        ["<C-x><C-f>"] = cmp.mapping(
            cmp.mapping.complete {
                config = {
                    sources = {
                        { name = "path" },
                    },
                },
            },
            { "i", "c" }
        ),
        ["<C-x><C-s>"] = cmp.mapping(
            cmp.mapping.complete {
                config = {
                    sources = {
                        {
                            name = "spell",
                            option = {
                                keep_all_entries = true,
                            },
                        },
                    },
                },
            },
            { "i", "c" }
        ),
        ["<C-j>"] = cmp.mapping {
            i = function()
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                else
                    cmp.confirm()
                end
            end,
            c = cmp.mapping.confirm { select = true },
        },
        ["<C-e>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<C-n>"] = cmp.mapping {
            c = function()
                if cmp.visible() then
                    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                else
                    vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                end
            end,
            i = function()
                if cmp.visible() then
                    cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
                end
            end,
        },
        ["<C-p>"] = cmp.mapping {
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
                else
                    vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                end
            end,
            i = function()
                if cmp.visible() then
                    cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
                end
            end,
        },
        ["<tab>"] = cmp.mapping {
            c = cmp.confirm { select = true },
        },
        ["<s-tab>"] = cmp.mapping {
            c = cmp.select_prev_item(),
        },
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp", group_index = 2 },
        -- { name = "copilot", group_index = 2 },
        { name = "luasnip", group_index = 2 }, -- For luasnip users.
        { name = "crates", group_index = 2 },
        -- { name = "codium" },
        -- { name = "cmp_tabnine", group_index = 1 },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            -- TODO: Handle them not existing
            -- require("copilot_cmp.comparators").prioritize,
            -- require("copilot_cmp.comparators").score,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            -- require("cmp_tabnine.compare"),
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    view = {
        entries = { name = "custom", selection_order = "near_cursor" },
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
        completion = {
            -- winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            -- winhighlight = "Normal:Pmenu",
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format {
            mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            maxwidth = 40, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                local strings = vim.split(lspkind.presets.default[vim_item.kind], "%s", { trimempty = true })
                if strings[1] then
                    vim_item.kind = strings[1] .. " "
                end
                local source_mapping = {
                    buffer = "BUF",
                    nvim_lsp = "LSP",
                    copilot = "COP",
                    luasnip = "SNIP",
                    omni = "OMNI",
                    cmp_tabnine = "TAB9",
                    codeium = " ",
                }

                local menu = source_mapping[entry.source.name]
                if entry.source.name == "cmp_tabnine" then
                    if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                        menu = entry.completion_item.data.detail .. " " .. menu
                    end
                    vim_item.kind_hl_group = "CmpItemKindCopilot"
                    vim_item.kind = " "
                elseif entry.source.name == "copilot" then
                    if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                        menu = entry.completion_item.data.detail .. " " .. menu
                    end
                    vim_item.kind_hl_group = "CmpItemKindCopilot"
                    vim_item.kind = " "
                end

                vim_item.menu = menu

                return vim_item
            end,
        },
    },
    experimental = {
        ghost_text = false, -- incompatible with copilot
    },
}

-- Might want to tune this for different filetypes.
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.filetype("guihua", { completion = { enable = false } })
cmp.setup.filetype("guihua_rust", { completion = { enable = false } })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    view = {
        entries = { name = "custom", separator = " ⋅ " },
    },
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    view = {
        entries = { name = "custom", separator = " ⋅ " },
    },
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}
