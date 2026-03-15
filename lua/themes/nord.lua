return {
    "shaunsingh/nord.nvim",
    priority = 1000,
    config = function()
        require("nord").set()
        vim.cmd.colorscheme("nord")
    end,
}
