-- ~/.config/nvim/lua/plugins/lualine.lua
return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
        require("lualine").setup({
            -- lualine.lua 的 options 部分替换为：
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },  -- 添加箭头分隔符
                disabled_filetypes = {
                    statusline = { "NvimTree", "alpha" },
                },
                always_divide_middle = true,
                globalstatus = false,
            },
            sections = {
                lualine_a = { "mode" },                    -- 模式（正常/插入等）
                lualine_b = { 
                    "branch",                               -- git 分支
                    "diff",                                 -- git 改动
                    {
                        "diagnostics",                      -- LSP 错误/警告
                        sources = { "nvim_lsp" },
                        sections = { "error", "warn", "info", "hint" },
                        symbols = { 
                            error = " ", 
                            warn = " ", 
                            info = " ", 
                            hint = " " 
                        },
                        colored = true,
                    },
                },
                lualine_c = {
                    {
                        "filename",                         -- 文件名
                        file_status = true,                 -- 显示 [RO] 只读状态
                        path = 1,                            -- 0: 仅文件名, 1: 相对路径
                    },
                },
                lualine_x = {
                    "encoding",                             -- 文件编码
                    "fileformat",                           -- 文件格式 (unix/dos)
                    "filetype",                              -- 文件类型
                },
                lualine_y = { "progress" },                  -- 进度 (行数百分比)
                lualine_z = { "location" },                  -- 位置 (行:列)
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "nvim-tree", "telescope" },
        })
    end,
}
