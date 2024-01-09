---@diagnostic disable: lowercase-global

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = false,
--     underline = true,
--     sign = false,
-- })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

local signs = {
    -- nonicons:
    -- Error = " ",
    -- Warn = " ",
    -- Hint = " ",
    -- Info = " ",
    -- nerdfont:
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    vim.fn.sign_define(hl, { numhl = hl })
end

vim.o.completeopt = "menuone,noselect"

vim.diagnostic.config {
    underline = true,
    signs = false,
    virtual_text = false,
    virtual_lines = { only_current_line = true, highlight_whole_line = false },
    float = {
        show_header = true,
        source = "if_many",
        border = "rounded",
        focusable = false,
    },
    update_in_insert = false, -- default to false
    severity_sort = true, -- default to false
}

function set_inlay_hl()
    local has_hl, hl = pcall(vim.api.nvim_get_hl_by_name, "LspInlayHint", true)
    if has_hl and (hl["foreground"] or hl["background"]) then
        return
    end

    hl = vim.api.nvim_get_hl_by_name("Comment", true)
    local foreground = string.format("#%06x", hl["foreground"] or 0)
    if #foreground < 3 then
        foreground = ""
    end
    hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
    local background = string.format("#%06x", hl["background"] or 0)
    if #background < 3 then
        background = ""
    end

    vim.api.nvim_set_hl(0, "LspInlayHint", { fg = foreground, bg = background })
end

function on_attach(client, bufnr)
    if client.server_capabilities.inlayHintProvider and vim.fn.has("nvim-0.10") == 1 then
        vim.notify(
            "Hello buddy! You seem to be on nvim-0.10 which has support for inlay hints, but it is currently not configured!"
        )
        vim.api.nvim_set_hl(0, "LspInlayHint", { link = "NonText" })
        vim.g.inlay_hints_supported = true
        vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = bufnr,
            callback = function()
                -- vim.lsp.inlay_hint(bufnr, vim.g.inlay_hints)
            end,
            group = "lsp_augroup",
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = bufnr,
            callback = function()
                -- vim.lsp.inlay_hint(bufnr, vim.g.inlay_hints)
            end,
            group = "lsp_augroup",
        })
        --set_inlay_hl()
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
    vim.keymap.set("n", "<space>K", vim.diagnostic.open_float, { buffer = bufnr, desc = "Hover diagnostic (lsp)" })
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition (lsp)" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration (lsp)" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation (lsp)" })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition (lsp)" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References (lsp)" })
    vim.keymap.set("n", "gO", vim.lsp.buf.outgoing_calls, { buffer = bufnr, desc = "Outgoing calls (lsp)" })
    vim.keymap.set("n", "go", vim.lsp.buf.incoming_calls, { buffer = bufnr, desc = "Incoming calls (lsp)" })
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev { float = false }
    end, { buffer = bufnr, desc = "prev diagnostic" })
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next { float = false }
    end, { buffer = bufnr, desc = "next diagnostic" })
    vim.keymap.set("n", "[e", function()
        vim.diagnostic.goto_prev { float = false, severity = vim.diagnostic.severity.ERROR }
    end, { buffer = bufnr, desc = "prev error" })
    vim.keymap.set("n", "]e", function()
        vim.diagnostic.goto_next { float = false, severity = vim.diagnostic.severity.ERROR }
    end, { buffer = bufnr, desc = "next error" })
    vim.keymap.set("n", "[w", function()
        vim.diagnostic.goto_prev { float = false, severity = vim.diagnostic.severity.WARN }
    end, { buffer = bufnr, desc = "prev warning" })
    vim.keymap.set("n", "]w", function()
        vim.diagnostic.goto_next { float = false, severity = vim.diagnostic.severity.WARN }
    end, { buffer = bufnr, desc = "next warning" })
    vim.keymap.set("n", "[h", function()
        vim.diagnostic.goto_prev { float = false, severity = vim.diagnostic.severity.HINT }
    end, { buffer = bufnr, desc = "prev hint" })
    vim.keymap.set("n", "]h", function()
        vim.diagnostic.goto_next { float = false, severity = vim.diagnostic.severity.HINT }
    end, { buffer = bufnr, desc = "next hint" })

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local lspconfig = require("lspconfig")
local mason_lsp = require("mason-lspconfig")
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

mason_lsp.setup {
    ensure_installed = { "lua_ls" }, -- ensure these servers are always installed
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

-- lspconfig.sourcekit.setup {}

mason_lsp.setup_handlers { -- check if this actually works
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            inlay_hints = { enabled = true },
        }
    end,
    -- ["rust_analyzer"] = function()
    --     local extension_path = "/Users/mikkel/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
    --     local codelldb_path = extension_path .. "adapter/codelldb"
    --     local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- TODO: switch on linux
    --     rt.setup {
    --         server = {
    --             on_attach = function(client, bufnr)
    --                 on_attach(client, bufnr)
    --                 vim.keymap.set("n", "<localleader>a", rt.hover_actions.hover_actions, { buffer = bufnr })
    --                 vim.keymap.set("n", "<RightMouse>", rt.hover_actions.hover_actions, { buffer = bufnr })
    --             end,
    --             capabilities = capabilities,
    --             settings = {
    --                 ["rust-analyzer"] = {
    --                     assist = {
    --                         importEnforceGranularity = true,
    --                         importPrefix = "crate",
    --                     },
    --                     inlayHints = { locationLinks = false },
    --                     diagnostics = {
    --                         enable = true,
    --                         experimental = {
    --                             enable = true,
    --                         },
    --                     },
    --                     cargo = {
    --                         features = "all",
    --                         buildScripts = { enable = true },
    --                     },
    --                     check = { command = "clippy" },
    --                     checkOnSave = {
    --                         command = "clippy",
    --                     },
    --                     completion = {
    --                         fullFunctionSignatures = { enable = true },
    --                     },
    --                 },
    --             },
    --         },
    --         dap = {
    --             adapters = { require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
    --         },
    --         tools = {
    --             executor = require("rust-tools/executors").toggleterm,
    --             hover_with_actions = false,
    --             diagnostics = {
    --                 disabled = {
    --                     "inactive-code",
    --                     "unused_variables",
    --                 },
    --             },
    --             hover_actions = {
    --                 auto_focus = true,
    --             },
    --             inlay_hints = {
    --                 auto = false,
    --             },
    --         },
    --     }
    -- end,
    ["typst_lsp"] = function()
        lspconfig.typst_lsp.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                -- exportPdf = "onType",
            },
        }
    end,
    ["ltex"] = function()
        lspconfig.ltex.setup {
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
                -- "typst",
            },
            settings = {
                ltex = {
                    language = "en-US",
                    checkFrequency = "save",
                    completionEnabled = true,
                    additionalRules = {
                        enablePickyRules = true,
                    },
                    disabledRules = {
                        ["en-US"] = {
                            "TYPOS",
                            -- "MORFOLOGIK_RULE_EN",
                            -- "MORFOLOGIK_RULE_EN_US",
                            "EN_QUOTES",
                            "PASSIVE_VOICE",
                        },
                    },
                },
            },
        }
    end,
}
