local Hydra = require("hydra")

require("cfg.hydras.git")
require("cfg.hydras.windows")
require("cfg.hydras.telescope")
require("cfg.hydras.options")
require("cfg.hydras.dap")
require("cfg.hydras.neotest")

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
