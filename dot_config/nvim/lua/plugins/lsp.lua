local servers = {
  -- Python
  pyright = {
    settings = {
      python = {
        analysis = {
          diagnosticSeverityOverrides = {
            reportUnusedExpression = "none",
          },
          exclude = {
            "**/node_modules",
            "**/__pycache__",
            "**/.*",
            "**/build",
            "**/dist",
          },
          ignore = { "*" },
          useLibraryCodeForTypes = true,
        },
      },
    },
    root_markers = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'pyrightconfig.json',
      '.git'
    },
  },

  -- Rust
  -- TODO: switch to rustaceanvim
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = false,
          loadOutDirsFromCheck = false,
          runBuildScripts = false,
        },
        checkOnSave = true,
        procMacro = {
          enable = true,
        },
        files = {
          excludeDirs = {
            ".git",
            "target",
            "node_modules",
          },
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = false,
          },
        },
      },
    },
  },

  -- JavaScript/TypeScript
  ts_ls = {},

  -- Go
  gopls = {
    root_dir = function(fname)
      local util = require('lspconfig.util')
      return util.root_pattern('go.mod', '.git')(fname) or util.path.dirname(fname)
    end,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },

  -- C/C++
  clangd = {},

  -- CMake
  cmake = {},

  -- Web Development
  html = {},
  cssls = {},
  eslint = {},

  -- GraphQL
  graphql = {},

  -- JSON
  jsonls = {},

  -- Lua
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },

  -- Bash/Shell scripting
  bashls = {},

  -- C#
  omnisharp = {},

  -- SQL
  sqlls = {},

  -- Docker
  dockerls = {},
  docker_compose_language_service = {},

  -- Terraform
  terraformls = {},

  -- YAML
  yamlls = {},
}

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- LSP Support
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    event = { "BufReadPre", "BufNewFile" },  -- lazy load when buffer is read
    config = function()
      -- Setup Mason to automatically install LSP servers
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      -- Setup completion
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- Configure and enable language servers using the new vim.lsp API
      for server, config in pairs(servers) do
        -- Add capabilities to each server config
        config.capabilities = capabilities
        
        -- Use vim.lsp.config to register/customize the server
        vim.lsp.config(server, config)
        
        -- Enable the server with vim.lsp.enable
        vim.lsp.enable(server)
      end

      -- Global diagnostic mappings
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Standard LSP mappings
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = ev.buf, desc = "LSP: Go to declaration" })
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "LSP: Go to definition" })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP: Show hover information" })
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = ev.buf, desc = "LSP: Go to implementation" })
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "LSP: Show signature help" })
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = ev.buf, desc = "LSP: Add workspace folder" })
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = ev.buf, desc = "LSP: Remove workspace folder" })
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { buffer = ev.buf, desc = "LSP: List workspace folders" })
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { buffer = ev.buf, desc = "LSP: Go to type definition" })
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP: Rename symbol" })
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, { buffer = ev.buf, desc = "LSP: Code action" })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "LSP: Find references" })
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, { buffer = ev.buf, desc = "LSP: Format buffer" })

          -- Telescope commands
          vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', { buffer = ev.buf, desc = "LSP: Go to definitions" })
          vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = ev.buf, desc = "LSP: Find references" })
          vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', { buffer = ev.buf, desc = "LSP: Go to implementations" })
          vim.keymap.set('n', '<space>D', '<cmd>Telescope lsp_type_definitions<cr>', { buffer = ev.buf, desc = "LSP: Go to type definitions" })
        end,
      })
    end
  }
}
