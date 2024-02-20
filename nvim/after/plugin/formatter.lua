-- Updates the default clang style to use 4-space indentation
local clangformat_def = require("formatter.defaults").clangformat
local clangformat = function()
    local fmt = clangformat_def()
    table.insert(fmt["args"], '--style="{BasedOnStyle: llvm, IndentWidth: 4}"')

    return fmt
end

-- From: https://github.com/mhartington/formatter.nvim?tab=readme-ov-file#configure
require("formatter").setup({
    filetype = {
        c = {clangformat},
        cpp = {clangformat},
        html = {require("formatter.filetypes.html").prettier},
        javascript = {require("formatter.filetypes.javascript").prettier},
        latex = {require("formatter.filetypes.latex").latexindent},
        lua = {require("formatter.filetypes.lua").luaformat},
        markdown = {require("formatter.filetypes.markdown").prettier},
        python = {require("formatter.filetypes.python").black},
        rust = {require("formatter.filetypes.rust").rustfmt},
        sh = {require("formatter.filetypes.sh").shfmt},
        svelte = {require("formatter.filetypes.svelte").prettier},
        xml = {require("formatter.filetypes.xml").xmlformat},
        yaml = {require("formatter.filetypes.yaml").prettier},
        ["*"] = {require("formatter.filetypes.any").remove_trailing_whitespace}
    }
})

-- Call the formatters on save
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", {clear = true})
autocmd("BufWritePost", {group = "__formatter__", command = ":FormatWrite"})
