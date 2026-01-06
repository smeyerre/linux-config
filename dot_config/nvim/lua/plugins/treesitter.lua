return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = "all",
        sync_install = false,
        auto_install = false,
        ignore_install = { "ipkg" }, -- Needed for some MacOS issue
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        textobjects = {
          move = {
            enable = true,
            set_jumps = false,
            goto_next_start = {
              ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_previous_start = {
              ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
          },
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["ib"] = { query = "@code_cell.inner", desc = "in block" },
              ["ab"] = { query = "@code_cell.outer", desc = "around block" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sbl"] = "@code_cell.outer",
            },
            swap_previous = {
              ["<leader>sbh"] = "@code_cell.outer",
            },
          },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>", -- start incremental_selection
            node_incremental = "<CR>", -- incremental_selection
            node_decremental = "<BS>", -- decrement selection
            scope_incremental = "<TAB>", -- increment selection to scope
          },
        },
      })
    end
  }
}
