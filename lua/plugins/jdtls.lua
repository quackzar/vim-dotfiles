-- Shamelessly stolen and adapted
-- TODO: Find a better way to source lombok
-- and use proper the mason api to find jdtls.
return {
    {
        "mfussenegger/nvim-jdtls",
        url = "https://codeberg.org/mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local jdtls = require("jdtls")
            local home = os.getenv("HOME")

            -- Path to Lombok jar - download from https://projectlombok.org/downloads/lombok.jar
            local lombok_path = home .. "/.local/bin/lombok.jar"

            -- Path to jdtls installation
            local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls/"

            -- Workspace path - one per project
            local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            local workspace_dir = home .. "/.local/share/nvim/jdtls-workspace/" .. project_name

            local notify = vim.notify
            local ok, fidget = pcall(require, "fidget")
            if ok then
                notify = fidget.notify
            end

            -- Verify lombok exists
            if vim.fn.filereadable(lombok_path) == 0 then
                notify("Lombok jar not found at: " .. lombok_path, vim.log.levels.ERROR)
            else
                notify("Lombok jar found at: " .. lombok_path, vim.log.levels.INFO)
            end

            local config = {
                cmd = {
                    "java",
                    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
                    "-Dosgi.bundles.defaultStartLevel=4",
                    "-Declipse.product=org.eclipse.jdt.ls.core.product",
                    "-Dlog.protocol=true",
                    "-Dlog.level=ALL",
                    "-Xmx1g",
                    "--add-modules=ALL-SYSTEM",
                    "--add-opens",
                    "java.base/java.util=ALL-UNNAMED",
                    "--add-opens",
                    "java.base/java.lang=ALL-UNNAMED",
                    -- Add Lombok as a javaagent
                    "-javaagent:" .. lombok_path,
                    "-jar",
                    vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
                    "-configuration",
                    jdtls_path .. "/config_linux",
                    "-data",
                    workspace_dir,
                },
                settings = {
                    java = {
                        eclipse = {
                            downloadSources = true,
                        },
                        configuration = {
                            updateBuildConfiguration = "interactive",
                        },
                        maven = {
                            downloadSources = true,
                        },
                        implementationsCodeLens = {
                            enabled = true,
                        },
                        referencesCodeLens = {
                            enabled = true,
                        },
                    },
                },
                init_options = {
                    bundles = {},
                },
            }

            jdtls.start_or_attach(config)
        end,
    },
}
