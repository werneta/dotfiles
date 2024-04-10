-- From: https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Telescope (fuzzy finder)
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.1",
        dependencies = {"nvim-lua/plenary.nvim"}
    }, -- treesitter
    {"nvim-treesitter/nvim-treesitter", build = ':TSUpdate'},
    "hiphish/rainbow-delimiters.nvim", -- lsp-zero
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'}, -- Required
            {
                'williamboman/mason.nvim',
                build = function() pcall(vim.cmd, 'MasonUpdate') end
            }, {'williamboman/mason-lspconfig.nvim'},
            {'WhoIsSethDaniel/mason-tool-installer.nvim'}, -- Autocompletion
            {'hrsh7th/nvim-cmp'}, -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'} -- Required
        }
    }, -- PGP support
    "jamessan/vim-gnupg", -- undotree
    "mbbill/undotree", -- fugitive
    "tpope/vim-fugitive", -- git gutter
    "lewis6991/gitsigns.nvim", -- Catppuccino color scheme
    {"catppuccin/nvim", name = "catppuccin"}, -- airline
    "vim-airline/vim-airline", "vim-airline/vim-airline-themes",

    "lervag/vimtex", -- VimTeX
    "werneta/baycomb", -- baycomb color scheme
    "mhartington/formatter.nvim" -- formatter tool support
})
