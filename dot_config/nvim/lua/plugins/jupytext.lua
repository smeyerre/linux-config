return {
  {
    'GCBallesteros/jupytext.nvim',
    lazy = false,  -- Important: load at startup
    ft = { 'ipynb', 'markdown' },  -- only load for notebooks
    opts = {
      style = "markdown",
      output_extension = "md",
      force_ft = "markdown"
    },
  }
}
