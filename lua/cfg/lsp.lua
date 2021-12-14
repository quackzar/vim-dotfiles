local lspconfig = require('lspconfig')
local coq = require ("coq")

-- coq_settings.clients.tabnine.enabled=true
require("coq_3p") {
    { src = "copilot", short_name = "COP", tmp_accept_key = "<c-r>" },
    { src = "vimtex", short_name = "vTEX" },
    { src = "nvimlua", short_name = "nLUA", conf_only = true },
    { src = "dap" },
}

-- require("null-ls").config({
--     sources = {
--     },
-- })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  underline = true,
})

local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end

vim.o.completeopt = "menuone,noselect"

local function setup_handlers()
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        update_in_insert = true,
        -- virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
    })

end

function on_attach(client, bufnr)
    require("lsp_signature").on_attach()
    setup_handlers()

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }


    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<C-]>',     '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', opts)
    buf_set_keymap('v', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', opts)
    buf_set_keymap('n', '<space>a',  '<cmd>CodeActionMenu<CR>', opts)
    buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.cmd([[
        augroup DiagnosticFloat
            autocmd!
            autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
        augroup END
    ]])
end

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local server_config = {}
    server_config.on_attach = on_attach

    if server.name == "sumneko_lua" then
    -- only apply these settings for the "sumneko_lua" server
        server_config.settings = {
        Lua = {
            diagnostics = {
            -- Get the language server to recognize the 'vim', 'use' global
            globals = {'vim', 'use', 'require'},
            },
            workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
            enable = false,
            },
        },
        }
    end


    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(server_config)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

require("trouble").setup {
    use_diagnostic_signs = true,
}

-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ", "   (Method)", "   (Function)",
    "   (Constructor)", " ﴲ  (Field)", "[] (Variable)", "   (Class)",
    " ﰮ  (Interface)", "   (Module)", " 襁 (Property)", "   (Unit)",
    "   (Value)", " 練 (Enum)", "   (Keyword)", "   (Snippet)",
    "   (Color)", "   (File)", "   (Reference)", "   (Folder)",
    "   (EnumMember)", " ﲀ  (Constant)", " ﳤ  (Struct)", "   (Event)",
    "   (Operator)", "   (TypeParameter)"
}


vim.fn.sign_define('LightBulbSign', { text = " ", texthl = "DiagnosticSignHint", linehl="", numhl="" })
require('nvim-lightbulb').update_lightbulb {
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
        hl_mode = "replace",
    },
    status_text = {
        enabled = true,
        text = " ",
        text_unavailable = ""
    }
}

vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = 'right',
    width = 25,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = true,
    preview_bg_highlight = 'Pmenu',
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = {"<Esc>", "q"},
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
        File = {icon = " ", hl = "TSURI"},
        Module = {icon = " ", hl = "TSNamespace"},
        Namespace = {icon = "", hl = "TSNamespace"},
        Package = {icon = " ", hl = "TSNamespace"},
        Class = {icon = " ", hl = "TSType"},
        Method = {icon = " ", hl = "TSMethod"},
        Property = {icon = " ", hl = "TSMethod"},
        Field = {icon = " ", hl = "TSField"},
        Constructor = {icon = " ", hl = "TSConstructor"},
        Enum = {icon = " ", hl = "TSType"},
        Interface = {icon = "ﰮ", hl = "TSType"},
        Function = {icon = " ", hl = "TSFunction"},
        Variable = {icon = " ", hl = "TSConstant"},
        Constant = {icon = " ", hl = "TSConstant"},
        String = {icon = " ", hl = "TSString"},
        Number = {icon = "#", hl = "TSNumber"},
        Boolean = {icon = "⊨", hl = "TSBoolean"},
        Array = {icon = "", hl = "TSConstant"},
        Object = {icon = "⦿", hl = "TSType"},
        Key = {icon = " ", hl = "TSType"},
        Null = {icon = "NULL", hl = "TSType"},
        EnumMember = {icon = "", hl = "TSField"},
        Struct = {icon = " ", hl = "TSType"},
        Event = {icon = " ", hl = "TSType"},
        Operator = {icon = " ", hl = "TSOperator"},
        TypeParameter = {icon = " ", hl = "TSParameter"}
    }
}


local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        -- Python
        null_ls.builtins.formatting.black,
        -- null_ls.builtins.formatting.autopep8,
        null_ls.builtins.formatting.isort,
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.pylint,

        -- Shell
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,

        -- Git
        null_ls.builtins.code_actions.gitsigns,

        -- Rust
        null_ls.builtins.formatting.rustfmt,

        -- TeX
        null_ls.builtins.diagnostics.chktex,
    },
    on_attach = function()
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
    end,
})
