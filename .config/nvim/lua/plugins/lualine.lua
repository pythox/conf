local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local setup, lsp_status = pcall(require, "lsp-status")
if not setup then
  return
end

local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local LspStatus = function()
  if (#vim.lsp.buf_get_clients() > 0) then
    return lsp_status.status()
  end

  return ''
end

lualine.setup {
  options = {
    icons_enabled = false,
    theme = "base16",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'branch'},
      {
        'diff',
        symbols = { added = '+', modified = '*', removed = '-' },
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.orange },
          removed = { fg = colors.red },
        },
      },
      {
        'diagnostics',
        sources = { 'nvim_diagnostic', 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        diagnostics_color = {
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        symbols = { error = 'E', warn = 'W', info = 'I' , hint = 'H'},
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false,   -- Show diagnostics even if there are none.
      }
    },
    lualine_c = {
      {
        'filename',
        path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
      { 
        LspStatus,
        color = { fg = 'orange' }
      }
    },
    lualine_x = {
      -- {'encoding'},
      {'fileformat'},
      {'filetype'}
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {},
  extensions = {}
}
