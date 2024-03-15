vim.g.mapleader = " "

vim.keymap.set("n", "<Leader>w", ":<C-u>write<Cr>")
vim.keymap.set("n", "<Leader>q", ":<C-u>quit<Cr>")
vim.keymap.set("n", "<Leader>b", "<C-^>")

vim.keymap.set("n", "wh", "<C-w>h")
vim.keymap.set("n", "wj", "<C-w>j")
vim.keymap.set("n", "wk", "<C-w>k")
vim.keymap.set("n", "wl", "<C-w>l")

vim.keymap.set("n", "+", "4<C-w>+")
vim.keymap.set("n", "-", "4<C-w>-")
vim.keymap.set("n", "{", "4<C-w><")
vim.keymap.set("n", "}", "4<C-w>>")

vim.keymap.set("n", "<Leader>l", ":lua ReloadConfig()<Cr>")

function ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match('^config') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end


-- telescope
local telescope = require('telescope.builtin')
vim.keymap.set("n", "<C-p>", telescope.find_files, {})
vim.keymap.set("n", "<Leader>fg", telescope.live_grep, {})
vim.keymap.set("n", "<Leader>fb", telescope.buffers, {})
vim.keymap.set("n", "<Leader>fh", telescope.help_tags, {})
