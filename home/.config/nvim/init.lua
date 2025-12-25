require("config.options")
require("config.mini-deps")

MiniDeps.add('rose-pine/neovim')
MiniDeps.add('nvim-mini/mini.icons')
MiniDeps.add('nvim-mini/mini.tabline')
MiniDeps.add('nvim-mini/mini.statusline')
MiniDeps.add('nvim-mini/mini.files')
MiniDeps.add('nvim-mini/mini-git')

vim.cmd("colorscheme rose-pine")

require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.statusline').setup()
require('mini.git').setup()

local files = require('mini.files')
files.setup()
vim.keymap.set('n', 'E', files.open)

