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

local fn = vim.fn

function _G.qftf(info)
    local items
    local ret = {}
    -- The name of item in list is based on the directory of quickfix window.
    -- Change the directory for quickfix window make the name of item shorter.
    -- It's a good opportunity to change current directory in quickfixtextfunc :)
    --
    -- local alterBufnr = fn.bufname('#') -- alternative buffer is the buffer before enter qf window
    -- local root = getRootByAlterBufnr(alterBufnr)
    -- vim.cmd(('noa lcd %s'):format(fn.fnameescape(root)))
    --
    if info.quickfix == 1 then
        items = fn.getqflist({id = info.id, items = 0}).items
    else
        items = fn.getloclist(info.winid, {id = info.id, items = 0}).items
    end
    local limit = 31
    local fnameFmt1, fnameFmt2 = '%-' .. limit .. 's', '…%.' .. (limit - 1) .. 's'
    local validFmt = '%s │%5d:%-3d│%s %s'
    for i = info.start_idx, info.end_idx do
        local e = items[i]
        local fname = ''
        local str
        if e.valid == 1 then
            if e.bufnr > 0 then
                fname = fn.bufname(e.bufnr)
                if fname == '' then
                    fname = '[No Name]'
                else
                    fname = fname:gsub('^' .. vim.env.HOME, '~')
                end
                -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
                if #fname <= limit then
                    fname = fnameFmt1:format(fname)
                else
                    fname = fnameFmt2:format(fname:sub(1 - limit))
                end
            end
            local lnum = e.lnum > 99999 and -1 or e.lnum
            local col = e.col > 999 and -1 or e.col
            local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
            str = validFmt:format(fname, lnum, col, qtype, e.text)
        else
            str = e.text
        end
        table.insert(ret, str)
    end
    return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'

-- vim.cmd [[au FileType * :lua EnsureTSParserInstalled()]]
