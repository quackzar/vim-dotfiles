-- File containing custom global option definitions
-- TODO: include in SHADA

local ERROR = vim.diagnostic.severity.ERROR
local WARN = vim.diagnostic.severity.WARN
local HINT = vim.diagnostic.severity.HINT
local INFO = vim.diagnostic.severity.INFO

vim.g.diagnostic_signs_default = {
    text = {
        [ERROR] = "",
        [WARN] = "",
        [HINT] = "",
        [INFO] = "",
    },
    numhl = {
        [ERROR] = "DiffDelete",
        [WARN] = "DiffChanged",
        [HINT] = "DiffAdd",
        [INFO] = "DiagnosticSignInfo",
    },
}

vim.g.diagnostic_signs = vim.g.diagnostic_signs

local diagnostic = vim.diagnostic
vim.g.virtual_text_default = {
    -- current_line = true,
    prefix = function(message)
        if message.severity == diagnostic.severity.ERROR then
            return " "
        elseif message.severity == diagnostic.severity.WARN then
            return ""
        elseif message.severity == diagnostic.severity.INFO then
            return ""
        else
            return ""
        end
    end,
    spacing = 2,
    severity = {
        min = vim.diagnostic.severity.INFO,
    },
}

-- level 3
vim.g.virtual_lines = false
vim.g.virtual_text = false
vim.g.diagflow = false
vim.g.tinydiag = true

vim.g.inlay_hints = true
