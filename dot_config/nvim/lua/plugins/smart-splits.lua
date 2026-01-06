return {
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false, -- Load immediately for seamless navigation
    opts = {
      -- Integrate with Zellij
      multiplexer_integration = 'zellij',
      -- Don't wrap around when at the edge
      at_edge = 'stop',
    },
    keys = {
      -- Moving between splits
      { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = "Move to left split" },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = "Move to bottom split" },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = "Move to top split" },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = "Move to right split" },

      -- Resizing splits
      { '<A-h>', function() require('smart-splits').resize_left() end, desc = "Resize split left" },
      { '<A-j>', function() require('smart-splits').resize_down() end, desc = "Resize split down" },
      { '<A-k>', function() require('smart-splits').resize_up() end, desc = "Resize split up" },
      { '<A-l>', function() require('smart-splits').resize_right() end, desc = "Resize split right" },
    },
  }
}
