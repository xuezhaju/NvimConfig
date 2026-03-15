return {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    priority = 1000,
    config = function()
        vim.g.moonflyTerminalColors = true
        vim.g.moonflyUndercurls = true
        vim.g.moonflyUnderlineMatchParen = true
        vim.g.moonflyTransparent = false
        vim.cmd.colorscheme("moonfly")
    end,
}
