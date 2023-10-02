local Hydra = require("hydra")

require("hydras.git")
require("hydras.windows")
require("hydras.telescope")
require("hydras.options")
require("hydras.dap")
require("hydras.neotest")
-- require("hydras.refactoring")
require("hydras.neogen")
-- require("hydras.words")

local highlighting = {
    HydraRed = { fg = "#FF5733" },
    HydraBlue = { fg = "#5EBCF6" },
    HydraAmaranth = { fg = "#ff1757" },
    HydraTeal = { fg = "#00a1a1" },
    HydraPink = { fg = "#ff55de" },
}

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("set_hydra_colors", { clear = true }),
    callback = function()
        for key, hl in pairs(highlighting) do
            vim.api.nvim_set_hl(0, key, hl)
        end
    end,
})

Hydra {
    name = "Side scroll",
    mode = "n",
    body = "z",
    heads = {
        { "h", "5zh" },
        { "l", "5zl", { desc = "←/→" } },
        { "H", "zH" },
        { "L", "zL", { desc = "half screen ←/→" } },
    },
}
