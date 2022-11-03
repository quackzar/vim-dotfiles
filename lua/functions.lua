-- https://github.com/Alexis12119/nvim-config/blob/master/lua/user/core/utils.lua
local command = vim.api.nvim_create_user_command

function _G.recompile()
  if vim.bo.buftype == "" then
    if vim.fn.exists ":LspStop" ~= 0 then
      vim.cmd "LspStop"
    end

    for name, _ in pairs(package.loaded) do
      if name:match "^user" then
        package.loaded[name] = nil
      end
    end

    dofile(vim.env.MYVIMRC)
    vim.cmd "PackerCompile"
    vim.notify("Wait for Compile Done", vim.log.levels.INFO)
  else
    vim.notify("Not available in this window/buffer", vim.log.levels.INFO)
  end
end

function _G.format_code()
  return vim.lsp.buf.format({ async = true })
end

function _G.set_highlights(highlight)
  for name, colors in pairs(highlight) do
    if not vim.tbl_isempty(colors) then
      vim.api.nvim_set_hl(0, name, colors)
    end
  end
end

function _G.set_option(options)
  for name, value in pairs(options) do
    vim.opt[name] = value
  end
end

function _G.set_global(globals)
  for name, value in pairs(globals) do
    vim.g[name] = value
  end
end

function _G.update_config()
  local args = "git -C " .. vim.fn.stdpath "config" .. " pull --ff-only"
  vim.fn.system(args)
end

command("Format", function()
  format_code()
end, { nargs = "*" })

command("Recompile", function()
  recompile()
end, { nargs = "*" })

command("Update", function()
  update_config()
  vim.notify("Update Done", vim.log.levels.INFO)
end, { nargs = "*" })
-- vim.cmd [[au FileType * :lua EnsureTSParserInstalled()]]
