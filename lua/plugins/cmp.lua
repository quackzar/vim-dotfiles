return {
    {
        "hrsh7th/nvim-cmp", -- TODO: https://github.com/hrsh7th/nvim-cmp/pull/1094
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",

            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp",

            {
                "ofirgall/cmp-lspkind-priority",
                opts = {
                    priority = {
                        "Snippet",
                        "Function", -- In rust atleast, we want function without self usally
                        "Constructor",
                        "Method", -- The other ones won't appear anyway when dealing with objects.
                        "Field",
                        "Variable",
                        "Class",
                        "Interface",
                        "Module",
                        "Property",
                        "Unit",
                        "Value",
                        "Enum",
                        "Keyword",
                        "Color",
                        "File",
                        "Reference",
                        "Folder",
                        "EnumMember",
                        "Constant",
                        "Struct",
                        "Event",
                        "Operator",
                        "TypeParameter",
                        "Text",
                    },
                },
            },

            "hrsh7th/cmp-buffer",

            "FelipeLema/cmp-async-path",
            "hrsh7th/cmp-omni",
            "hrsh7th/cmp-cmdline",
            "f3fora/cmp-spell",
            "saadparwaiz1/cmp_luasnip",

            -- specialty
            {
                "KadoBOT/cmp-plugins",
                opts = {
                    files = { "$XDG_CONFIG_HOME/nvim/plugins" }, -- default
                },
            },
            "hrsh7th/cmp-nvim-lua",
        },
        keys = {
            { ":", mode = { "n", "v" } }, -- also trigger on cmdline
        },
        opts = function()
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
                    ["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete {}, { "i", "c" }),
                    ["<C-x><C-f>"] = cmp.mapping(
                        cmp.mapping.complete {
                            config = {
                                sources = {
                                    { name = "async_path" },
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
                    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete {}, { "i", "c" }),
                    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
                    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
                    ["<C-e>"] = cmp.mapping {
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    },
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
                    ["<CR>"] = cmp.mapping.confirm { select = false },
                    ["<S-CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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
                    { name = "nvim_lsp" },

                    -- { name = "copilot", group_index = 2 },
                    { name = "luasnip" }, -- For luasnip users.

                    -- #### Consider setting these in filetype only ###
                    { name = "crates" },
                    { name = "plugins" },
                    { name = "nvim_lua" },

                    -- OLD:
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
                        -- cmp.config.compare.offset,
                        -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                        cmp.config.compare.exact,
                        require("cmp-lspkind-priority").compare, --cmp.config.compare.kind,
                        cmp.config.compare.score,
                        cmp.config.compare.order,
                        cmp.config.compare.locality,

                        -- copied from cmp-under, but I don't think I need the plugin for this.
                        -- This sorts comparasions which begin with underlines under ones that don't
                        function(entry1, entry2)
                            local _, entry1_under = entry1.completion_item.label:find("^_+")
                            local _, entry2_under = entry2.completion_item.label:find("^_+")
                            entry1_under = entry1_under or 0
                            entry2_under = entry2_under or 0
                            if entry1_under > entry2_under then
                                return false
                            elseif entry1_under < entry2_under then
                                return true
                            end
                        end,
                        cmp.config.compare.recently_used,
                        cmp.config.compare.length,
                        cmp.config.compare.sort_text,
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
                            local strings =
                                vim.split(lspkind.presets.default[vim_item.kind], "%s", { trimempty = true })
                            if strings[1] then
                                vim_item.kind = strings[1] .. " "
                            end
                            local source_mapping = {
                                -- could be blank
                                buffer = "[buf]",
                                async_path = "[path]",
                                cmp_git = "[git]",
                                cmpline = "[cmd]",
                                -- lsp
                                nvim_lsp = "[lsp]",
                                nvim_lsp_signature_help = "[lsp+]",
                                nvim_lua = "[api]",
                                -- weird things
                                copilot = "[cop]",
                                luasnip = "[snip]",
                                omni = "[omni]",
                                cmp_tabnine = "[tab9]",
                                codeium = "[  ]",
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
                    ghost_text = {
                        hl_group = "CmpGhostText",
                    }, -- incompatible with copilot
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

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                view = {
                    entries = { name = "custom", separator = " ⋅ " },
                },
                sources = {
                    { name = "buffer" },
                    { name = "nvim_lsp_document_symbol" },
                },
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        vim_item.kind = ""
                        vim_item.menu = ({
                            buffer = "[buf]",
                            nvim_lsp_document_symbol = "[sym]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                -- view = {
                --     entries = { name = "custom", separator = " ⋅ " },
                -- },
                sources = cmp.config.sources({
                    { name = "async_path" },
                }, {
                    { name = "cmdline" },
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, vim_item)
                        vim_item.kind = ""
                        vim_item.menu = ({
                            async_path = "[path]",
                            cmdline = "[cmd]",
                        })[entry.source.name]
                        return vim_item
                    end,
                },
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
        end,
    },

    -- {
    --     "jcdickinson/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = true,
    -- },
}
