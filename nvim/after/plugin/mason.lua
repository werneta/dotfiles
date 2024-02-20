require("mason").setup({})

require("mason-tool-installer").setup({
    ensure_installed = {
        "actionlint",       -- GH action files
        "bibtex-tidy",      -- bibtex files
        "black",            -- python
        "clang-format",     -- C and co
        "fixjson",          -- JSON
        "htmlbeautifier",   -- HTML
        "htmlhint",         -- HTML
        "latexindent",      -- latex
        "luacheck",         -- lua
        "luaformatter",     -- lua
        "remark-cli",       -- markdown
        "rstcheck",         -- restructured text
        "rustfmt",          -- rust
        "shellcheck",       -- shell
        "standardjs",       -- javascript
        "verible",          -- systemverilog
        "xmlformatter",     -- XML
        "yamlfix",          -- YAML
        "yamllint",         -- YAML
    }
})

local lsp_zero = require("lsp-zero")
require("mason-lspconfig").setup({
    ensure_installed = {
        "als",                  -- ada
        "bashls",               -- bash
        "clangd",               -- C/C++
        "esbonio",              -- sphinx/rst
        "hls",                  -- Haskell, requires ghcup
        "html",                 -- HTML
        "pylsp",                -- python
        "jsonls",               -- JSON
        "julials",              -- julia
        "lua_ls",               -- lua
        "matlab_ls",            -- matlab
        "remark_ls",            -- markdown
        "rust_analyzer",        -- rust, requires rustup
        "svelte",               -- Svelte
        "texlab",               -- latex
        "yamlls",               -- yaml
    },
    handlers = {
        lsp_zero.default_setup,
    }
})
