local cmp = require('cmp')
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "<leader>pws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>pd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>prn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>psr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.confirm({select = true}),
})

cmp.setup({
    mapping = cmp_mappings
})
