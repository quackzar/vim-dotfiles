-- # This file is dedicated to keep track of custom treesitter parsers.
-- Thus they can easily be installed by the normal `TSInstall <parser>`

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.vhs = {
    install_info = {
        url = "https://github.com/charmbracelet/tree-sitter-vhs.git", -- local path or git repo
        files = { "src/parser.c" },
        -- optional entries:
        branch = "main", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "vhs", -- if filetype does not match the parser name
}

parser_config.typst = {
    install_info = {
        url = "https://github.com/SeniorMars/tree-sitter-typst.git", -- local path or git repo
        files = { "src/parser.c", "src/scanner.c" },
        -- optional entries:
        branch = "main", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    },
    filetype = "typst", -- if filetype does not match the parser name
}
