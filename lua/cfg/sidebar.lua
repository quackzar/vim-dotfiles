require("sidebar-nvim").setup({
    disable_default_keybindings = 0,
    bindings = { ["q"] = function() require("sidebar-nvim").close() end },
    open = false,
    side = "left",
    initial_width = 35,
    hide_statusline = true,
    update_interval = 1000,
    sections = { "datetime", "git", "diagnostics", "symbols"},
    section_separator = "-----",
    containers = {
        attach_shell = "/bin/sh", show_all = true, interval = 5000,
    },
    datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
    disable_closing_prompt = false,
    symbols = {
        icon = "ƒ",
    },
    ["git"] = {
        icon = "",
    },
    ["diagnostics"] = {
        icon = "",
    },
    todos = {
        icon = "",
        ignored_paths = {'~'}, -- ignore certain paths, this will prevent huge folders like $HOME to hog Neovim with TODO searching
        initially_closed = false, -- whether the groups should be initially closed on start. You can manually open/close groups later.
    }
})
