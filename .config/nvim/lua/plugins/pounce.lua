local setup, pounce = pcall(require, "pounce")
if not setup then
  return
end

pounce.setup({
  accept_keys = "jfkdlsahgnuvrbytmiceoxwpqz"
})
