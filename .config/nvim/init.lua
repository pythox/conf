-- plugins
require("plugins")
require("plugins.bufferline")
require("plugins.indent-blankline")
require("plugins.lspconfig")
require("plugins.lspsaga")
require("plugins.lualine")
require("plugins.nvim-autopairs")
require("plugins.nvim-cmp")
require("plugins.nvim-tree")
require("plugins.pounce")
require("plugins.treesitter")
require("plugins.nvim-cursorline")
-- require("plugins.vscode-theme")

-- core
require("core.options")
require("core.keymaps")
require("core.colorscheme")

-- source vim settings
vim.cmd('source ~/.config/nvim/settings.vim')
