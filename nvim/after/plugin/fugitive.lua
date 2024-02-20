vim.keymap.set("n", "<leader>gb", function() vim.cmd.Git("blame") end)
vim.keymap.set("n", "<leader>gd", vim.cmd.Gdiffsplit)
vim.keymap.set("n", "<leader>gp", function() vim.cmd.Git("push") end)
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
