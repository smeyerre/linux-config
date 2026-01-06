-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- General Settings
vim.opt.history = 500
vim.opt.autoread = true -- Set to auto read when a file is changed from the outside
vim.opt.updatetime = 300

-- UI Configuration
vim.opt.scrolloff = 7
vim.opt.wildmenu = true
vim.opt.wildignore = {
  "*.o", "*~", "*.pyc",
  "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store"
}
vim.opt.ruler = true
vim.opt.cmdheight = 1
vim.opt.hidden = true
vim.opt.backspace = { "eol", "start", "indent" }
vim.opt.whichwrap:append("<,>,h,l")

-- Search Configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.mat = 2

-- No Sound on Errors
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Appearance
vim.opt.foldcolumn = "1"

-- Colors and Fonts
vim.opt.termguicolors = true

vim.opt.background = "dark"
vim.opt.encoding = "utf8"
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.guifont = "IBM Plex Mono:h14,Hack:h14,Source Code Pro:h12,Bitstream Vera Sans Mono:h11"

-- File and Backup
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Text, Tab, and Indent
vim.opt.expandtab = true 
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2 
vim.opt.linebreak = true
vim.opt.textwidth = 500
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true

-- Clipboard
if vim.fn.has("unnamedplus") == 1 then
    vim.opt.clipboard:append("unnamedplus")
else
    vim.opt.clipboard:append("unnamed")
end

-- Buffer switching behavior
vim.opt.switchbuf = { 'useopen', 'usetab', 'newtab' }
vim.opt.showtabline = 1

-- Always use system python version for python provider
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "onedark" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
