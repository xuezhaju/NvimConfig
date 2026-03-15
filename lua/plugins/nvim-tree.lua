return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {
                width = 30,
                side = "left",
            },
            renderer = {
                group_empty = true,
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                        folder = true,
                        file = true,
                    },
                },
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = true,
            },
        })
        
        vim.keymap.set("n", "<leader>ft", ":NvimTreeToggle<CR>", { desc = "切换文件树" })
        vim.keymap.set("n", "<leader>E", ":NvimTreeFocus<CR>", { desc = "聚焦文件树" })
        vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { desc = "刷新文件树" })
    end,
}
