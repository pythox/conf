require'nvim-treesitter.install'.compilers = {"/opt/cross/el8.5-x86_64/gcc-12.1.0/bin/cc"}

-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
  ensure_installed = { "c", "cpp", "lua", "vim", "python", "proto", "json" },
  sync_install = true,
  ignore_install = {"all"},
	highlight = {
		enable = true,
    disable = {""},
    additional_vim_regex_highlighting = true
	},
	indent = { enable = true, disable = {"yaml"} },
	auto_install = true
})
