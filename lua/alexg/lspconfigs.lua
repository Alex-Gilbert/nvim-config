local lsp = require('lsp-zero').preset({})
local c = require('lspconfig')

return {
    lsp.default_setup,
    csharp_ls = function()
        c.csharp_ls.setup({
            on_attach = function ()
                print('Hello From C Sharp')
            end,
            filetypes = {"cs"},
            root_dir = function (startpath)
                return c.util.root_pattern("*.sln")(startpath)
                    or c.util.root_pattern("*.csproj")(startpath)
                    or c.util.root_pattern("*.fsproj")(startpath)
                    or c.util.root_pattern(".git")(startpath)
            end,
            init_options =
                {
                    AutomaticWorkspaceInit = true
                }
        })
    end
}
