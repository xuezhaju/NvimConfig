return {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
        require("everforest").setup({
            background = "medium",   -- 可选: "soft", "medium", "hard"
            transparent_background_level = 0,
            italics = true,
            disable_italic_comments = false,
            sign_column_background = "none",
            ui_contrast = "low",
            dim_inactive_windows = false,
            diagnostic_text_highlight = false,
            diagnostic_virtual_text = "coloured",
            diagnostic_line_highlight = false,
            spell_foreground = false,
            show_eob = true,
            float_style = "bright",
            inlay_hints_background = "none",
        })
        vim.o.background = "dark"
        vim.cmd.colorscheme("everforest")
    end,
}
