return {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
        require("onedark").setup({
            style = "dark",           -- 可选: dark, darker, cool, deep, warm, warmer, light
            transparent = false,
            term_colors = true,
            ending_tildes = false,
            code_style = {
                comments = "italic",
                keywords = "none",
                functions = "none",
                strings = "none",
                variables = "none",
            },
        })
        require("onedark").load()
    end,
}
