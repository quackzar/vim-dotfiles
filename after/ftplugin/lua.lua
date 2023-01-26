require("nvim-surround").buffer_setup {
    surrounds = {
        ["F"] = {
            add = function()
                return { { "function() " }, { " end" } }
            end,
        },
    },
}
