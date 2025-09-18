---@diagnostic disable: lowercase-global, redundant-parameter

-- TODO: Add method to populate quickfix with workspace diagnostics
vim.keymap.set("n", "<space>x", vim.diagnostic.setloclist, { desc = "Populate loclist" })

vim.diagnostic.config {
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
    virtual_text = vim.g.virtual_text,
    virtual_lines = vim.g.virtual_lines,
    float = {
        show_header = true,
        source = "if_many",
        border = "rounded",
        focusable = false,
    },
    update_in_insert = false, -- default to false
    severity_sort = true, -- default to false
}

local lspconfig = require("lspconfig")

-- Set global defaults for all servers
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        -- returns configured operations if setup() was already called
        -- or default operations if not
        require("lsp-file-operations").default_capabilities()
    ),
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local bufnr = ev.buf
        vim.api.nvim_set_hl(0, "LspInlayHint", { link = "NonText" })
        if vim.fn.has("nvim-0.10") == 1 then
            vim.lsp.inlay_hint.enable(vim.g.inlay_hints, { bufnr = bufnr })
        end

        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set("n", "K", function()
            local has_ufo, ufo = pcall(require, "ufo")
            local winid = false
            if has_ufo then
                winid = ufo.peekFoldedLinesUnderCursor()
            end
            if not winid then
                vim.lsp.buf.hover()
            end
        end, { buffer = bufnr, desc = "hover" })
        -- Defaults:
        -- grn: rename
        -- gra: code action
        -- grr: references
        -- gri: implementation
        -- gO: document_symbol
        -- Insert mode
        -- <C-S>: signature help
        vim.keymap.set("n", "grr", vim.lsp.buf.references, { buffer = bufnr, desc = "go to references" })
        vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { buffer = bufnr, desc = "go to implementation" })
        vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = bufnr, desc = "rename" })
        vim.keymap.set("n", "gO", vim.lsp.buf.document_symbol, { buffer = bufnr, desc = "document symbol" })

        vim.keymap.set("n", "grd", vim.lsp.buf.definition, { buffer = bufnr, desc = "go to definition" })
        vim.keymap.set("n", "grD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "go to declaration" })
        vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "go to type definition" })
        vim.keymap.set("n", "gro", vim.lsp.buf.outgoing_calls, { buffer = bufnr, desc = "outgoing calls" })
        vim.keymap.set("n", "grO", vim.lsp.buf.incoming_calls, { buffer = bufnr, desc = "incoming calls" })

        vim.keymap.set("n", "gra", function()
            require("tiny-code-action").code_action()
        end, { buffer = bufnr, desc = "code action", remap = true })
        vim.keymap.set("i", "<C-x><C-a>", function()
            require("tiny-code-action").code_action()
        end, { buffer = bufnr, desc = "code action", remap = true })
    end,
})

require("neodev").setup {
    library = { plugins = { "neotest" }, types = true },
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            hint = {
                enable = true,
            },
        },
    },
}

require("lspconfig").ltex_plus.setup {
    autostart = true,
    server_opts = {
        filetypes = {
            "bib",
            "gitcommit",
            "markdown",
            "org",
            "plaintex",
            "rst",
            "rnoweb",
            "tex",
            "pandoc",
            "typst",
        },
    },
    on_attach = function(_, bufnr)
        require("ltex-utils").on_attach(bufnr)
    end,
    settings = {
        ltex = {
            language = "da-DK",
            checkFrequency = "save",
            completionEnabled = false,
            additionalRules = {
                enablePickyRules = true,
            },
            disabledRules = {
                ["da-DK"] = {
                    "COMMA_PARENTHESIS_WHITESPACE",
                    "UPPERCASE_SENTENCE_START",
                },
                ["en-US"] = {
                    "TYPOS",
                    "MORFOLOGIK_RULE_EN",
                    "MORFOLOGIK_RULE_EN_US",
                    "EN_QUOTES",
                    "PASSIVE_VOICE",
                    "REP_PASSIVE_VOICE",
                    "WHITESPACE_RULE",
                },
            },
        },
    },
}

require("lspconfig").harper_ls.setup {
    autostart = false,
    server_opts = {
        filetypes = {
            "typst",
            "tex",
            "markdown",
            "rust",
        },
    },
    settings = {
        ["harper-ls"] = {
            userDictPath = "",
            fileDictPath = "",
            linters = {
                SpellCheck = false,
                SpelledNumbers = false,
                AnA = true,
                SentenceCapitalization = true,
                UnclosedQuotes = true,
                WrongQuotes = false,
                LongSentences = true,
                RepeatedWords = true,
                Spaces = true,
                Matcher = true,
                CorrectNumberSuffix = true,
            },
            codeActions = {
                ForceStable = false,
            },
            markdown = {
                IgnoreLinkTitle = false,
            },
            diagnosticSeverity = "hint",
            isolateEnglish = false,
            dialect = "American",
        },
    },
}
require("lspconfig").sourcekit.setup {}

require("lspconfig").tinymist.setup {
    autostart = false,
    settings = {
        tinymist = {
            lint = {
                enabled = true,
            },
        },
    },
}
