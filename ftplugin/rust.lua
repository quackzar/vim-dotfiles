vim.bo.makeprg="cargo build"
vim.bo.textwidth=100

vim.keymap.set("n", "<C-K>", require'rust-tools'.hover_actions.hover_actions)

vim.keymap.set("v", "<C-K>", require'rust-tools'.hover_range.hover_range)

