local gl        = require('galaxyline')
local gls       = gl.section
local condition = require('galaxyline.condition')

-- Without this, the status line for inactive window does not change.
-- We use packer anyways, else this would actually be a bug.
gl.short_line_list = {'Packer'}

local colors = {
  line_bg  = '#21242b',
  bg       = '#000000',
  fg       = '#dobfa1',
  yellow   = '#fabd2f',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#afd700',
  orange   = '#FF8800',
  purple   = '#5d4d7a',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67'
}

gls.left[1] = {
  FirstElement = {
    provider  = function() return '▋' end,
    highlight = { colors.bg, colors.line_bg }
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local mode_color = {
        n = colors.magenta, i = colors.green, v = colors.blue, [''] = colors.blue, V = colors.blue,
        c = colors.red, no = colors.magenta, s = colors.orange, S = colors.orange,
        [''] = colors.orange, ic = colors.yellow, R = colors.purple, Rv = colors.purple,
        cv = colors.red, ce = colors.red, r = colors.cyan, rm = colors.cyan, ['r?'] = colors.cyan,
        ['!']  = colors.red, t = colors.red
      }
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim.fn.mode()])
      return '  '
    end,
    highlight = { colors.red, colors.line_bg, 'bold' },
  },
}
gls.left[3] = {
  FileIcon = {
    provider  = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.line_bg },
  },
}
gls.left[4] = {
  FileName = {
    provider  = {'FileName'},
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.line_bg, 'bold' }
  }
}
gls.left[5] = {
  GitIcon = {
    provider  = function() return '  ' end,
    condition = condition.check_git_workspace,
    highlight = { colors.orange, colors.line_bg },
  }
}
gls.left[6] = {
  GitBranch = {
    provider  = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = { colors.fg, colors.line_bg, 'bold' },
  }
}
gls.left[7] = {
  DiffAdd = {
    provider  = 'DiffAdd',
    condition = condition.check_git_workspace and condition.hide_in_width,
    icon      = ' ',
    highlight = { colors.green, colors.line_bg },
  }
}
gls.left[8] = {
  DiffModified = {
    provider  = 'DiffModified',
    condition = condition.check_git_workspace and condition.hide_in_width,
    icon      = ' ',
    highlight = { colors.orange, colors.line_bg },
  }
}
gls.left[9] = {
  DiffRemove = {
    provider  = 'DiffRemove',
    condition = condition.check_git_workspace and condition.hide_in_width,
    icon      = ' ',
    highlight = { colors.red, colors.line_bg },
  }
}
gls.left[10] = {
  LeftEnd = {
    provider            = function() return '' end,
    separator           = '',
    separator_highlight = { colors.bg, colors.line_bg },
    highlight           = { colors.line_bg, colors.line_bg }
  }
}
gls.left[11] = {
  DiagnosticError = {
    provider  = 'DiagnosticError',
    icon      = '  ',
    highlight = { colors.red, colors.bg }
  }
}
gls.left[12] = {
  DiagnosticWarn = {
    provider  = 'DiagnosticWarn',
    icon      = '  ',
    highlight = { colors.yellow, colors.bg },
  }
}
gls.left[13] = {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.orange,colors.bg},
  }
}
gls.left[14] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.cyan,colors.bg},
  }
}

gls.right[1]= {
  FileFormat = {
    provider            = 'FileFormat',
    separator           = '',
    separator_highlight = { colors.bg, colors.line_bg },
    highlight           = { colors.fg, colors.line_bg  },
  }
}
gls.right[2] = {
  LineInfo = {
    provider            = 'LineColumn',
    separator           = ' | ',
    separator_highlight = { colors.blue, colors.line_bg },
    highlight           = { colors.fg, colors.line_bg },
  },
}
gls.right[3] = {
  PerCent = {
    provider            = 'LinePercent',
    separator           = '',
    separator_highlight = { colors.line_bg, colors.line_bg },
    highlight           = { colors.fg, colors.darkblue },
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider            = 'FileTypeName',
    separator           = ' ',
    separator_highlight = { colors.purple, colors.bg },
    highlight           = { colors.fg, colors.purple }
  }
}
gls.short_line_left[2] = {
  WindowNumber = {
    provider            = function() return vim.fn.winnr() end,
    separator           = '',
    separator_highlight = { colors.purple, colors.bg },
    highlight           = { colors.red, colors.bg }
  }
}
gls.short_line_left[3] = {
  FileName = {
    provider            = {'FileName'},
    condition           = condition.buffer_not_empty,
    highlight = { colors.fg, colors.line_bg, 'bold' }
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider            = 'BufferIcon',
    separator           = '',
    separator_highlight = { colors.purple, colors.bg },
    highlight           = { colors.fg, colors.purple }
  }
}
