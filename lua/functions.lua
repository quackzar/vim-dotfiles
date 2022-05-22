function OpenURIUnderCursor()
    local function open_uri(uri)
        if type(uri) ~= 'nil' then
            uri = string.gsub(uri, "#", "\\#") --double escapes any # signs
            uri = '"' .. uri .. '"'
            vim.cmd('!xdg-open ' .. uri .. ' > /dev/null')
            vim.cmd('mode')
            -- print(uri)
            return true
        else
            return false
        end
    end

    local word_under_cursor = vim.fn.expand("<cWORD>")

    -- any uri with a protocol segment
    local regex_protocol_uri = "%a*:%/%/[%a%d%#%[%]%-%%+:;!$@/?&=_.,~*()]*"
    if (open_uri(string.match(word_under_cursor, regex_protocol_uri))) then return end

    -- consider anything that looks like string/string a github link
    local regex_plugin_url = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"
    if (open_uri('https://github.com/' .. string.match(word_under_cursor, regex_plugin_url))) then return end
end

vim.api.nvim_create_user_command('OpenURIUnderCursor', OpenURIUnderCursor, {})


--- returns a table containing the lsp changes counts from an lsp result
function count_lsp_res_changes(lsp_res)
    local count = { instances = 0, files = 0 }
    if (lsp_res.documentChanges) then
        for _, changed_file in pairs(lsp_res.documentChanges) do
            count.files = count.files + 1
            count.instances = count.instances + #changed_file.edits
        end
    elseif (lsp_res.changes) then
        for _, changed_file in pairs(lsp_res.changes) do
            count.instances = count.instances + #changed_file
            count.files = count.files + 1
        end
    end
    return count
end

function LspRename()
    local curr_name = vim.fn.expand("<cword>")
    local input_opts = {
        prompt = 'LSP Rename',
        default = curr_name
    }

    -- ask user input
    vim.ui.input(input_opts, function(new_name)
        -- check new_name is valid
        if not new_name or #new_name == 0 or curr_name == new_name then return end

        -- request lsp rename
        local params = vim.lsp.util.make_position_params()
        params.newName = new_name

        vim.lsp.buf_request(0, "textDocument/rename", params, function(_, res, ctx, _)
            if not res then return end

            -- apply renames
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            vim.lsp.util.apply_workspace_edit(res, client.offset_encoding)

            -- display a message
            local changes = count_lsp_res_changes(res)
            local message = string.format("renamed %s instance%s in %s file%s. %s",
                changes.instances,
                changes.instances == 1 and '' or 's',
                changes.files,
                changes.files == 1 and '' or 's',
                changes.files > 1 and "To save them run ':wa'" or ''
            )
            vim.notify(message)
        end)
    end)
end

vim.api.nvim_create_user_command('LspRename', LspRename, {})

local ask_install = {}

-- function EnsureTSParserInstalled()
--     local parsers = require 'nvim-treesitter.parsers'
--     local lang = parsers.get_buf_lang()

--     if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
--         vim.schedule_wrap(function()

--             local is_confirmed = false
--             -- TODO: implement a Y/n prompt util func
--             print('Install treesitter parser for ' .. lang .. ' ? Y/n')
--             local res = U.get_char_input()
--             if res:match('\r') then is_confirmed = true end
--             if res:match('y') then is_confirmed = true end
--             if res:match('Y') then is_confirmed = true end
--             U.clear_prompt()

--             if (is_confirmed) then
--                 vim.cmd('TSInstall ' .. lang)
--             else
--                 ask_install[lang] = false
--             end
--         end)()
--     end
-- end

-- TODO: convert to auto group
-- vim.cmd [[au FileType * :lua EnsureTSParserInstalled()]]
