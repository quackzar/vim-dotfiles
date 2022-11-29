---@diagnostic disable: lowercase-global

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    "   (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)",
}

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

    if client.server_capabilities.documentSymbolProvider then
        require("nvim-navic").attach(client, bufnr)
    end

    -- if client.server_capabilities.signatureHelpProvider then
    --     require("lsp-overloads").setup(client, {
    --         ui = {
    --             -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
    --             border = "double",
    --         },
    --         keymaps = {
    --             next_signature = "<C-x><C-l>",
    --             previous_signature = "<C-k>",
    --             next_parameter = "<C-l>",
    --             previous_parameter = "<C-x><C-h>",
    --         },
    --     })
    -- end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature help" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover" })
    vim.keymap.set("n", "<space>K", vim.diagnostic.open_float, { buffer = bufnr, desc = "Hover diagnostic" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition,      { buffer = bufnr, desc = "Go to definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration,     { buffer = bufnr, desc = "Go to declaration" })
    vim.keymap.set("n", "gI", vim.lsp.buf.implementation,  { buffer = bufnr, desc = "Go to implementation" })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references,      { buffer = bufnr, desc = "References" })
    vim.keymap.set("n", "gO", vim.lsp.buf.outgoing_calls,  { buffer = bufnr, desc = "Outgoing calls" })
    vim.keymap.set("n", "go", vim.lsp.buf.incoming_calls,  { buffer = bufnr, desc = "Incoming calls" })
    -- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
    vim.keymap.set({"n", "v"}, "<space>a", "<cmd>CodeActionMenu<cr>", { buffer = bufnr, desc = "Code action" })
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

require("mason").setup()
local lspconfig = require("lspconfig")
local mason_lsp = require("mason-lspconfig")
require("neodev").setup({})

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
        rt.setup {
            server = {
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
                capabilities = capabilities,
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            features = "all",
                            buildScripts = { enable = true },
                        },
                        checkOnSave = {
                            command = "clippy"
                        }
                    }
                }
            },
            tools = {
                autoSetHints = true,
                hover_with_actions = false,
                diagnostics = {
                    disabled = {
                        "inactive-code",
                        "unused_variables"
                    },
                },
                inlay_hints = {
                    show_parameter_hints = true,
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
    on_attach = function()
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
    end,
}

vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = "right",
    width = 25,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = "Pmenu",
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
    symbols = {
        File = { icon = " ", hl = "TSURI" },
        Module = { icon = " ", hl = "TSNamespace" },
        Namespace = { icon = "", hl = "TSNamespace" },
        Package = { icon = " ", hl = "TSNamespace" },
        Class = { icon = " ", hl = "TSType" },
        Method = { icon = " ", hl = "TSMethod" },
        Property = { icon = " ", hl = "TSMethod" },
        Field = { icon = " ", hl = "TSField" },
        Constructor = { icon = " ", hl = "TSConstructor" },
        Enum = { icon = " ", hl = "TSType" },
        Interface = { icon = "ﰮ", hl = "TSType" },
        Function = { icon = " ", hl = "TSFunction" },
        Variable = { icon = " ", hl = "TSConstant" },
        Constant = { icon = " ", hl = "TSConstant" },
        String = { icon = " ", hl = "TSString" },
        Number = { icon = "#", hl = "TSNumber" },
        Boolean = { icon = "⊨", hl = "TSBoolean" },
        Array = { icon = "", hl = "TSConstant" },
        Object = { icon = "⦿", hl = "TSType" },
        Key = { icon = " ", hl = "TSType" },
        Null = { icon = "NULL", hl = "TSType" },
        EnumMember = { icon = "", hl = "TSField" },
        Struct = { icon = " ", hl = "TSType" },
        Event = { icon = " ", hl = "TSType" },
        Operator = { icon = " ", hl = "TSOperator" },
        TypeParameter = { icon = " ", hl = "TSParameter" },
    },
}
