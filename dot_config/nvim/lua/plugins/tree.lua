return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>nn', function() require("nvim-tree.api").tree.toggle() end, desc = "Toggle tree" },
      -- { '<leader>nf', function() require("nvim-tree.api").tree.find_file() end, desc = "Find in tree" },
      { '<leader>nf', function() vim.cmd('NvimTreeFindFile') end, desc = "Find current file in tree" },
    },
    opts = {
      view = {
        width = 30,
      },
      filters = {
        git_ignored = false,
      }
    }
  }
}
