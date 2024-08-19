-- This file is dedicated to more 'custom' functionality that isn't derived from a plugin
function is_loaded(plugin_name)
    return vim.tbl_get(require("lazy.core.config"), "plugins", plugin_name, "_", "loaded")
end

-- vim.cmd [[au FileType * :lua EnsureTSParserInstalled()]]
