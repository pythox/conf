local setup, indent_blankline = pcall(require, "ibl")
if not setup then
  return
end

local highlight = {
    "CursorColumn",
    "Whitespace",
}

indent_blankline.setup({
  indent = { highlight = highlight, char = "" },
  scope = { enabled = true }
})
