local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
  return
end

local setup, lsp_status = pcall(require, "lsp-status")
if not setup then
  return
end

local keymap = vim.keymap -- for conciseness

lsp_status.config {
  current_function = false,
  show_filename = false,
  diagnostics = false,
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
  status_symbol = ''
}

vim.diagnostic.config({
    virtual_text = {
      prefix = '●', -- Could be '■', '▎', 'x'
    },
    severity_sort = true,
    float = {
      source = "always",  -- Or "if_many"
    },
  })

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  lsp_status.on_attach(client) 

  -- set keybinds
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
  keymap.set("n", "hh", "<cmd>ClangdSwitchSourceHeader<CR>", opts) -- switch header
  keymap.set('v', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- used to enable autocompletion (assign to every lsp server config)
-- local capabilities = cmp_nvim_lsp.default_capabilities()
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_extend(
  'keep',
  lsp_defaults.capabilities,
  lsp_status.capabilities,
  cmp_nvim_lsp.default_capabilities()
)

-- CLANGD
lspconfig["clangd"].setup({
  handlers = lsp_status.extensions.clangd.setup(),
  init_options = {
    clangdFileStatus = true
  },
  on_attach = on_attach,
  capabilities = lsp_defaults.capabilities,
  filetypes = { 'c', 'cpp' },
  cmd = {
            "clangd",
            "-j=8", 
            "--pch-storage=memory",
            "--malloc-trim",
            "--limit-results=25",
            "--limit-references=25",
            "--query-driver=/opt/cross/el8.5-x86_64/clang-13.0.1/bin/*"
        }
})

-- PYTHON
local root_pattern = require('lspconfig.util').root_pattern
lspconfig['jedi_language_server'].setup {
  capabilities = lsp_defaults.capabilities,
  on_attach = on_attach,
  root_dir = root_pattern('/src/bigtop/build')
}
