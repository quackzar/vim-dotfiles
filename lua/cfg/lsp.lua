---@diagnostic disable: lowercase-global

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.fn.sign_define("LightBulbSign", { text = " ", texthl = "DiagnosticSignHint", linehl = "", numhl = "" })
require("nvim-lightbulb").update_lightbulb {
    sign = {
        enabled = true,
        priority = 1,
    },
    float = {
        enabled = true,
        text = " ",
    },
    virtual_text = {
        enabled = true,
        text = " ",
        hl_mode = "blend",
    },
    status_text = {
        enabled = true,
        text = " ",
        text_unavailable = "",
    },
}

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
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
    virtual_lines = true,
    float = {
        show_header = true,
        source = "if_many",
        border = "rounded",
        focusable = false,
    },
    update_in_insert = true, -- default to false
    severity_sort = true, -- default to false
}

function on_attach(client, bufnr)
    require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "rounded",
        },
    }, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
    vim.keymap.set("n", "<space>K", vim.diagnostic.open_float, { buffer = bufnr, desc = "Hover diagnostic" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
    vim.keymap.set("n", "gO", vim.lsp.buf.outgoing_calls, { buffer = bufnr, desc = "Outgoing calls" })
    vim.keymap.set("n", "go", vim.lsp.buf.incoming_calls, { buffer = bufnr, desc = "Incoming calls" })
    -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
    vim.keymap.set({ "n", "v" }, "<space>a", "<cmd>CodeActionMenu<cr>", { buffer = bufnr, desc = "Code action" })
    -- vim.keymap.set({"n", "v"}, "<space>a", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Prev diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
    -- vim.keymap.set("n", "<space>rf", vim.lsp.buf.formatting, { buffer = bufnr, desc = "Format buffer" })

    vim.keymap.set(
        "n",
        "<space>wa",
        vim.lsp.buf.add_workspace_folder,
        { buffer = bufnr, desc = "Add workspace folder" }
    )
    vim.keymap.set(
        "n",
        "<space>wr",
        vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = "Remove workspace folder" }
    )
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders))
    end, { buffer = bufnr, desc = "list workspace folders" })
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
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
        },
    },
}

mason_lsp.setup {
    ensure_installed = { "sumneko_lua" }, -- ensure these servers are always installed
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
}

mason_lsp.setup_handlers { -- check if this actually works
    function(server_name)
        lspconfig[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
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
                    show_parameter_hints = false,
                    parameter_hints_prefix = "← ",
                    other_hints_prefix = "» ",
                },
            },
        }
    end,
    ["ltex"] = function()
        lspconfig.ltex.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                ltex = {
                    language = "en-US",
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
