require("formatter").setup {
    filetype = {
        -- Run the "black" autoformatter on python files
        python = {
            require("formatter.filetypes.python").black
        }
    }
}

-- Call the formatters on save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = "*",
    command = ":FormatWrite"
})
