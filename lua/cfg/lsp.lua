---@diagnostic disable: lowercase-global, redundant-parameter

local signs = {
    -- nerdfont:
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
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
    signs = true,
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

function on_attach(_client, bufnr)
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
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- HACK: inline on_attach or something
        on_attach(nil, ev.buf)
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        on_attach(ev.client, ev.buf)
    end,
})

-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true,
-- }

local lspconfig = require("lspconfig")
local mason_lsp = require("mason-lspconfig")
mason_lsp.setup {
    ensure_installed = { "lua_ls" },
    automatic_installation = true,
}
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

require("mason-lspconfig").setup_handlers {
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["rust_analyzer"] = function()
        -- handled by rustaceanvim
    end,
    ["clangd"] = function()
        lspconfig.clangd.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            inlay_hints = { enabled = true },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        }
    end,
    ["tinymist"] = function()
        lspconfig.tinymist.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            offset_encoding = "utf-8",
            single_file_support = true,
            root_dir = function()
                return vim.fn.getcwd()
            end,
            settings = {
                compileStatus = "enable",
                formatterMode = "typstyle",
                exportPdf = "onSave",
                preview = {
                    cursorIndicator = true,
                },
            },
        }
    end,
    ["texlab"] = function()
        lspconfig.texlab.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end,
    ["basedpyright"] = function()
        lspconfig.basedpyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                basedpyright = {
                    analysis = {
                        typeCheckingMode = "standard",
                    },
                },
            },
        }
    end,
    ["ts_ls"] = function()
        local mason_registry = require("mason-registry")
        local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
            .. "/node_modules/@vue/language-server"
        lspconfig.ts_ls.setup {
            init_options = {
                plugins = {
                    {
                        -- Name of the TypeScript plugin for Vue
                        name = "@vue/typescript-plugin",

                        -- Location of the Vue language server module (path defined in step 1)
                        location = vue_language_server_path,

                        -- Specify the languages the plugin applies to (in this case, Vue files)
                        languages = { "vue" },
                    },
                },
            },
            filetypes = {
                "typescript",
                "javascript",
                "javascriptreact",
                "typescriptreact",
                "vue",
            },
        }
    end,
    ["volar"] = function()
        lspconfig.volar.setup {
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        }
    end,
    ["harper_ls"] = function()
        lspconfig.harper_ls.setup {
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
            },
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                linters = {
                    spell_check = false,
                },
            },
        }
    end,
    ["ltex"] = function()
        require("ltex_extra").setup {
            server_opts = {
                on_attach = on_attach,
                capabilities = capabilities,
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
    end,
}
