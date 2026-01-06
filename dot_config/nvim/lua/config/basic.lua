-- Key Mappings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Fast saving
map('n', '<leader>w', ':w!<CR>')

-- Search mappings
map('n', '<leader><cr>', ':noh<CR>')

-- Window navigation
map('n', '<C-j>', '<C-W>j')
map('n', '<C-k>', '<C-W>k')
map('n', '<C-h>', '<C-W>h')
map('n', '<C-l>', '<C-W>l')

-- Buffer management
vim.keymap.set('n', '<leader>bd', function()  -- Close current buffer
    -- Save buffer number
    local current = vim.api.nvim_get_current_buf()
    -- Switch to previous buffer
    vim.cmd('bp')
    -- Delete the saved buffer number
    vim.cmd('bd' .. current)
end, { desc = "Delete buffer" })
vim.keymap.set('n', '<leader>ba', ':bufdo bd<CR>', { desc = "Delete all buffers" })
vim.keymap.set('n', '<leader>l', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>h', ':bprevious<CR>', { desc = "Previous buffer" })

-- Tab management
map('n', '<leader>tn', ':tabnew<CR>')
map('n', '<leader>to', ':tabonly<CR>')
map('n', '<leader>tc', ':tabclose<CR>')
map('n', '<leader>tm', ':tabmove')
map('n', '<leader>t<leader>', ':tabnext<CR>')

-- Let 'tl' toggle between this and the last accessed tab
vim.g.lasttab = 1
vim.keymap.set('n', '<leader>tl', function()
  vim.cmd('tabn ' .. vim.g.lasttab)
end)
-- Set up autocmd for storing last accessed tab
vim.api.nvim_create_autocmd('TabLeave', {
  pattern = '*',
  callback = function()
    vim.g.lasttab = vim.fn.tabpagenr()
  end,
})

-- Open new tab with current buffer's path
vim.keymap.set('n', '<leader>te', function()
  local path = vim.fn.escape(vim.fn.expand('%:p:h'), ' ')
  vim.cmd('tabedit ' .. path .. '/')
end)

-- Switch CWD to current buffer's directory
vim.keymap.set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>')

-- Helper Functions
_G.clean_extra_spaces = function()
  local save_cursor = vim.fn.getpos(".")
  local old_query = vim.fn.getreg('/')
  vim.cmd([[silent! %s/\s\+$//e]])
  vim.fn.setpos('.', save_cursor)
  vim.fn.setreg('/', old_query)
end

-- AutoCommands
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.txt", "*.js", "*.py", "*.wiki", "*.sh", "*.coffee" },
  callback = function()
    _G.clean_extra_spaces()
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- Spell Checking Mappings
map('n', '<leader>ss', ':setlocal spell!<CR>') -- Pressing ,ss will toggle and untoggle spell checking
map('n', '<leader>sn', ']s')
map('n', '<leader>sp', '[s')
map('n', '<leader>sa', 'zg')
map('n', '<leader>s?', 'z=')

-- Misc Mappings
map('n', '<leader>pp', ':setlocal paste!<CR>')
--
-- Remove Windows ^M when encodings get messed up
vim.keymap.set('n', '<Leader>m', function()
    local cursor_pos = vim.fn.getpos('.')
    vim.cmd([[%s/\r//ge]])
    vim.fn.setpos('.', cursor_pos)
end, { noremap = true })

-- Quick buffer for scribble
vim.keymap.set('n', '<leader>q', function()
    vim.cmd('edit ~/buffer')
end)

-- Quick markdown buffer for scribble
vim.keymap.set('n', '<leader>x', function()
    vim.cmd('edit ~/buffer.md')
end)

-- Custom Commands
vim.api.nvim_create_user_command('Bclose', function()
  local current_buf = vim.fn.bufnr("%")
  local alternate_buf = vim.fn.bufnr("#")

  if vim.fn.buflisted(alternate_buf) == 1 then
    vim.cmd('buffer #')
  else
    vim.cmd('bnext')
  end

  if vim.fn.bufnr("%") == current_buf then
    vim.cmd('new')
  end

  if vim.fn.buflisted(current_buf) == 1 then
    vim.cmd('bdelete! ' .. current_buf)
  end
end, {})

-- Visual Selection Function
_G.visual_selection = function(direction, extra_filter)
  local saved_reg = vim.fn.getreg('"')
  vim.cmd('normal! vgvy')
  
  local pattern = vim.fn.escape(vim.fn.getreg('"'), '\\/.*$^~[]')
  pattern = string.gsub(pattern, '\n$', '')
  
  if direction == 'gv' then
    vim.fn.feedkeys(string.format(':Ack \'%s\' ', pattern))
  elseif direction == 'replace' then
    vim.fn.feedkeys(string.format('%%s/%s/', pattern))
  end
  
  vim.fn.setreg('/', pattern)
  vim.fn.setreg('"', saved_reg)
end

-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
vim.keymap.set('v', '*', function()
  _G.visual_selection('', '')
  vim.fn.feedkeys('/' .. vim.fn.getreg('/') .. '\r', 'n')
end, { silent = true })

vim.keymap.set('v', '#', function()
  _G.visual_selection('', '')
  vim.fn.feedkeys('?' .. vim.fn.getreg('/') .. '\r', 'n')
end, { silent = true })

-- Visual mode mappings for brackets/quotes
local function visual_map_surround(key, left, right)
  map('v', key, string.format('<esc>`>a%s<esc>`<i%s<esc>', right, left))
end

visual_map_surround('$1', '(', ')')
visual_map_surround('$2', '[', ']')
visual_map_surround('$3', '{', '}')
visual_map_surround('$$', '"', '"')
visual_map_surround('$q', "'", "'")
visual_map_surround('$e', '`', '`')

-- Insert mode auto-complete mappings
local function insert_map_surround(key, surround)
  if type(surround) == "table" then
    map('i', key, surround[1] .. '<esc>o' .. surround[2] .. '<esc>O')
  else
    map('i', key, surround .. '<esc>i')
  end
end

insert_map_surround('$1', '()')
insert_map_surround('$2', '[]')
insert_map_surround('$3', '{}')
insert_map_surround('$4', {'{', '}'})
insert_map_surround('$q', "''")
insert_map_surround('$e', '""')

-- Template for new notebooks
local default_notebook = [[
  {
    "cells": [
     {
      "cell_type": "markdown",
      "metadata": {},
      "source": [
        ""
      ]
     }
    ],
    "metadata": {
     "kernelspec": {
      "display_name": "Python 3",
      "language": "python",
      "name": "python3"
     },
     "language_info": {
      "codemirror_mode": {
        "name": "ipython"
      },
      "file_extension": ".py",
      "mimetype": "text/x-python",
      "name": "python",
      "nbconvert_exporter": "python",
      "pygments_lexer": "ipython3"
     }
    },
    "nbformat": 4,
    "nbformat_minor": 5
  }
]]

local function new_notebook(filename)
    local path = filename .. ".ipynb"
    local file = io.open(path, "w")
    if file then
        file:write(default_notebook)
        file:close()
        vim.cmd("edit " .. path)
    else
        print("Error: Could not open new notebook file for writing.")
    end
end

vim.api.nvim_create_user_command('NewNotebook', function(opts)
    new_notebook(opts.args)
end, {
    nargs = 1,
    complete = 'file'
})
