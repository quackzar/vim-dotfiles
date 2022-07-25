local cmp = require('cmp')
local lspkind = require('lspkind')

lspkind.init({
    -- DEPRECATED (use mode instead): enables text annotations
    --
    -- default: true
    -- with_text = true,

    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol',

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Class         = "",
        Color         = "",
        Constant      = "",
        Constructor   = "",
        Enum          = "",
        EnumMember    = " ",
        Event         = " ",
        Field         = " ",
        File          = " ",
        Folder        = " ",
        Function      = " ",
        Interface     = " ",
        Keyword       = " ",
        Method        = " ",
        Module        = " ",
        Operator      = " ",
        Property      = " ",
        Reference     = " ",
        Snippet       = " ",
        Struct        = " ",
        Text          = " ",
        TypeParameter = " ",
        Unit          = " ",
        Value         = " ",
        Variable      = " ",
    },
})


cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({}), { 'i', 'c' }),
        ['<C-x><C-o>'] = cmp.mapping(cmp.mapping.complete({}), { 'i', 'c' }),
        ['<C-j>'] = cmp.mapping({
            i = function()
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.confirm()
                end
            end,
            c = cmp.mapping.confirm({select = true})
        }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = function(fallback)
            if cmp.visible() then
                cmp.mapping.confirm({select = false})
            else
                fallback()
            end
        end,
        ['<C-n>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {'i', 'c'}),
        ['<C-p>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {'i', 'c'}),
        ['<tab>'] = cmp.mapping({
            c = cmp.confirm({select=true})
        }),
        ['<s-tab>'] = cmp.mapping({
            c = cmp.select_prev_item()
        })
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'copilot', group_index = 2 },
        { name = 'omni', group_index = 2},
        { name = 'luasnip', group_index = 2 }, -- For luasnip users.
        { name = "crates", group_index = 2 },
        { name = 'cmp_tabnine', group_index = 2 },
    }),
    completion = {
        completeopt = "menu,menuone,noinsert,preview,noselect",
        keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
        keyword_length = 1,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            menu = {
                buffer = '[BUF]',
                nvim_lsp = '[LSP]',
                copilot = '[COP]',
                luasnip = '[SNIP]',
                omni = '[OMNI]',
                nvim_lua = '[API]',
            },

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        })
    },
    experimental = {
        ghost_text = true, -- incompatible with copilot
    },
})


local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))


-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
            { name = 'buffer' },
        })
})

cmp.setup.filetype('guihua', { completion = {enable = false} })
cmp.setup.filetype('guihua_rust', { completion = {enable = false} })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    view = {
        entries = {name = 'wildmenu', separator = ' ⋅ ' }
    },
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    view = {
        entries = {name = 'wildmenu', separator = ' ⋅ ' }
    },
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
            { name = 'cmdline' }
        })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
