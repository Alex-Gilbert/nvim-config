return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    event = "VeryLazy",
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "/mnt/obsidian-vault",
            },
        },
        templates = {
            subdir = "my-templates",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H:%M",
        },
        -- see below for full list of options 👇
    },
}
