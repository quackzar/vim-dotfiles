---@diagnostic disable: lowercase-global, redundant-parameter

local signs = {
    -- nerdfont:
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    -- vim.fn.sign_define(hl, { numhl = hl })
end

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
        end, { buffer = bufnr, desc = "hover (lsp)" })

        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "go to definition (lsp)" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "go to declaration (lsp)" })
        vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "go to implementation (lsp)" })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "go to type definition (lsp)" })
        vim.keymap.set("n", "gO", vim.lsp.buf.outgoing_calls, { buffer = bufnr, desc = "outgoing calls (lsp)" })
        vim.keymap.set("n", "go", vim.lsp.buf.incoming_calls, { buffer = bufnr, desc = "incoming calls (lsp)" })

        -- redundant, as is now mapped to <C-s>
        vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })

        -- hacky mapping to clear-action.nvim
        vim.keymap.set("x", "<C-r><C-r>", "<leader>a", { buffer = bufnr, desc = "code action", remap = true })
        vim.keymap.set("x", "<C-r>r", "<leader>a", { buffer = bufnr, desc = "code action", remap = true })
        vim.keymap.set("n", "crr", "<leader>a", { buffer = bufnr, desc = "code action", remap = true })
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

require("ltex_extra").setup {
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
            --"typst",
        },
        settings = {
            ltex = {
                checkFrequency = "save",
                completionEnabled = false,
                additionalRules = {
                    enablePickyRules = true,
                },
                disabledRules = {
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
    },
}

require("lspconfig").harper_ls.setup {
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
