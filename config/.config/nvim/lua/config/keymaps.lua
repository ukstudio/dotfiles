vim.g.mapleader = " "

vim.keymap.set("n", "<Leader>w", ":<C-u>write<Cr>")
vim.keymap.set("n", "<Leader>q", ":<C-u>quit<Cr>")
vim.keymap.set("n", "<Leader>b", "<C-^>")

local wk = require("which-key")

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

local wk = require("which-key")
local neotest = require("neotest")

wk.add({
  { "<C-p>", telescope.find_files, desc = "Find files" },
  { "<leader>f", group = "file" },
  { "<leader>fb", telescope.buffers, desc = "Find buffers" },
  { "<leader>ff", telescope.find_files, desc = "Find files" },
  { "<leader>fg", telescope.grep_string, desc = "Searches for the string under the cursor" },
  { "<leader>fl", telescope.live_grep, desc = "Live grep" },
  { "t", group = "test" },
  { "<leader>tf", function() require("neotest").run.run(vim.fn.expand('%')) end, desc = "Test a spec file" },
  { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show output" },
  { "<leader>tr", function() require("neotest").run.run() end, desc = "Test nearest spec" },
  { "<leader>aa", function() require("avante.api").ask() end, desc = "avante: ask" },
  { "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit" },
  { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    --vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    --vim.keymap.set('n', '<space>wl', function()
    --  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    --end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    --vim.keymap.set('n', '<space>f', function()
    --  vim.lsp.buf.format { async = true }
    --end, opts)
  end,
})
