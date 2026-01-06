return {
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    dependencies = {
      'jmbuhr/otter.nvim',
      'neovim/nvim-lspconfig'
    },
    opts = {
      lspFeatures = {
        languages = { "python" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      keymap = {
        hover = "H",
        definition = "gd",
        rename = "<leader>rn",
        references = "gr",
        format = "<leader>gf",
      },
      codeRunner = {
        enabled = false,  -- COMMENTED OUT: molten integration disabled
        -- default_method = "molten",
      },
    },
    keys = {
      { "<localleader>rc", function() require("quarto.runner").run_cell() end, desc = "run cell", silent = true },
      { "<localleader>ra", function() require("quarto.runner").run_above() end, desc = "run cell and above", silent = true },
      { "<localleader>rA", function() require("quarto.runner").run_all() end, desc = "run all cells", silent = true },
      { "<localleader>rl", function() require("quarto.runner").run_line() end, desc = "run line", silent = true },
      { "<localleader>rv", function() require("quarto.runner").run_range() end, mode = "v", desc = "run visual range", silent = true },
      { "<localleader>RA", function() require("quarto.runner").run_all(true) end, desc = "run all cells of all languages", silent = true },
    }
  }
}
