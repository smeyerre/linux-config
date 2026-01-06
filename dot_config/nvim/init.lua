-- Init
-- netrw should be disabled here for nvim-tree
-- ===========================
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- ===========================

require("config.lazy")
require("config.autocmds")
require('config.basic')

