return {
    "Mofiqul/dracula.nvim",
    priority = 1000,
    config = function()
        require("dracula").setup({
            transparent_bg = false,
            show_end_of_buffer = false,
            italic_comment = true,
            overrides = {},
        })
        vim.cmd.colorscheme("dracula")
    end,
}
