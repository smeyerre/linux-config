-- COMMENTED OUT: Molten plugin not behaving well with current codebase
-- To re-enable, uncomment this entire block
--[[
return {
  {
    'benlubas/molten-nvim',
    dependencies = {
      '3rd/image.nvim',
      -- 'nvim-treesitter',
      -- 'GCBallesteros/jupytext.nvim',  -- add this to ensure correct load order
    },
    build = ':UpdateRemotePlugins',
    ft = { 'python', 'markdown', 'ipynb' },  -- lazy load for these filetypes
    config = function()
      vim.g.molten_image_provider = "image.nvim"
      -- I find auto open annoying, keep in mind setting this option will require setting
      -- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
      vim.g.molten_auto_open_output = false
      -- optional, I like wrapping. works for virt text and the output window
      vim.g.molten_wrap_output = true
      -- Output as virtual text. Allows outputs to always be shown, works with images, but can
      -- be buggy with longer images
      vim.g.molten_virt_text_output = true
      -- this will make it so the output shows up below the ``` cell delimiter
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_max_lines = 36
      vim.g.molten_use_border_highlights = true
      vim.api.nvim_set_hl(0, "MoltenVirtualText", { link = "Type" })
      vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { link = "DiagnosticError" })
    end,
    keys = {  -- define keymaps
      { "<localleader>e", ":MoltenEvaluateOperator<CR>", desc = "evaluate operator", silent = true },
      { "<localleader>os", ":noautocmd MoltenEnterOutput<CR>", desc = "open output window", silent = true },
      { "<localleader>rr", ":MoltenReevaluateCell<CR>", desc = "re-eval cell", silent = true },
      { "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", mode = "v", desc = "execute visual selection", silent = true },
      { "<localleader>oh", ":MoltenHideOutput<CR>", desc = "close output window", silent = true },
      { "<localleader>md", ":MoltenDelete<CR>", desc = "delete Molten cell", silent = true },
      { "<localleader>mx", ":MoltenOpenInBrowser<CR>", desc = "open output in browser", silent = true },
      { "<localleader>nc", function()
        local save_pos = vim.fn.getpos('.')
        local old_search = vim.fn.getreg('/')
        local found = vim.fn.search('^```$', 'W')
        if found == 0 then
          vim.fn.setpos('.', save_pos)
        else
          if vim.fn.line('.') == vim.fn.line('$') then
            vim.api.nvim_put({'', ''}, 'l', true, true)
          else
            vim.cmd('normal! j')
          end
        end
        vim.api.nvim_put({'', '```python', '', '```', ''}, 'l', false, true)
        vim.cmd('normal! k2k0')
        vim.fn.setreg('/', old_search)
        vim.cmd('nohlsearch')
      end, desc = "Add code cell below" },
    }
  }
}
--]]

return {}
