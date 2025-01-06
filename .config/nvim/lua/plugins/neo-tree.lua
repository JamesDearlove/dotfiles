return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
                source_selector = {
                    winbar = true,
                    statusline = false,
                    sources = { 
                        { source = "filesystem" }, 
                        { source = "git_status" }, 
                        { source = "document_symbols" },
                    },
                }
            })
    end,
}
