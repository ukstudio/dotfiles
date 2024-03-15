local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "morhetz/gruvbox",
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }},
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "neovim/nvim-lspconfig",
})

require("lspconfig").ruby_ls.setup {}

local cmp = require("cmp")
cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-l>"] = cmp.mapping.complete(),
    ["<Cr>"] = cmp.mapping.confirm { select = true },
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
  })
})
