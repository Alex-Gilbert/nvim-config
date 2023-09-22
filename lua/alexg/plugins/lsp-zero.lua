local function lspzero_config()
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
        local opts = {buffer = bufnr}

        vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gD", function () vim.lsp.buf.declaration() end, opts)
        vim.keymap.set("n", "gi", function () vim.lsp.buf.implementation() end, opts)
        vim.keymap.set("n", "gs", function () vim.lsp.buf.signature_help() end, opts)

        vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, opts)

        vim.keymap.set("n", "[d", function () vim.diagnostics.goto_prev() end, opts)
        vim.keymap.set("n", "]d", function () vim.diagnostics.goto_next() end, opts)

        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true})
    end)

    lsp.extend_cmp()
    require('cmp').setup(require('alexg.cmp'))
    
    require('mason').setup()
    require('mason-lspconfig').setup({
        -- Replace the language servers listed here 
        -- with the ones you want to install
        ensure_installed = {'rust_analyzer'},
        handlers = require('alexg.lspconfigs'),
    })
end

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'dev-v3',
    dependencies = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required
        {'hrsh7th/cmp-buffer'},       -- Optional
        {'hrsh7th/cmp-path'},         -- Optional
        {'saadparwaiz1/cmp_luasnip'}, -- Optional
        {'hrsh7th/cmp-nvim-lua'},     -- Optional

        -- Snippets
        {'L3MON4D3/LuaSnip'},             -- Required
        {'rafamadriz/friendly-snippets'}, -- Optional
    },
    config = lspzero_config,
}
