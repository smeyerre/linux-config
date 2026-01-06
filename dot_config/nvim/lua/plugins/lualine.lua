-- COMMENTED OUT: Molten status function disabled
--[[
local function molten_status()
  if vim.bo.filetype == 'python' or vim.bo.filetype == 'markdown' or vim.bo.filetype == 'ipynb' then
    local status = require('molten.status')
    if status.initialized() == 'Molten' then
      local kernels = status.kernels()
      if kernels and kernels ~= "" then
        return '󱐋 Molten {' .. kernels .. '}'
      else
        return '󱐋 Molten'
      end
    end
  end
  return ''
end
--]]

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', optional = true }
    },
    event = "VeryLazy",  -- load when needed
    opts = {
      options = {
        theme = 'onedark',
      },
      sections = {
        lualine_c = {
          {
            'filename',
            path = 1, -- relative path
          }
        },
        lualine_x = {
          -- COMMENTED OUT: molten_status disabled
          -- {
          --   molten_status,
          --   color = { fg = '#c91414' }
          -- },
          'encoding',
          'fileformat',
          'filetype'
        },
      },
      winbar = {
        lualine_c = {
          {
            'filename',
            path = 1,
          }
        }
      },
      inactive_winbar = {
        lualine_c = {
          {
            'filename',
            path = 1,
          }
        }
      }
    }
  }
}
