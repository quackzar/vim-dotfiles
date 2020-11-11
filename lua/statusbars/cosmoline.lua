local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
  bg      = '#232526',
  grey    = '#c0c0c0',
  white   = '#FFFFFF',
  yellow  = '#ffff87',
  purple  = '#af87ff',
  lime    = '#A4E400',
  cyan    = '#62D8F1',
  magenta = '#F92672',
  orange  = '#FF9700',
  pumpkin = '#ef5939',
}
local alias = {
    n = 'Normal',
    i = 'Insert',
    c = 'Command',
    v = 'Visual',
    V= 'V-Line',
    [''] = 'V-Block',
    R='Replace',
    s='Select',
}
local mode_color = {
    n = colors.cyan,
    i = colors.lime,
    v=colors.yellow, [''] = colors.yellow, V=colors.yellow,
    c = colors.purple, cv = colors.purple,ce=colors.purple,
    no = colors.magenta,
    s = colors.orange, S=colors.orange, [''] = colors.orange,
    ic = colors.yellow,
    R = colors.magenta, Rv = colors.magenta,
    r = colors.magenta, rm = colors.magenta, ['r?'] = colors.magenta,
    ['!']  = colors.pumpkin,t = colors.pumpkin
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[#gls.left+1] = {
  Space = {
    provider = function() return ' ' end,
    condition = buffer_not_empty,
    highlight = {colors.bg,colors.bg}
  },
}
-- {{{ MODE
gls.left[#gls.left+1] = {
    ViModeLeft = {
        provider = function()
            vim.api.nvim_command('hi GalaxyViModeLeft guifg='..mode_color[vim.fn.mode()])
            return '' end,
            condition = buffer_not_empty,
        highlight = {colors.bg,colors.bg}
    },
}

gls.left[#gls.left+1] = {
  ViMode = {
    provider = function()
      vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[vim.fn.mode()])
      return alias[vim.fn.mode()]
    end,
    highlight = {colors.bg,colors.bg,'bold'}
  },
}
gls.left[#gls.left+1] = {
    ViModeRight = {
        provider = function()
            vim.api.nvim_command('hi GalaxyViModeRight guifg='..mode_color[vim.fn.mode()])
            return '' end,
            condition = buffer_not_empty,
        highlight = {colors.bg,colors.bg}
    },
}
--- }}}
--
gls.left[#gls.left+1] = {
  Space = {
    provider = function() return ' ' end,
    condition = buffer_not_empty,
    highlight = {colors.bg,colors.bg}
  },
}


gls.left[#gls.left+1] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {
        require('galaxyline.provider_fileinfo').get_file_icon_color,
        colors.bg,
        'bold'
    },
  },
}
gls.left[#gls.left+1] = {
  FileName = {
    provider = {'FileName','FileSize'},
    condition = buffer_not_empty,
    separator = '',
    separator_highlight = {colors.cyan,colors.bg},
    highlight = {colors.pumpkin,colors.bg}
  }
}

gls.left[#gls.left+1] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = {colors.bg,colors.cyan,'bold'},
  }
}
gls.left[#gls.left+1] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = buffer_not_empty,
    highlight = {colors.bg,colors.cyan},
  }
}

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left[#gls.left+1] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.lime,colors.cyan},
  }
}
gls.left[#gls.left+1] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.orange,colors.cyan},
  }
}
gls.left[#gls.left+1] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    highlight = {colors.magenta,colors.cyan},
  }
}
gls.left[#gls.left+1] = {
  LeftEnd = {
    provider = function() return '' end,
    separator = '',
    separator_highlight = {colors.cyan,colors.bg},
    highlight = {colors.purple,colors.cyan}
  }
}
gls.left[#gls.left+1] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.magneta,colors.bg}
  }
}
gls.left[#gls.left+1] = {
  Space = {
    provider = function () return ' ' end
  }
}
gls.left[#gls.left+1] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.pumpkin,colors.bg},
  }
}
gls.right[#gls.right+1]= {
  FileFormat = {
    provider = 'FileFormat',
    separator = '',
    separator_highlight = {colors.magenta,colors.bg},
    highlight = {colors.white,colors.magenta},
  }
}
gls.right[#gls.right+1] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.cyan,colors.magenta},
    highlight = {colors.white,colors.magenta},
  },
}
gls.right[#gls.right+1] = {
  PerCent = {
    provider = 'LinePercent',
    separator = '',
    separator_highlight = {colors.cyan,colors.magenta},
    highlight = {colors.white,colors.cyan},
  }
}
gls.right[#gls.right+1] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.cyan,colors.magenta},
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileName',
    highlight = {colors.pumpkin,colors.bg}
  }
}


gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    separator = '',
    separator_highlight = {colors.magenta,colors.bg},
    highlight = {colors.grey,colors.magenta}
  }
}
