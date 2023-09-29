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
    signs = true,
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
    -- require("lsp_signature").on_attach({
    --     toggle_key = "<C-S-k>",
    --     bind = true, -- This is mandatory, otherwise border config won't get registered.
    --     handler_opts = {
    --         border = "rounded",
    --     },
    -- }, bufnr)
    --
    -- TODO: Consider this in contrast to manual toggle
    if client.server_capabilities.inlayHintProvider then
        vim.api.nvim_create_augroup("lsp_augroup", { clear = true })
        vim.api.nvim_create_autocmd("InsertEnter", {
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint(bufnr, false)
            end,
            group = "lsp_augroup",
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
            buffer = bufnr,
            callback = function()
                vim.lsp.inlay_hint(bufnr, true)
            end,
            group = "lsp_augroup",
        })
        set_inlay_hl()
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    vim.keymap.set("n", "<space>K", vim.diagnostic.open_float, { buffer = bufnr, desc = "Hover diagnostic (lsp)" })
    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition (lsp)" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration (lsp)" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation (lsp)" })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition (lsp)" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References (lsp)" })
    vim.keymap.set("n", "gO", vim.lsp.buf.outgoing_calls, { buffer = bufnr, desc = "Outgoing calls (lsp)" })
    vim.keymap.set("n", "go", vim.lsp.buf.incoming_calls, { buffer = bufnr, desc = "Incoming calls (lsp)" })
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev { float = false }
    end, { buffer = bufnr, desc = "Prev diagnostic" })
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next { float = false }
    end, { buffer = bufnr, desc = "Next diagnostic" })

    -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
    -- vim.keymap.set({ "n", "v" }, "<space>a", "<cmd>CodeActionMenu<cr>", { buffer = bufnr, desc = "Code action (lsp)" })
    vim.keymap.set({ "v", "n" }, "<space>a", require("actions-preview").code_actions)

    -- vim.keymap.set({"n", "v"}, "<space>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
    --
    -- vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}

local lspconfig = require("lspconfig")
local mason_lsp = require("mason-lspconfig")
require("mason-null-ls").setup {
    automatic_setup = true,
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

mason_lsp.setup {
    ensure_installed = { "lua_ls" }, -- ensure these servers are always installed
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

lspconfig.sourcekit.setup {}

mason_lsp.setup_handlers { -- check if this actually works
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            inlay_hints = { enabled = true },
        }
    end,
    ["rust_analyzer"] = function()
        local rt = require("rust-tools")
        local extension_path = "/Users/mikkel/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib" -- TODO: switch on linux
        rt.setup {
            server = {
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    vim.keymap.set("n", "<localleader>a", rt.hover_actions.hover_actions, { buffer = bufnr })
                    vim.keymap.set("n", "<RightMouse>", rt.hover_actions.hover_actions, { buffer = bufnr })
                end,
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            features = "all",
                            buildScripts = { enable = true },
                        },
                        checkOnSave = {
                            command = "clippy",
                        },
                        completion = {
                            fullFunctionSignatures = { enable = true },
                        },
                    },
                },
            },
            dap = {
                adapters = { require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
            },
            tools = {
                executor = require("rust-tools/executors").toggleterm,
                hover_with_actions = false,
                diagnostics = {
                    disabled = {
                        "inactive-code",
                        "unused_variables",
                    },
                },
                hover_actions = {
                    auto_focus = true,
                },
                inlay_hints = {
                    auto = false,
                },
            },
        }
    end,
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
                    additionalRules = {
                        enablePickyRules = false,
                    },
                    disabledRules = {
                        ["en-US"] = {
                            "TYPOS",
                            "MORFOLOGIK_RULE_EN",
                            "MORFOLOGIK_RULE_EN_US",
                            "EN_QUOTES",
                            "PASSIVE_VOICE",
                        },
                    },
                },
            },
        }
    end,
}

local null_ls = require("null-ls")
null_ls.setup {
    sources = {
        -- Python
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.pylint,
        -- null_ls.builtins.diagnostics.mypy,

        -- Shell
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,

        -- Git
        -- null_ls.builtins.code_actions.gitsigns,

        -- Rust
        null_ls.builtins.formatting.rustfmt,

        -- TeX
        -- null_ls.builtins.diagnostics.chktex,
        null_ls.builtins.formatting.latexindent,
    },
}
