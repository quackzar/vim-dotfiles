local cmp = require("cmp")
local lspkind = require("lspkind")

lspkind.init({
	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	preset = "codicons",
	-- symbol_map = {
	--     Class         = "",
	--     Color         = "",
	--     Constant      = "",
	--     Constructor   = "",
	--     Enum          = "",
	--     EnumMember    = " ",
	--     Event         = " ",
	--     Field         = " ",
	--     File          = " ",
	--     Folder        = " ",
	--     Function      = " ",
	--     Interface     = " ",
	--     Keyword       = " ",
	--     Method        = " ",
	--     Module        = " ",
	--     Operator      = " ",
	--     Property      = " ",
	--     Reference     = " ",
	--     Snippet       = " ",
	--     Struct        = " ",
	--     Text          = " ",
	--     TypeParameter = " ",
	--     Unit          = " ",
	--     Value         = " ",
	--     Variable      = " ",
	-- },
})

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
		["<C-x><C-o>"] = cmp.mapping(cmp.mapping.complete({}), { "i", "c" }),
		["<C-j>"] = cmp.mapping({
			i = function()
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.confirm()
				end
			end,
			c = cmp.mapping.confirm({ select = true }),
		}),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "c" }),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "c" }),
		["<tab>"] = cmp.mapping({
			c = cmp.confirm({ select = true }),
		}),
		["<s-tab>"] = cmp.mapping({
			c = cmp.select_prev_item(),
		}),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "copilot", group_index = 2 },
		{ name = "omni", group_index = 2 },
		{ name = "luasnip", group_index = 2 }, -- For luasnip users.
		{ name = "crates", group_index = 2 },
		{ name = "cmp_tabnine", group_index = 2 },
	}),
	completion = {
		completeopt = "menu,menuone,noinsert,preview,noselect",
		keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
		keyword_length = 1,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. strings[1] .. " "
			local sources = {
				buffer = "BUF",
				nvim_lsp = "LSP",
				copilot = "COP",
				luasnip = "SNIP",
				omni = "OMNI",
				cmp_tabnine = "TAB9",
			}
			local menu = sources[entry.source.name]
			if menu == nil then
				kind.menu = strings[2]
			else
				kind.menu = "[" .. menu .. "]"
			end
			return kind
		end,
	},
	experimental = {
		ghost_text = true, -- incompatible with copilot
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ filetypes = { tex = false } }))

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
		entries = { name = "wildmenu", separator = " ⋅ " },
	},
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	view = {
		entries = { name = "wildmenu", separator = " ⋅ " },
	},
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.(
local highlighting = {
	PmenuSel = { bg = "#282C34", fg = "NONE" },
	Pmenu = { fg = "#C5CDD9", bg = "#22252A" },

	CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
	CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
	CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
	CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },

	CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
	CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
	CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

	CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
	CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
	CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

	CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
	CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
	CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

	CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
	CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

	CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
	CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

	CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
	CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
	CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

	CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
	CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
	CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

	CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
	CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
	CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
}

-- for key, hl in pairs(highlighting) do
--     vim.api.nvim_set_hl(0, key, hl)
-- end
