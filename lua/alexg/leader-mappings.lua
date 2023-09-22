local mappings = {

	["a"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Mark File" },  -- Close current file
	["e"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Open Harpoon Menu" },  -- Close current file
	["x"] = { "<cmd>bdelete<CR>", "Kill Buffer" },  -- Close current file
	["l"] = { "<cmd>Lazy<CR>", "Lazy Plugin Manager" }, -- Invoking plugin manager
	["q"] = { "<cmd>wqall!<CR>", "Quit" }, -- Quit Neovim after saving the file
	["w"] = { "<cmd>w!<CR>", "Save" }, -- Save current file
    ["m"] = { "<cmd>Mason<cr>", "Mason UI for Lsp" },
    ["u"] = { "<cmd>Telescope undo<cr>", "Undo Tree" },
    ["i"] = { "~hi", "Change Case Insert" },

    ["/"] = {
        function()
            require("Comment.api").toggle.linewise.current()
        end,
        "Toggle comment"},

    p = {
        name = "Project",
        v = { "<cmd>Oil<cr>", "Explore"},
        f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find Files"},
        r = { "<cmd>lua require('telescope.builtin').registers()<cr>", "Find Files"},
        s = { "<cmd>Telescope live_grep<cr>", "Search in Files"},
    },

    c = {
        name = "Code",
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Float Diagnostic" },
        f = { "<cmd>lua vim.lsp.buf.format({async=true})<cr>", "Format Code" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },

    t = {
        name = "Tree Explorer",
        t = { "<cmd>Neotree float<cr>", "Toggle Tree" },
        h = { "<cmd>Neotree close float<cr>", "Hide Tree" },
        d = { "<cmd>Neotree float reveal_force_cwd<cr>", "Find File in Tree" },
    },

    g = {
        name = "Git",
        g = { "<cmd>Git<CR>", "Git"},
    },

    s = {
        name = "Split",
        h = {"<cmd>vertical leftabove split<CR><cmd>Oil<CR>", "Split Left"},
        j = {"<cmd>horizontal belowright split<CR><cmd>Oil<CR>", "Split Down"},
        k = {"<cmd>horizontal leftabove split<CR><cmd>Oil<CR>", "Split Up"},
        l = {"<cmd>vertical belowright split<CR><cmd>Oil<CR>", "Split Right"},
        s = {"<cmd>clo<CR>", "Close Split"},
        H = {"<cmd>vertical leftabove split<CR><cmd>terminal<CR>", "Open Terminal Left"},
        J = {"<cmd>horizontal belowright split<CR><cmd>terminal<CR>", "Open Terminal Down"},
        K = {"<cmd>horizontal leftabove split<CR><cmd>terminal<CR>", "Open Terminal Up"},
        L = {"<cmd>vertical belowright split<CR><cmd>terminal<CR>", "Open Terminal Right"},
    }
}
return mappings