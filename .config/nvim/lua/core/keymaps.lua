vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

--general keymaps
keymap.set("i", "jk", "<ESC>")
keymap.set("n", ";", ":")

--search
keymap.set("n", "<Leader>nh", ":nohl<CR>")

--split management
keymap.set("n", "<Leader>sv", "<C-w>v") -- split vertically
keymap.set("n", "<Leader>sh", "<C-w>s") -- split horizontally
keymap.set("n", "<Leader>se", "<C-w>=") -- make splits equal
keymap.set("n", "<Leader>sx", ":close<CR>") -- close split
keymap.set("n", "<Leader>sm", ":MaximizerToggle<CR>") -- maximize split

--tab management
keymap.set("n", "<Leader>to", ":tabnew<CR>") -- new tab
keymap.set("n", "<Leader>tx", ":tabclose<CR>") -- close tab
keymap.set("n", "<Leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<Leader>tp", ":tabp<CR>") -- previous tab

--nvim-tree
keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>")

--telescope
keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>fg", "<cmd>Telescope git_status<cr>") -- list available help tags

--pounce
keymap.set("n", "s", "<cmd>Pounce<CR>")
keymap.set("n", "S", "<cmd>PounceRepeat<CR>")

-- oscyank
keymap.set("v", "<leader>c", ":OSCYank<CR>")

--lsp
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
